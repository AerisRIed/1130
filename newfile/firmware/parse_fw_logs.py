#!/usr/bin/env python3
"""
Firmware Log Parser

Parses firmware log dumps from DV simulation environment.
Decodes hex log entries and merges multiple UC logs into a single output.

Log format: [timestamp] 0xFFFLLLPP (32-bit value)
  - FFF: File ID (bits 31-27, 5 bits)
  - LLL: Line number (bits 26-16, 11 bits)
  - PPPP: Payload (bits 15-0, 16 bits)
"""

import os
import re
import sys
import argparse
from typing import List, Tuple, Optional
from dataclasses import dataclass


@dataclass
class LogEntry:
    """Represents a parsed log entry"""
    timestamp_ns: float
    uc_type: str
    file_id: int
    file_name: str
    line_number: int
    parameter: int
    raw_value: int


# File ID mappings for Top UC (from u4_fw_top/hdr/debug.h)
TOP_UC_FILE_IDS = {
    0: "top_main",
    1: "phy_mgt",
    2: "lane_mgt",
    3: "api",
    4: "register_functions",
    5: "start_of_day",
    6: "tick",
    7: "utilities",
    8: "pg_csv_impl",
    9: "programmers_guide",
}

# File ID mappings for Lane UC (from u4_fw_ln/hdr/debug.h)
LANE_UC_FILE_IDS = {
    0: "phy_lane_main",
    1: "lane_mgt",
    2: "api",
    3: "rx_adapt_fsm",
    4: "rx_adapt_hw_control",
    5: "rx_samp_hw_control",
    6: "rx_adapt_params",
    7: "rx_adapt_strategy_a",
    8: "utils",
    9: "register_functions",
}

# Default paths
DEFAULT_INPUT_FOLDER = "./sim_logs"
DEFAULT_OUTPUT_FOLDER = "./parsed_logs"

# Expected log file names
LOG_FILES = {
    "top_uc": "fw_log_top_uc.txt",
    "ln01_uc": "fw_log_ln01_uc.txt",
    "ln23_uc": "fw_log_ln23_uc.txt",
}


def parse_hex_log_value(hex_value: int) -> Tuple[int, int, int]:
    """
    Parse hex log value to extract file ID, line number, and payload.

    Format (from debug.h LOG_PACK macro):
      bits [31:27] : file_id (5 bits, supports 32 files)
      bits [26:16] : line_num (11 bits, supports 2048 lines per file)
      bits [15:0]  : payload (16 bits, user data)

    Args:
        hex_value: 32-bit hex value from log

    Returns:
        Tuple of (file_id, line_number, payload)
    """
    file_id = (hex_value >> 27) & 0x1F       # bits [31:27], 5 bits
    line_number = (hex_value >> 16) & 0x7FF  # bits [26:16], 11 bits
    payload = hex_value & 0xFFFF             # bits [15:0], 16 bits

    return file_id, line_number, payload


def get_file_name(file_id: int, uc_type: str) -> str:
    """
    Get file name from file ID based on UC type.

    Args:
        file_id: Numeric file ID
        uc_type: UC type ("top_uc", "ln01_uc", or "ln23_uc")

    Returns:
        File name string or "UNKNOWN_FILE"
    """
    if uc_type == "top_uc":
        return TOP_UC_FILE_IDS.get(file_id, f"UNKNOWN_FILE_{file_id}")
    else:
        return LANE_UC_FILE_IDS.get(file_id, f"UNKNOWN_FILE_{file_id}")


def parse_log_file(file_path: str, uc_type: str) -> List[LogEntry]:
    """
    Parse a single firmware log file.

    Args:
        file_path: Path to log file
        uc_type: UC type identifier

    Returns:
        List of parsed LogEntry objects
    """
    entries = []

    # Regex pattern to match log lines: [timestamp] hex_value
    pattern = re.compile(r'\[([0-9.]+)(?:ns)+\]\s+(0x[0-9A-Fa-f]+)')

    try:
        with open(file_path, 'r') as f:
            for line_num, line in enumerate(f, 1):
                match = pattern.search(line)
                if match:
                    timestamp_str = match.group(1)
                    hex_str = match.group(2)

                    try:
                        timestamp_ns = float(timestamp_str)
                        raw_value = int(hex_str, 16)

                        # Skip empty log entries (0x00000000)
                        if raw_value == 0:
                            continue

                        # Parse hex value
                        file_id, line_number, parameter = parse_hex_log_value(raw_value)
                        file_name = get_file_name(file_id, uc_type)

                        entry = LogEntry(
                            timestamp_ns=timestamp_ns,
                            uc_type=uc_type,
                            file_id=file_id,
                            file_name=file_name,
                            line_number=line_number,
                            parameter=parameter,
                            raw_value=raw_value
                        )
                        entries.append(entry)

                    except (ValueError, OverflowError) as e:
                        print(f"Warning: Failed to parse line {line_num} in {file_path}: {e}")
                        continue

    except FileNotFoundError:
        print(f"Error: File not found: {file_path}")
        return []
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
        return []

    return entries


def format_log_entry(entry: LogEntry) -> str:
    """
    Format a log entry for output.

    Args:
        entry: LogEntry object

    Returns:
        Formatted string
    """
    timestamp_us = entry.timestamp_ns / 1000.0

    # Format: [timestamp_us] UC_TYPE | FILE:LINE | payload=0xPPPP | raw=0xRAWVALUE
    return (f"[{timestamp_us:12.3f}us] {entry.uc_type:10s} | "
            f"{entry.file_name:30s}:{entry.line_number:5d} | "
            f"payload=0x{entry.parameter:04x} | raw=0x{entry.raw_value:08x}")


def group_logs_by_uc(all_entries: List[LogEntry]) -> dict:
    """
    Group log entries by UC type (keeping them separate in raw order).

    Args:
        all_entries: Combined list of all log entries

    Returns:
        Dictionary with UC type as key and entries in raw order as value
    """
    grouped = {}
    for entry in all_entries:
        if entry.uc_type not in grouped:
            grouped[entry.uc_type] = []
        grouped[entry.uc_type].append(entry)

    return grouped


def write_output(grouped_entries: dict, output_path: str) -> None:
    """
    Write parsed log entries to output file, grouped by UC type.

    Args:
        grouped_entries: Dictionary of entries grouped by UC type
        output_path: Output file path
    """
    try:
        os.makedirs(os.path.dirname(output_path), exist_ok=True)

        total_entries = sum(len(entries) for entries in grouped_entries.values())

        with open(output_path, 'w') as f:
            # Write main header
            f.write("=" * 120 + "\n")
            f.write("USB4 PHY Firmware Log - Parsed Output\n")
            f.write("=" * 120 + "\n")
            f.write(f"Total Entries: {total_entries}\n")
            f.write(f"UC Types: {', '.join(grouped_entries.keys())}\n")
            f.write("=" * 120 + "\n\n")

            # Write entries for each UC type
            uc_order = ["top_uc", "ln01_uc", "ln23_uc"]
            for uc_type in uc_order:
                if uc_type not in grouped_entries:
                    continue

                entries = grouped_entries[uc_type]

                # UC section header
                f.write("\n" + "#" * 120 + "\n")
                f.write(f"### {uc_type.upper()} LOGS ###\n")
                f.write("#" * 120 + "\n")
                f.write(f"Entries: {len(entries)}\n")
                f.write("-" * 120 + "\n\n")

                # Write entries
                for entry in entries:
                    f.write(format_log_entry(entry) + "\n")

                # UC section footer
                f.write("\n" + "-" * 120 + "\n")
                f.write(f"End of {uc_type} logs - {len(entries)} entries\n")
                f.write("-" * 120 + "\n\n")

            # Write final footer
            f.write("\n" + "=" * 120 + "\n")
            f.write(f"End of all logs - {total_entries} total entries processed\n")
            f.write("=" * 120 + "\n")

        print(f"\nOutput written to: {output_path}")
        print(f"Total entries: {total_entries}")

    except Exception as e:
        print(f"Error writing output file: {e}")
        sys.exit(1)


def main():
    """Main function"""
    parser = argparse.ArgumentParser(
        description='Parse USB4 PHY firmware logs from DV simulation',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Use default paths
  python parse_fw_logs.py

  # Specify input and output folders
  python parse_fw_logs.py -i ./my_sim_logs -o ./my_output

  # Specify only input folder
  python parse_fw_logs.py -i /path/to/logs
"""
    )

    parser.add_argument('-i', '--input',
                        default=DEFAULT_INPUT_FOLDER,
                        help=f'Input folder containing log files (default: {DEFAULT_INPUT_FOLDER})')

    parser.add_argument('-o', '--output',
                        default=DEFAULT_OUTPUT_FOLDER,
                        help=f'Output folder for parsed logs (default: {DEFAULT_OUTPUT_FOLDER})')

    args = parser.parse_args()

    input_folder = args.input
    output_folder = args.output

    print("=" * 80)
    print("USB4 PHY Firmware Log Parser")
    print("=" * 80)
    print(f"Input folder:  {input_folder}")
    print(f"Output folder: {output_folder}")
    print("=" * 80)

    # Check if input folder exists
    if not os.path.exists(input_folder):
        print(f"\nError: Input folder does not exist: {input_folder}")
        sys.exit(1)
    # Create output folder if it doesn't exist
    if not os.path.exists(output_folder):
        print(f"\nCreating output folder: {output_folder}")
        try:
            os.makedirs(output_folder, exist_ok=True)
        except Exception as e:
            print(f"Error: Failed to create output folder: {e}")
            sys.exit(1)
    # Parse each log file
    all_entries = []
    files_found = []
    files_not_found = []

    for uc_type, log_filename in LOG_FILES.items():
        log_path = os.path.join(input_folder, log_filename)

        if os.path.exists(log_path):
            print(f"\nProcessing {log_filename} ({uc_type})...")
            entries = parse_log_file(log_path, uc_type)

            if entries:
                all_entries.extend(entries)
                files_found.append(log_filename)
                print(f"  -> Parsed {len(entries)} entries")
            else:
                print(f"  -> No valid entries found")
        else:
            files_not_found.append(log_filename)
            print(f"\nNotification: {log_filename} not found (skipping)")

    # Summary
    print("\n" + "=" * 80)
    print("Summary:")
    print(f"  Files found: {len(files_found)}")
    for f in files_found:
        print(f"    - {f}")

    if files_not_found:
        print(f"  Files not found: {len(files_not_found)}")
        for f in files_not_found:
            print(f"    - {f}")

    if not all_entries:
        print("\nError: No log entries found in any file")
        sys.exit(1)

    # Group logs by UC type
    print(f"\nGrouping {len(all_entries)} total entries by UC type...")
    grouped_entries = group_logs_by_uc(all_entries)

    # Write output
    output_filename = "fw_logs_merged.txt"
    output_path = os.path.join(output_folder, output_filename)

    print(f"Writing output to {output_path}...")
    write_output(grouped_entries, output_path)

    print("\n" + "=" * 80)
    print("Log parsing complete!")
    print("=" * 80)


if __name__ == "__main__":
    main()
