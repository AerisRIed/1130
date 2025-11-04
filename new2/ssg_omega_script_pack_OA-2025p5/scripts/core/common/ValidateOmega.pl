#!/usr/bin/env perl
################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

use strict;
use warnings;
use FileHandle;
use Getopt::Long;
use Carp;
use Cwd;
use POSIX;
use English;
use Data::Dumper;
use File::Path;
use File::Copy;
use File::Basename;
use File::Spec::Functions qw(:ALL);
use FindBin qw($RealBin);
use lib $RealBin;
use Cwd qw(abs_path);
use CoreUtils;

#########################################################
# Setup and documentation                               #
#########################################################
my $script_options = "@ARGV";
my $help = 0;
my $ret;
my $pwd = cwd();
my $dir = "";
my $disable_tool = "";
my $signoff = 0;
my $nopush = 0;
my @tools = ('clp_comp', 'clp_lint', 'jasper_cdc', 'jasper_mcp', 'jasper_superlint', 'jasper_xprop', 'joules_flow1', 'joules_flow2', 'joules_flow3', 'litmus1');
my %toolname_map = (
  "clp_comp" => "CLP Compare",
  "clp_lint" => "CLP Lint",
  "jasper_cdc" => "Jasper CDC",
  "jasper_mcp" =>  "Jasper MCP",
  "jasper_superlint" =>  "Jasper Superlint",
  "jasper_xprop" => "Jasper XPROP",
  "joules_flow1" => "Joules Flow 1",
  "joules_flow2" => "Joules Flow 2",
  "joules_flow3" => "Joules Flow 3",
  "litmus1" => "Litmus",
);
my @tools_to_score = ('clp_comp', 'clp_lint', 'jasper_cdc', 'jasper_mcp', 'jasper_superlint', 'jasper_xprop', 'joules_flow3', 'litmus1');
my $score_per_tool = sprintf("%.2f", 100/($#tools_to_score+1));
my $datestamp = `date +%m%d%Y_%H%M%S`;
chomp($datestamp);

my $usage = "
$0 [options]

This script will analyze the available reports and logs from Litmus, Joules, CLP and Jasper.
The script will generate metrics in CSV and print a percentage representing the RTL quality.

-dir              The user can use a specific dir for each tool. The syntax for this parameter is
                  \"<tool> <directory> <tool2> <directory2> ...\". Tool can be ".join(', ',@tools).".
                  If nothing is generated, the tool will search for the default directories generated
                  by the tools (ex. clp_lint_run_<date>)

-disable_tool     The user can disable a tool if it doesn't need to run. For example,
                  if the design doesn't contain a CDC, the user might want to avoid
                  running jasper_cdc.
                  When excluding a tool, the same won't be consider in the scoring system.
                  Multiple tools can be disabled, using:
                  -disable_tool \"jasper_cdc joules_flow1 litmus1\"

-signoff          Final delivery must be run using -signoff.
                  Final signoff will check if Litmus, CLP Lint, Jasper Superlint, Jasper CDC
                  and Joules Flow 3 were run.

-nopush           Won't push metrics to MongoDB. By default, all metrics written on omega_metrics.csv are pushed.

";

$ret = GetOptions(
    "help" => \$help,
    "dir=s" => \$dir,
    "signoff" => \$signoff,
    "nopush" => \$nopush,
    "disable_tool=s" => \$disable_tool);

if ($help || ! $ret) {
  print "$usage";
  exit;
}


our %directory;
our $tool;
our $score = 0;
our $tech_process_dir = "";

my $workdir = "$pwd/" . "output_validation_" . $datestamp;
mkpath "$workdir";

my $teelog = $workdir."/omega_validation_report.txt";
my $tee_fp = new FileHandle ($teelog, '>');
die "$0: $! - Cannot create $teelog\n" unless defined $tee_fp;

my $metrics_filename = $workdir."/omega_metrics.csv";
my $summary_filename = $workdir."/omega_summary.txt";

CoreUtils::DualPrint($tee_fp,"Running:\n$0 $script_options\n");

if ($dir ne "") {
  my @splitdir = split(/ /, $dir);
  if ($#splitdir % 2 == 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: -dir need an even number of strings (<tool> <directory> <tool2> <directory2> ...).\n");
    exit;
  } else {
    for (my $i=0; $i < $#splitdir; $i+=2) {
      if (grep(/^$splitdir[$i]$/, @tools)) {
        $directory{$splitdir[$i]} = $splitdir[$i+1];
      } else {
        CoreUtils::DualPrint($tee_fp,"\nError: $splitdir[$i] doesn't exist. -dir needs to use ".join(', ',@tools)."\n");
        exit;
      }
      if (! -d $splitdir[$i+1]) {
        CoreUtils::DualPrint($tee_fp,"\nError: $splitdir[$i+1] doesn't exist. Please change -dir.\n");
        exit;
      }
    }
  }
}

my $pythonExe = which_exe("python3");
if (!$nopush) {
  if ($pythonExe eq "0") {
    CoreUtils::DualPrint($tee_fp,"\nError: python3 binary not found in PATH environment variable.\nPython is needed to push metrics to MongoDB, please add python3 binary to PATH environment variable or run again using \"-nopush\".\n");
    exit;
  }
}

if ($signoff) {
  CoreUtils::DualPrint($tee_fp, "\nRunning ".basename($0)." in Signoff Mode.");
}

if ($disable_tool ne "") {
  my @disable_tools = split(/ /, $disable_tool);
  foreach my $d (@disable_tools) {
    if (! (grep (/^$d$/, @tools))) {
      CoreUtils::DualPrint($tee_fp,"\n$d doesn't exist. -disable_tool needs to use ".join(', ',@tools)."\n");
      exit;
    }
  }

  if ($signoff) {
    my $required_tools = "clp_lint|jasper_superlint|jasper_xprop|joules_flow3|litmus1";
    $tool = "litmus1";
    my $workdir = &folder_check("litmus1_run_*");
    my $constraint_file = abs_path(<$workdir/collateral/*_flattened.sdc>);
    my $find_cdc = 0;
    my $find_mcp = 0;
    if (! defined $constraint_file || ! -f $constraint_file) {
      CoreUtils::DualPrint($tee_fp,"\nError: Litmus didn't generate a flat constraint file. Litmus is a requirement to be run when using Signoff Mode.");
      exit;
    } else {
      CoreUtils::DualPrint($tee_fp,"\nChecking the existence of CDC or MCP using $constraint_file.");
      open(CONFILE,"<$constraint_file") or die ("Cannot open ${constraint_file}.\n");
      while(<CONFILE>) {
        if ($_ =~ /^set_clock_groups -async/) {
          $find_cdc = 1;
        }
        if ($_ =~ /^set_multicycle_path/) {
          $find_mcp = 1;
        }
        if ($_ =~ /^set_false_path/) {
          $find_mcp = 1;
        }
      }
      close(CONFILE);
    }
    if ($find_cdc) {
      CoreUtils::DualPrint($tee_fp,"\nFound the existence of CDC.");
      $required_tools = $required_tools."|jasper_cdc";
    }
    if ($find_mcp) {
      CoreUtils::DualPrint($tee_fp,"\nFound the existence of MCP.");
      $required_tools = $required_tools."|jasper_mcp";
    }
    my @grep_signoff = grep (/$required_tools/, @disable_tools);
    if (scalar @grep_signoff != 0) {
      CoreUtils::DualPrint($tee_fp, join(', ', @grep_signoff)." needs to be run when running in Signoff Mode.");
      exit;
    }
  }

  my %to_remove = map {$_ => 1} @disable_tools;
  @tools = grep {!$to_remove{$_}} @tools;
  @tools_to_score = grep {!$to_remove{$_}} @tools_to_score;
  CoreUtils::DualPrint($tee_fp,"\n".basename($0)." will exclude ".join(', ',@disable_tools)." from the analysis.\n");

  $score_per_tool = sprintf("%.2f", 100/($#tools_to_score + 1));
}

open(MFILE, '>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
print MFILE "metric;value\n";
close(MFILE);

open(SFILE, '>', $summary_filename) or die ("Cannot open $summary_filename.\n");
print SFILE "Signoff: ";
if ($signoff) {
  print SFILE "yes\n";
} else {
  print SFILE "no\n";
}
print SFILE "DB push: ";
if ($nopush) {
  print SFILE "no\n";
} else {
  print SFILE "yes\n";
}
printf SFILE "\n%-25s %-20s %-20s\n", "Flow", "#Errors", "Status";
printf SFILE "-----------------------------------------------------\n";
foreach my $d (split(/ /,$disable_tool)) {
  printf SFILE "%-25s %-20s %-20s\n", $d, "N/A", "Skipped by user";
}
close(SFILE);

foreach $tool (@tools) {
  my $subname = $tool."_check";
  CoreUtils::DualPrint($tee_fp,"\n==================================================================\n");
  CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} ($tool) reports and logs."); 
  &{\&{$subname}}();
  if (grep (/^$tool$/, @tools_to_score)) {
    if ($score > 100.00) {
      $score = 100.00;
    }
#    CoreUtils::DualPrint($tee_fp,"\nCurrent score: $score / 100.00\n");
  } else {
#    CoreUtils::DualPrint($tee_fp,"\n$toolname_map{$tool} ($tool) is not considered for score calculation.\n");
  }
}

if (!$nopush) {
  print "\nPushing metrics to MongoDB\n";
  my $dir = dirname(abs_path($0));
  my $cmd = system("$pythonExe $dir/mongodb_omega.py $workdir/omega_metrics.csv");
}

sub jasper_cdc_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/jg_cdc_run.log");
  my $log_errors = &log_errors($tool_log);
  my @report_errors = ();
  my ($loc_tag,$loc_severity,$loc_checks,$loc_waived,$loc_total,$loc_info) = ("","",0,0,0,0);
  my ($tot_error, $tot_warn, $tot_waived,$tot_info,$tot_error_waived,$tot_warn_waived) = (0,0,0,0,0,0);
  my ($total_problem_count,$total_problem_count_unwaived) = (0,0);
  my ($number_gates, $number_flops) = (0,0);
  my $rule_summary_report = abs_path(<${workdir}/report/*all_cdc_violations_summary.txt>);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} reporting was unsuccessful. Failed to detect ${workdir}/report/*all_cdc_violations_summary.txt violation summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    while(<SUMFILE>) {
      if ($_ =~ /^\s*Tag\s+\|\s+Severity\s+\|\s+Checks/) {
        until (($_ =~ /\*\*\*\*\*/) || (eof)) {
          $_ = <SUMFILE>;
          if ($_ =~ /^\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
            $loc_tag = $1;
            if ($loc_tag ne "Total") {
              $loc_severity = $2;
              $loc_checks = $3;
              $loc_waived = $4;
              $loc_total = $5;
              if ($loc_severity eq "Error") {
                $tot_error += $loc_checks;
                if ($loc_waived > 0) {
                  $tot_error_waived += $loc_waived;
                }
              } elsif ($loc_severity eq "Warning") {
                $tot_warn += $loc_checks;
                if ($loc_waived > 0) {
                  $tot_warn_waived += $loc_waived;
                }
              } elsif ($loc_severity eq "Info") {
                $tot_info += $loc_checks;
              }
              $tot_waived += $loc_waived;
              $total_problem_count += ($loc_checks + $loc_waived);
              $total_problem_count_unwaived += $loc_checks;
            }
          }
        }
      }
    }
    if ($total_problem_count_unwaived > 0) {
      push (@report_errors, $rule_summary_report);
    }
    close(SUMFILE);
  }
  $rule_summary_report = abs_path(<${workdir}/report/*_cdc_run_setup.txt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} reporting was unsuccessful. Failed to detect ${workdir}/report/*_cdc_run_setup.txt violation summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    while(<SUMFILE>) {
      if ($_ =~ /Number of Gates/) {
        $_ = <SUMFILE>;
        $_ = <SUMFILE>;
        if ($_ =~ /^\s*(\S+)\s+(\S+)/) {
          $number_gates = $1;
          $number_flops = $2;
          last;
        }
      }
    }
    close(SUMFILE);
  }
  my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
  open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
  my %vars;
  while(<UVAR>) {
    # Remove comments
    $_ =~ s/^\s*#.*//;
    $_ =~ s/\s+#.*$//;
    if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
      my ($varname, $varvalue) = ($1, $2);
      $varvalue =~ s/^["{]|["}]$//g;
      $vars{$varname} = $varvalue;
    }
  }
  close(UVAR);
  my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../../README.txt | awk '{print \$3}'`;
  chomp($flow_version);
  my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
  my $uid = (stat $workdir)[4];
  my $workdiruser = (getpwuid $uid)[0];
  print MFILE "$tool.run_area;$workdir\n";
  print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
  print MFILE "$tool.global_dir;$global_dir\n";
  print MFILE "$tool.flow_version;$flow_version\n";
  print MFILE "$tool.design;$vars{top_design}\n";
  print MFILE "$tool.user;$workdiruser\n";
  open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
  if ($total_problem_count_unwaived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper CDC validation shows a total of $total_problem_count_unwaived unwaived error/warning/info messages. Review the following file: ".join(', ',@report_errors).".");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $total_problem_count_unwaived, "FAIL";
  } elsif ($tot_waived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nWarning: Jasper CDC validation shows a total of 0 problems, but contains $tot_waived waived messages. Please review all waivers.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $total_problem_count_unwaived, "PASS";
    $score += ($score_per_tool - 2.5);
  } elsif ($log_errors > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
  } else {
    CoreUtils::DualPrint($tee_fp,"\nJasper CDC completed with no unwaived checks; the validation was successful.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, 0, "PASS";
    $score += $score_per_tool;
  }
  close(SFILE);
  print MFILE "$tool.metric.error;$tot_error\n";
  print MFILE "$tool.metric.error_waived;$tot_error_waived\n";
  print MFILE "$tool.metric.warn;$tot_warn\n";
  print MFILE "$tool.metric.warn_waived;$tot_warn_waived\n";
  print MFILE "$tool.metric.info;$tot_info\n";
  print MFILE "$tool.metric.total;$total_problem_count\n";
  print MFILE "$tool.metric.total_waived;$tot_waived\n";
  print MFILE "$tool.metric.total_unwaived;$total_problem_count_unwaived\n";
  print MFILE "$tool.metric.number_of_gates;$number_gates\n";
  print MFILE "$tool.metric.number_of_flops;$number_flops\n";
  close(MFILE);
}

sub jasper_mcp_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/jg_mcp_run.log");
  my $log_errors = &log_errors($tool_log);
  my ($loc_mcp_sdc_problem_count,$loc_sdc_failed,$loc_sdc_unsup) = (0,0,0);
  my ($loc_sdc_good,$loc_mcp_sdc_good_count) = (0,0);
  my ($loc_mcp_prov,$loc_mcp_viol,$loc_mcp_unreach,$loc_mcp_undeter,$loc_mcp_unproc,$loc_mcp_waived) = (0,0,0,0,0,0);
  my ($tot_prov, $tot_viol, $tot_unreach, $tot_undeter, $tot_unproc, $tot_waived, $total_problem_count) = (0,0,0,0,0,0,0);
  my $rule_summary_report = abs_path(<${workdir}/report/*_audit_summary.txt>);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} reporting was unsuccessful. Failed to detect ${workdir}/report/*_audit_summary.txt violation summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    while(<SUMFILE>) {
      if ($_ =~ /^\s+SDC\s+Commands\s+Parsing\s*$/) {
        $_ = <SUMFILE>;
        $_ = <SUMFILE>;
        until (($_ =~ /=====/) || (eof)) {
          $_ = <SUMFILE>;
          if ($_ =~ /^\s*\|\s+(set_multicycle_path|set_false_path)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+\S+\s*$/) {
            $loc_sdc_good = $2;
            $loc_sdc_failed = $3;
            $loc_sdc_unsup = $4;
            $loc_mcp_sdc_good_count += $loc_sdc_good;
            $loc_mcp_sdc_problem_count += ($loc_sdc_failed + $loc_sdc_unsup);
          }
        }
      } elsif ($_ =~ /^\s+Formal\s+Verification\s*$/) {
        $_ = <SUMFILE>;
        $_ = <SUMFILE>;
        until (($_ =~ /=====/) || (eof)) {
          $_ = <SUMFILE>;
          if ($_ =~ /^\s*\|\s+(MCP|FP)\s+\(\S+\)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+(\S+)\s*$/) {
            $loc_mcp_prov = $2;
            $loc_mcp_viol = $3;
            $loc_mcp_unreach = $4;
            $loc_mcp_undeter = $5;
            $loc_mcp_unproc = $6;
            $loc_mcp_waived = $7;
            $tot_prov += $loc_mcp_prov;
            $tot_viol += $loc_mcp_viol;
            $tot_unreach += $loc_mcp_unreach;
            $tot_undeter += $loc_mcp_undeter;
            $tot_unproc += $loc_mcp_unproc;
            $tot_waived += $loc_mcp_waived;
            $total_problem_count += ($loc_mcp_viol + $loc_mcp_unreach + $loc_mcp_undeter + $loc_mcp_unproc);
          }
        }
      }
    }
    close(SUMFILE);
  }
  my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
  open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
  my %vars;
  while(<UVAR>) {
    # Remove comments
    $_ =~ s/^\s*#.*//;
    $_ =~ s/\s+#.*$//;
    if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
      my ($varname, $varvalue) = ($1, $2);
      $varvalue =~ s/^["{]|["}]$//g;
      $vars{$varname} = $varvalue;
    }
  }
  close(UVAR);
  my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../../README.txt | awk '{print \$3}'`;
  chomp($flow_version);
  my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
  my $uid = (stat $workdir)[4];
  my $workdiruser = (getpwuid $uid)[0];
  print MFILE "$tool.run_area;$workdir\n";
  print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
  print MFILE "$tool.global_dir;$global_dir\n";
  print MFILE "$tool.flow_version;$flow_version\n";
  print MFILE "$tool.design;$vars{top_design}\n";
  print MFILE "$tool.user;$workdiruser\n";
  open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
  if ($loc_mcp_sdc_problem_count > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper MCP validation shows a total of $loc_mcp_sdc_problem_count MCP/FP SDC commands that failed to load. Review the following file: ${rule_summary_report}.");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $loc_mcp_sdc_problem_count, "FAIL";
  } elsif (($loc_mcp_sdc_good_count > 0) && ($tot_prov == 0) && ($total_problem_count == 0)) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper MCP validation shows successfully loaded MCP/FP SDC commands but none that are proven. Review the following file: ${rule_summary_report}.");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $loc_mcp_sdc_good_count, "FAIL";
  } elsif ($total_problem_count > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper MCP validation shows a total of $total_problem_count MCP/FP SDC commands that are not successfully proven. Review the following file: ${rule_summary_report}.");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $total_problem_count, "FAIL";
  } elsif ($tot_waived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nWarning: Jasper MCP validation shows a total of 0 problems, but contains $tot_waived waived messages. Please review all waivers.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $total_problem_count, "PASS";
    $score += ($score_per_tool - 2.5);
  } elsif ($log_errors > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
  } else {
    CoreUtils::DualPrint($tee_fp,"\nInfo: Jasper MCP completed with no unwaived failing checks; the validation was successful.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, 0, "PASS";
    $score += $score_per_tool;
  }
  close(SFILE);
  print MFILE "$tool.metric.sdc_failed;$loc_mcp_sdc_problem_count\n";
  print MFILE "$tool.metric.sdc_good;$loc_mcp_sdc_good_count\n";
  print MFILE "$tool.metric.proven;$tot_prov\n";
  print MFILE "$tool.metric.violation;$tot_viol\n";
  print MFILE "$tool.metric.unreachable;$tot_unreach\n";
  print MFILE "$tool.metric.undetermined;$tot_undeter\n";
  print MFILE "$tool.metric.unprocessed;$tot_unproc\n";
  print MFILE "$tool.metric.waived;$tot_waived\n";
  print MFILE "$tool.metric.total_issues;$total_problem_count\n";
  close(MFILE);
}


sub jasper_superlint_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/jg_superlint_run.log");
  my $log_errors = &log_errors($tool_log);
  my ($loc_tag,$loc_severity,$loc_checks,$loc_waived,$loc_total) = ("","","",0,0);
  my ($loc_err_cnt,$loc_warn_cnt,$loc_info_cnt) = (0,0,0);
  my ($tot_error, $tot_error_waived, $tot_warn, $tot_warn_waived, $tot_info, $tot_info_waived, $tot_waived) = (0,0,0,0,0,0,0);
  my ($total_problem_count, $total_problem_count_unwaived) = (0,0);
  my ($total_coverage, $detectable_coverage, $ignored_coverage, $inactive_coverage, $untested_coverage, $redundant_coverage, $estimated_coverage) = (0,0,0,0,0,0,0);
  my ($number_gates, $number_flops) = (0,0);
  my @report_errors = ();
  my $rule_summary_report = abs_path(<${workdir}/report/*_summary.txt>);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper superlint reporting was unsuccessful. Failed to detect ${workdir}/report/*_summary.txt violation summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    while(<SUMFILE>) {
      if ($_ =~ /^\s*Category\s+\|\s+Error\s+\|\s+Warning\s+\|\s+Info/) {
        until (($_ =~ /\*\*\*\*\*/) || (eof)) {
          $_ = <SUMFILE>;
          if ($_ =~ /^\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
            $loc_tag = $1;
            if ($loc_tag ne "Total") {
              $loc_err_cnt = $2;
              $loc_warn_cnt = $3;
              $loc_info_cnt = $4;
              $loc_waived = $5;
              if ($loc_waived >= $loc_err_cnt) {
                $tot_error_waived += $loc_err_cnt;
              } else {
                $tot_error_waived += $loc_waived;
                $tot_error += ($loc_err_cnt - $loc_waived);
              }
              if ($loc_waived >= $loc_warn_cnt) {
                $tot_warn_waived += $loc_warn_cnt;
              } else {
                $tot_warn_waived += $loc_waived;
                $tot_warn += ($loc_warn_cnt - $loc_waived);
              }
              if ($loc_waived >= $loc_info_cnt) {
                $tot_info_waived += $loc_info_cnt;
              } else {
                $tot_info_waived += $loc_waived;
                $tot_info += ($loc_info_cnt - $loc_waived);
              }
              $loc_total = $6;
              $tot_waived += $loc_waived;
              $total_problem_count += ($loc_err_cnt + $loc_warn_cnt + $loc_info_cnt);
              $total_problem_count_unwaived += ($loc_err_cnt + $loc_warn_cnt + $loc_info_cnt - $loc_waived);
            }
          }
        }
      }
    }
    if ($total_problem_count_unwaived > 0) {
      push (@report_errors, $rule_summary_report);
    }
    close(SUMFILE);
  }
  $rule_summary_report = abs_path(<${workdir}/report/*_waived_checks.txt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper superlint reporting was unsuccessful. Failed to detect ${workdir}/report/*_waived_checks.txt violation summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    while(<SUMFILE>) {
      if ($_ =~ /^\s*Tag\s+\|\s+Severity\s+\|\s+Checks/) {
        until (($_ =~ /\*\*\*\*\*/) || (eof)) {
          $_ = <SUMFILE>;
          if ($_ =~ /^\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
            $loc_tag = $1;
            $loc_severity = $2;
            if ($loc_tag ne "Total" && ($loc_severity eq "Error" || $loc_severity eq "Warning" || $loc_severity eq "Info")) {
              $loc_checks = $3;
              $loc_waived = $4;
              $loc_total = $5;
              if ($loc_severity eq "Error") {
                $tot_error += $loc_checks;
                if ($loc_waived > 0) {
                  $tot_error_waived += $loc_waived;
                }
              } elsif ($loc_severity eq "Warning") {
                $tot_warn += $loc_checks;
                if ($loc_waived > 0) {
                  $tot_warn_waived += $loc_waived;
                }
              } elsif ($loc_severity eq "Info") {
                $tot_info += $loc_checks;
              }
              $tot_waived += $loc_waived;
              $total_problem_count += ($loc_checks + $loc_waived);
              $total_problem_count_unwaived += $loc_checks;
            }
          }
        }
      }
    }
    if ($total_problem_count_unwaived > 0) {
      push (@report_errors, $rule_summary_report);
    }
    close(SUMFILE);
  }
  $rule_summary_report = abs_path(<${workdir}/report/*_test_coverage.txt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper superlint reporting was unsuccessful. Failed to detect ${workdir}/report/*_test_coverage.txt violation summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    while(<SUMFILE>) {
      if ($_ =~ /^\s*Total\s+\|\s+Detectable\s+\|\s+Ignored/) {
        $_ = <SUMFILE>;
        $_ = <SUMFILE>;
        if ($_ =~ /^\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
          $total_coverage = $1;
          $detectable_coverage = $2;
          $ignored_coverage = $3;
          $inactive_coverage = $4;
          $untested_coverage = $5;
          $redundant_coverage = $6;
          $estimated_coverage = $9;
          last;
        }
      }
    }
    close(SUMFILE);
  }
  $rule_summary_report = abs_path(<${workdir}/report/*_setup.txt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} reporting was unsuccessful. Failed to detect ${workdir}/report/*_setup.txt violation summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    while(<SUMFILE>) {
      if ($_ =~ /Number of Gates/) {
        $_ = <SUMFILE>;
        $_ = <SUMFILE>;
        if ($_ =~ /^\s*(\S+)\s+(\S+)/) {
          $number_gates = $1;
          $number_flops = $2;
          last;
        }
      }
    }
    close(SUMFILE);
  }
  my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
  open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
  my %vars;
  while(<UVAR>) {
    # Remove comments
    $_ =~ s/^\s*#.*//;
    $_ =~ s/\s+#.*$//;
    if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
      my ($varname, $varvalue) = ($1, $2);
      $varvalue =~ s/^["{]|["}]$//g;
      $vars{$varname} = $varvalue;
    }
  }
  close(UVAR);
  my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../../README.txt | awk '{print \$3}'`;
  chomp($flow_version);
  my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
  my $uid = (stat $workdir)[4];
  my $workdiruser = (getpwuid $uid)[0];
  print MFILE "$tool.run_area;$workdir\n";
  print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
  print MFILE "$tool.global_dir;$global_dir\n";
  print MFILE "$tool.flow_version;$flow_version\n";
  print MFILE "$tool.design;$vars{top_design}\n";
  print MFILE "$tool.user;$workdiruser\n";
  open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
  if ($total_problem_count_unwaived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper superlint validation shows a total of $total_problem_count_unwaived\n unwaived error/warning/info messages. Review the following file: ".join(', ',@report_errors).".");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $total_problem_count_unwaived, "FAIL";
  } elsif ($tot_waived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nWarning: Jasper superlint validation shows a total of 0 problems, but contains $tot_waived waived messages. Please review all waivers.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $total_problem_count_unwaived, "PASS";
    $score += ($score_per_tool - 2.5);
  } elsif ($log_errors > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
  } else {
    CoreUtils::DualPrint($tee_fp,"\nJasper superlint completed with no unwaived checks; the validation was successful.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $total_problem_count_unwaived, "PASS";
    $score += $score_per_tool;
  }
  close(SFILE);
  print MFILE "$tool.metric.error;$tot_error\n";
  print MFILE "$tool.metric.error_waived;$tot_error_waived\n";
  print MFILE "$tool.metric.warn;$tot_warn\n";
  print MFILE "$tool.metric.warn_waived;$tot_warn_waived\n";
  print MFILE "$tool.metric.info;$tot_info\n";
  print MFILE "$tool.metric.total;$total_problem_count\n";
  print MFILE "$tool.metric.total_waived;$tot_waived\n";
  print MFILE "$tool.metric.total_unwaived;$total_problem_count_unwaived\n";
  print MFILE "$tool.metric.total_coverage;$total_coverage\n";
  print MFILE "$tool.metric.detectable_coverage;$detectable_coverage\n";
  print MFILE "$tool.metric.ignored_coverage;$ignored_coverage\n";
  print MFILE "$tool.metric.inactive_coverage;$inactive_coverage\n";
  print MFILE "$tool.metric.untested_coverage;$untested_coverage\n";
  print MFILE "$tool.metric.redundant_coverage;$redundant_coverage\n";
  print MFILE "$tool.metric.estimated_coverage;$estimated_coverage\n";
  print MFILE "$tool.metric.number_of_gates;$number_gates\n";
  print MFILE "$tool.metric.number_of_flops;$number_flops\n";
  close(MFILE);
}

sub jasper_xprop_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/jg_xprop_run.log");
  my $log_errors = &log_errors($tool_log);
  my @report_errors = ();
  my ($total_problem_count,$total_unprocessed,$total_undetermined,$total_proven,$total_waived,$total_analyzed) = (0,0,0,0,0,0);
  my ($loc_xprop_cat,$loc_xprop_cex,$loc_xprop_unprocessed,$loc_xprop_undetermined,$loc_xprop_proven,$loc_xprop_waived,$loc_xprop_total) = ("",0,0,0,0,0,0);
  my ($flops, $latches, $gates, $nets, $ports, $rtl_lines, $rtl_instances, $embedded_assumptions, $embedded_assertions, $embedded_covers) = (0,0,0,0,0,0,0,0,0,0);
  my ($missing_xprop_sources, $missing_xprop_targets) = (0,0);
  my $rule_summary_report = abs_path(<${workdir}/report/*_total_property_summary.txt>);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} reporting was unsuccessful. Failed to detect ${workdir}/report/*_total_property_summary.txt summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    while(<SUMFILE>) {
      if ($_ =~ /^\s+Num\s+\|\s+Category\s+\|\s+Cex\s+/) {
        $_ = <SUMFILE>;
        until (($_ =~ /\*\*\*\*\*/) || (eof)) {
          $_ = <SUMFILE>;
          if ($_ =~ /^\[\d+\.?\d*\]\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s*$/) {
            $loc_xprop_cat = $1;
            $loc_xprop_cex = $2;
            $loc_xprop_unprocessed = $3;
            $loc_xprop_undetermined = $4;
            $loc_xprop_proven = $5;
            $loc_xprop_waived = $6;
            $loc_xprop_total = $7;
            next if ($loc_xprop_cat eq "Total");
            $total_problem_count += $loc_xprop_cex;
            $total_unprocessed += $loc_xprop_unprocessed;
            $total_undetermined += $loc_xprop_undetermined;
            $total_proven += $loc_xprop_proven;
            $total_waived += $loc_xprop_waived;
            $total_analyzed += $loc_xprop_total;
          }
        }
      }
    }
    if ($total_problem_count > 0) {
      push (@report_errors, $rule_summary_report);
    }
    close(SUMFILE);
  }
  $rule_summary_report = abs_path(<${workdir}/report/*_design_info.txt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} reporting was unsuccessful. Failed to detect ${workdir}/report/*_design_info.txt summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    while(<SUMFILE>) {
      if ($_ =~ /Flops:\s+(\d+)/) {
        $flops = $1;
      } elsif ($_ =~ /Latches:\s+(\d+)/) {
        $latches = $1;
      } elsif ($_ =~ /Gates:\s+(\d+)/) {
        $gates = $1;
      } elsif ($_ =~ /Nets:\s+(\d+)/) {
        $nets = $1;
      } elsif ($_ =~ /Ports:\s+(\d+)/) {
        $ports = $1;
      } elsif ($_ =~ /RTL Lines:\s+(\d+)/) {
        $rtl_lines = $1;
      } elsif ($_ =~ /RTL Instances:\s+(\d+)/) {
        $rtl_instances = $1;
      } elsif ($_ =~ /Embedded Assumptions:\s+(\d+)/) {
        $embedded_assumptions = $1;
      } elsif ($_ =~ /Embedded Assertions:\s+(\d+)/) {
        $embedded_assertions = $1;
      } elsif ($_ =~ /Embedded Covers:\s+(\d+)/) {
        $embedded_covers = $1;
      }
    }
    close(SUMFILE);
  }
  $rule_summary_report = abs_path(<${workdir}/report/*_x_sources_selected.txt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} reporting was unsuccessful. Failed to detect ${workdir}/report/*_x_sources_selected.txt file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    my @obliged_sources = ("set_xprop_use_reset_state", "set_xprop_use_bbox_outputs", "set_xprop_use_bus_contention", "set_xprop_use_bus_floating", "set_xprop_use_internal_undriven");
    while(<SUMFILE>) {
      if ($_ =~ /^(\w+)\s+off/) {
        my $source = $1;
        if (grep {$_ eq $source} @obliged_sources) {
          CoreUtils::DualPrint($tee_fp, "\nError: $source is a mandatory source. Check in $rule_summary_report.");
          $missing_xprop_sources++;
        }
      }
    }
    if ($missing_xprop_sources > 0) {
      push (@report_errors, $rule_summary_report);
    }
    close(SUMFILE);
  }
  $rule_summary_report = abs_path(<${workdir}/report/*_x_targets_selected.txt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} reporting was unsuccessful. Failed to detect ${workdir}/report/*_x_targets_selected.txt file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    my @obliged_targets = ("clocks_and_resets", "control", "no_flops_with_reset_pin", "include_sync_resets", "data", "index", "outputs", "bbox_inputs", "flops_with_reset_pin", "include_sync_resets", "flops_with_reset_value", "counters", "fsms");
    while(<SUMFILE>) {
      if ($_ =~ /^(\w+)\s+off/) {
        my $source = $1;
        if (grep {$_ eq $source} @obliged_targets) {
          CoreUtils::DualPrint($tee_fp, "\nError: $source is a mandatory target. Check in $rule_summary_report.");
          $missing_xprop_targets++;
        }
      }
    }
    if ($missing_xprop_targets > 0) {
      push (@report_errors, $rule_summary_report);
    }
    close(SUMFILE);
  }
  my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
  open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
  my %vars;
  while(<UVAR>) {
    # Remove comments
    $_ =~ s/^\s*#.*//;
    $_ =~ s/\s+#.*$//;
    if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
      my ($varname, $varvalue) = ($1, $2);
      $varvalue =~ s/^["{]|["}]$//g;
      $vars{$varname} = $varvalue;
    }
  }
  close(UVAR);
  my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../../README.txt | awk '{print \$3}'`;
  chomp($flow_version);
  my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
  my $uid = (stat $workdir)[4];
  my $workdiruser = (getpwuid $uid)[0];
  print MFILE "$tool.run_area;$workdir\n";
  print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
  print MFILE "$tool.global_dir;$global_dir\n";
  print MFILE "$tool.flow_version;$flow_version\n";
  print MFILE "$tool.design;$vars{top_design}\n";
  print MFILE "$tool.user;$workdiruser\n";
  open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
  if ($total_problem_count > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper XPROP validation shows a total of $total_problem_count unwaived error/warning/info messages. Review the following file: ".join(', ',@report_errors).".");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $total_problem_count, "FAIL";
  } elsif ($total_waived > 0 && $missing_xprop_sources == 0 && $missing_xprop_targets == 0) {
    CoreUtils::DualPrint($tee_fp,"\nWarning: Jasper XPROP validation shows a total of 0 problems, but contains $total_waived waived messages. Please review all waivers.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $total_problem_count, "PASS";
    $score += ($score_per_tool - 2.5);
  } elsif ($log_errors > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
  } elsif ($missing_xprop_sources > 0 || $missing_xprop_targets > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper XPROP completed without errors, but not all required sources/targets were used. Please review following file: ".join(', ',@report_errors).".");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, ($missing_xprop_sources + $missing_xprop_targets), "FAIL";
  } else {
    CoreUtils::DualPrint($tee_fp,"\nJasper XPROP completed with no unwaived checks; the validation was successful.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, 0, "PASS";
    $score += $score_per_tool;
  }
  close(SFILE);
  print MFILE "$tool.metric.error;$total_problem_count\n";
  print MFILE "$tool.metric.waived;$total_waived\n";
  print MFILE "$tool.metric.unprocessed;$total_unprocessed\n";
  print MFILE "$tool.metric.undetermined;$total_undetermined\n";
  print MFILE "$tool.metric.proven;$total_proven\n";
  print MFILE "$tool.metric.total_analyzed;$total_analyzed\n";
  print MFILE "$tool.metric.flops;$flops\n";
  print MFILE "$tool.metric.latches;$latches\n";
  print MFILE "$tool.metric.gates;$gates\n";
  print MFILE "$tool.metric.nets;$nets\n";
  print MFILE "$tool.metric.ports;$ports\n";
  print MFILE "$tool.metric.rtl_lines;$rtl_lines\n";
  print MFILE "$tool.metric.rtl_instances;$rtl_instances\n";
  print MFILE "$tool.metric.embedded_assumptions;$embedded_assumptions\n";
  print MFILE "$tool.metric.embedded_assertions;$embedded_assertions\n";
  print MFILE "$tool.metric.embedded_covers;$embedded_covers\n";
  print MFILE "$tool.metric.missing_xprop_sources;$missing_xprop_sources\n";
  print MFILE "$tool.metric.missing_xprop_targets;$missing_xprop_targets\n";
  close(MFILE);
}

sub joules_flow1_check {
  my $workdir = &folder_check("joules_run_*Flow_1");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/joules_studio_work/joules_studio.log");
  my $log_errors = &log_errors($tool_log);
  my $rule_summary_report = abs_path(<${workdir}/power_estimate/Joules_CTS.rpt>);
  my ($buf_leaf, $buf_branch, $buf_root) = (0,0,0);
  my ($cts_levels, $cts_endpoints) = (0,0);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: Joules Flow 1 reporting was unsuccessful. Failed to detect ${workdir}/power_estimate/Joules_CTS.rpt file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    while(<SUMFILE>) {
      if ($_ =~ /^Buffers Inserted\s+(\S+)\s+(\S+)\s+(\S+)/) {
        $buf_root = $1;
        $buf_branch = $2;
        $buf_leaf = $3;
      }
      if ($_ =~ /^Total levels in the tree (\S+)/) {
        $cts_levels = $1
      }
      if ($_ =~ /^Total end-points in the tree (\S+)/) {
        $cts_endpoints = $1
      }
    }
    close(SUMFILE);
  }
  my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
  open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
  my %vars;
  while(<UVAR>) {
    # Remove comments
    $_ =~ s/^\s*#.*//;
    $_ =~ s/\s+#.*$//;
    if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
      my ($varname, $varvalue) = ($1, $2);
      $varvalue =~ s/^["{]|["}]$//g;
      $vars{$varname} = $varvalue;
    }
  }
  close(UVAR);
  my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../README.txt | awk '{print \$3}'`;
  chomp($flow_version);
  my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
  my $uid = (stat $workdir)[4];
  my $workdiruser = (getpwuid $uid)[0];
  print MFILE "$tool.run_area;$workdir\n";
  print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
  print MFILE "$tool.global_dir;$global_dir\n";
  print MFILE "$tool.flow_version;$flow_version\n";
  print MFILE "$tool.design;$vars{top_design}\n";
  print MFILE "$tool.user;$workdiruser\n";
  open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
  if ($log_errors > 0) {
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
  } else {
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, "0", "PASS";
  }
  print MFILE "$tool.metric.buf_root;$buf_root\n";
  print MFILE "$tool.metric.buf_branch;$buf_branch\n";
  print MFILE "$tool.metric.buf_leaf;$buf_leaf\n";
  print MFILE "$tool.metric.cts_levels;$cts_levels\n";
  print MFILE "$tool.metric.cts_endpoints;$cts_endpoints\n";
  close(MFILE);
  close(SFILE);
}

sub joules_flow2_check {
  my $workdir = &folder_check("joules_run_*Flow_2");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/joules_studio_work/joules_studio.log");
  my $log_errors = &log_errors($tool_log);
  my ($odc_flops, $odc_flops_enable, $odc_flops_enable_perc) = (0,0,0);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  my $rule_summary_report = abs_path(<${workdir}/odc_analysis/statistical/odc/structural_cg_odc_pp_mc.rpt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    print "\nError: Joules Flow 2 reporting was unsuccessful. Failed to detect ${workdir}/odc_analysis/statistical/odc/structural_cg_odc_pp_mc.rpt file.";
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    while(<SUMFILE>) {
      if ($_ =~ /^Summation of flops in reg banks with ODC                   : (\S+)/) {
        $odc_flops = $1;
      }
      if ($_ =~ /^Summation of flops in reg banks with ODC enable            : (\S+) \((\S+)\)/) {
        $odc_flops_enable = $1;
        $odc_flops_enable_perc = $2;
      }
    }
    close(SUMFILE);
  }
  $rule_summary_report = abs_path(<${workdir}/odc_analysis/statistical/stb/structural_constant_stb.rpt>);
  my ($stb_flops, $stb_regbanks) = (0,0);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: Joules Flow 2 reporting was unsuccessful. Failed to detect ${workdir}/odc_analysis/statistical/stb/structural_constant_stb.rpt file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    while(<SUMFILE>) {
      if ($_ =~ /^No of reg banks with STB                   : (\S+)/) {
        $stb_regbanks = $1;
      }
      if ($_ =~ /^Summation of flops in reg banks with STB   : (\S+)/) {
        $stb_flops = $1;
      }
    }
    close(SUMFILE);
  }
  my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
  open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
  my %vars;
  while(<UVAR>) {
    # Remove comments
    $_ =~ s/^\s*#.*//;
    $_ =~ s/\s+#.*$//;
    if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
      my ($varname, $varvalue) = ($1, $2);
      $varvalue =~ s/^["{]|["}]$//g;
      $vars{$varname} = $varvalue;
    }
  }
  close(UVAR);
  my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../README.txt | awk '{print \$3}'`;
  chomp($flow_version);
  my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
  my $uid = (stat $workdir)[4];
  my $workdiruser = (getpwuid $uid)[0];
  print MFILE "$tool.run_area;$workdir\n";
  print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
  print MFILE "$tool.global_dir;$global_dir\n";
  print MFILE "$tool.flow_version;$flow_version\n";
  print MFILE "$tool.design;$vars{top_design}\n";
  print MFILE "$tool.user;$workdiruser\n";
  open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
  if ($log_errors > 0) {
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
  } else {
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, "0", "PASS";
  }
  print MFILE "$tool.metric.odc_flops;$odc_flops\n";
  print MFILE "$tool.metric.odc_flops_enable;$odc_flops_enable\n";
  print MFILE "$tool.metric.odc_flops_enable_perc;$odc_flops_enable_perc\n";
  print MFILE "$tool.metric.stb_flops;$stb_flops\n";
  print MFILE "$tool.metric.stb_regbanks;$stb_regbanks\n";
  close(MFILE);
  close(SFILE);
}

sub joules_flow3_check {
  my $workdir = &folder_check("joules_run_*Flow_3");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/joules_studio_work/joules_studio.log");
  my $log_errors = &log_errors($tool_log);
  my $regcone_report = abs_path(<${workdir}/structural_analysis/reg_cone/reg_cone_summary.rpt>);
  my ($issue_found,$fanin,$fanout,$product,$fanin_pathdepth,$fanout_pathdepth) = (0,0,0,0,0,0);
  my ($maxfanin,$maxfanout,$maxproduct,$maxfanin_pathdepth,$maxfanout_pathdepth) = (0,0,0,0,0);
  my $combo_loops = 1;
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  if (! defined $regcone_report || ! -f $regcone_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: Litmus Flow 3 reporting was unsuccessful. Failed to detect ${workdir}/structural_analysis/reg_cone/reg_cone_summary.rpt.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$regcone_report") or die ("Cannot open ${regcone_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${regcone_report}.");
    while(<SUMFILE>) {
      if ($_ =~ /^Fanin/) {
        until (eof) {
          $_ = <SUMFILE>;
          if ($_ =~ /^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
            $fanin = $1;
            $fanout = $2;
            $product = $3;
            $fanin_pathdepth = $5;
            $fanout_pathdepth = $6;
            if ($fanin > $maxfanin) {
              $maxfanin = $fanin;
            }
            if ($fanout > $maxfanout) {
              $maxfanout = $fanout;
            }
            if ($product > $maxproduct) {
              $maxproduct = $product;
            }
            if ($fanin_pathdepth > $maxfanin_pathdepth) {
              $maxfanin_pathdepth = $fanin_pathdepth;
            }
            if ($fanout_pathdepth > $maxfanout_pathdepth) {
              $maxfanout_pathdepth = $fanout_pathdepth;
            }
          }
        }
      }
    }
    close(SUMFILE);
  }
  my $combloops_report = abs_path(<${workdir}/structural_analysis/combo_loops/combinational_loops.rpt>);
  if (! defined $combloops_report || ! -f $combloops_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: Litmus Flow 3 reporting was unsuccessful. Failed to detect ${workdir}/structural_analysis/combo_loops/combinational_loops.rpt.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    open(SUMFILE,"<$combloops_report") or die ("Cannot open ${combloops_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${combloops_report}.");
    while(<SUMFILE>) {
      if ($_ =~ /No combo loops to report/) {
        if ($_ =~ /No combo loops to report/) {
          $combo_loops = 0;
          last;
        }
      }
    }
    close(SUMFILE);
  }
  my ($dft_ran, $dft_regs_pass, $dft_regs_fail, $dft_perc) = (0,0,0,0);
  my $dft_report = abs_path(<${workdir}/trial_synthesis/dft/*_syn.scanregisters>);
  if (defined $dft_report && -f $dft_report) {
    open(SUMFILE,"<$dft_report") or die ("Cannot open ${dft_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${dft_report}.");
    $dft_ran = 1;
    while(<SUMFILE>) {
      if ($_ =~ /^Total registers that pass DFT rules: (\S+)/) {
        $dft_regs_pass = $1;
      } elsif ($_ =~ /^Total registers that fail DFT rules: (\S+)/) {
        $dft_regs_fail = $1;
      }
    }
    $dft_perc = sprintf "%.2f", ($dft_regs_pass/($dft_regs_pass + $dft_regs_fail))*100;
    close(SUMFILE);
    if ($dft_perc < 100.00) {
      CoreUtils::DualPrint($tee_fp,"\nError: Scan-chain coverage lesser than 100% . Please review $dft_report.");
      $issue_found++;
    }
  }
  my ($atpg_ran, $atpg_faults, $atpg_tested, $atpg_possibly, $atpg_redundant, $atpg_untested, $atpg_coverage, $atpg_adjcoverage) = (0,0,0,0,0,0,0,0);
  my $atpg_report = abs_path(<${workdir}/trial_synthesis/dft/*_syn.test_coverage>);
  if (defined $atpg_report && -f $atpg_report) {
    open(SUMFILE,"<$atpg_report") or die ("Cannot open ${atpg_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${atpg_report}.");
    $atpg_ran = 1;
    while(<SUMFILE>) {
      if ($_ =~ /^Total Static\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
        $atpg_faults = $1;
        $atpg_tested = $2;
        $atpg_possibly = $3;
        $atpg_redundant = $4;
        $atpg_untested = $5;
        $atpg_coverage = $6;
        $atpg_adjcoverage = $7;
        last;
      }
    }
    close(SUMFILE);
    if ($atpg_coverage < 95.00) {
      CoreUtils::DualPrint($tee_fp,"\nError: ATPG coverage lesser than 95% . Please review $atpg_report.");
      $issue_found++;
    }
  }
  my ($trialsynthesis_ran, $trialsynthesis_totaltns, $trialsynthesis_violpaths, $trialsynthesis_instancecount, $trialsynthesis_seqcount, $trialsynthesis_combcount, $trialsynthesis_cellarea, $trialsynthesis_maxfanout, $trialsynthesis_averagefanout) = (0,0,0,0,0,0,0,0,0);
  my $trialsynthesis_report = abs_path(<${workdir}/trial_synthesis/*_syn.qor>);
  if (defined $trialsynthesis_report && -f $trialsynthesis_report) {
    open(SUMFILE,"<$trialsynthesis_report") or die ("Cannot open ${trialsynthesis_report}.\n");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${atpg_report}.");
    $trialsynthesis_ran = 1;
    while(<SUMFILE>) {
      if ($_ =~ /^Total     \s+(\S+)\s+(\S+)/) {
        $trialsynthesis_totaltns = $1;
        $trialsynthesis_violpaths = $2;
      } elsif ($_ =~ /^Leaf Instance Count\s+(\S+)/) {
        $trialsynthesis_instancecount = $1;
      } elsif ($_ =~ /^Sequential Instance Count\s+(\S+)\s+(\S+)/) {
        $trialsynthesis_seqcount = $2;
      } elsif ($_ =~ /^Combinational Instance Count\s+(\S+)/) {
        $trialsynthesis_combcount = $1;
      } elsif ($_ =~ /^Cell Area\s+(\S+)/) {
        $trialsynthesis_cellarea = $1;
      } elsif ($_ =~ /^Max Fanout\s+(\S+)/) {
        $trialsynthesis_maxfanout = $1;
      } elsif ($_ =~ /^Average Fanout\s+(\S+)/) {
        $trialsynthesis_averagefanout = $1;
      }
    }
    close(SUMFILE);
  }
  if ($combo_loops) {
    CoreUtils::DualPrint($tee_fp,"\nError: Joules showed a combo loop. Please review ${workdir}/structural_analysis/combo_loops/combinational_loops.rpt.");
    $issue_found++;
  }
  if ($maxfanin > 10000) {
    CoreUtils::DualPrint($tee_fp,"\nError: Joules showed a fanin greater than 10000. Please review ${workdir}/structural_analysis/reg_cone/reg_cone_summary.rpt.");
    $issue_found++;
  }
  if ($maxfanout > 10000) {
    CoreUtils::DualPrint($tee_fp,"\nError: Joules showed a fanout greater than 10000. Please review ${workdir}/structural_analysis/reg_cone/reg_cone_summary.rpt.");
    $issue_found++;
  }
  my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
  open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
  my %vars;
  while(<UVAR>) {
    # Remove comments
    $_ =~ s/^\s*#.*//;
    $_ =~ s/\s+#.*$//;
    if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
      my ($varname, $varvalue) = ($1, $2);
      $varvalue =~ s/^["{]|["}]$//g;
      $vars{$varname} = $varvalue;
    }
  }
  close(UVAR);
  my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../README.txt | awk '{print \$3}'`;
  chomp($flow_version);
  my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
  my $uid = (stat $workdir)[4];
  my $workdiruser = (getpwuid $uid)[0];
  print MFILE "$tool.run_area;$workdir\n";
  print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
  print MFILE "$tool.global_dir;$global_dir\n";
  print MFILE "$tool.flow_version;$flow_version\n";
  print MFILE "$tool.design;$vars{top_design}\n";
  print MFILE "$tool.user;$workdiruser\n";
  open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
  if ($issue_found == 0) {
    if ($log_errors > 0) {
      CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
      print MFILE "$tool.status;FAIL\n";
      printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
    } else {
      CoreUtils::DualPrint($tee_fp,"\nJoules completed without big fanin/fanout cones; the validation was successful.");
      print MFILE "$tool.status;PASS\n";
      printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "PASS";
      $score += $score_per_tool;
    }
  } else {
    CoreUtils::DualPrint($tee_fp,"\nJoules completed with errors, please review the log: $teelog.");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $issue_found+$log_errors, "FAIL";
  }
  close(SFILE);
  print MFILE "$tool.metric.maxfanin;$maxfanin\n";
  print MFILE "$tool.metric.maxfanout;$maxfanout\n";
  print MFILE "$tool.metric.maxproduct;$maxproduct\n";
  print MFILE "$tool.metric.maxfanin_pathdepth;$maxfanin_pathdepth\n";
  print MFILE "$tool.metric.maxfanout_pathdepth;$maxfanout_pathdepth\n";
  print MFILE "$tool.metric.combo_loops;$combo_loops\n";
  print MFILE "$tool.metric.dft_ran;$dft_ran\n";
  print MFILE "$tool.metric.dft_regs_pass;$dft_regs_pass\n";
  print MFILE "$tool.metric.dft_regs_fail;$dft_regs_fail\n";
  print MFILE "$tool.metric.dft_perc;$dft_perc\n";
  print MFILE "$tool.metric.atpg_ran;$atpg_ran\n";
  print MFILE "$tool.metric.atpg_faults;$atpg_faults\n";
  print MFILE "$tool.metric.atpg_tested;$atpg_tested\n";
  print MFILE "$tool.metric.atpg_possibly;$atpg_possibly\n";
  print MFILE "$tool.metric.atpg_redundant;$atpg_redundant\n";
  print MFILE "$tool.metric.atpg_untested;$atpg_untested\n";
  print MFILE "$tool.metric.atpg_coverage;$atpg_coverage\n";
  print MFILE "$tool.metric.atpg_adjcoverage;$atpg_adjcoverage\n";
  print MFILE "$tool.metric.trialsynthesis_ran;$trialsynthesis_ran\n";
  print MFILE "$tool.metric.trialsynthesis_totaltns;$trialsynthesis_totaltns\n";
  print MFILE "$tool.metric.trialsynthesis_violpaths;$trialsynthesis_violpaths\n";
  print MFILE "$tool.metric.trialsynthesis_instancecount;$trialsynthesis_instancecount\n";
  print MFILE "$tool.metric.trialsynthesis_seqcount;$trialsynthesis_seqcount\n";
  print MFILE "$tool.metric.trialsynthesis_combcount;$trialsynthesis_combcount\n";
  print MFILE "$tool.metric.trialsynthesis_cellarea;$trialsynthesis_cellarea\n";
  print MFILE "$tool.metric.trialsynthesis_maxfanout;$trialsynthesis_maxfanout\n";
  print MFILE "$tool.metric.trialsynthesis_averagefanout;$trialsynthesis_averagefanout\n";
  close(MFILE);
}

sub clp_comp_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/clp_session.log");
  my $log_errors = &log_errors($tool_log);
  my $error_summary_file = abs_path(<${workdir}/report/*.compare_power_intent.rpt>);
  if (! defined $error_summary_file || ! -f $error_summary_file) {
    CoreUtils::DualPrint($tee_fp,"\nError: CLP Compare mode was unsuccessful. Failed to detect ${workdir}/report/*.compare_power_intent.rpt.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${error_summary_file}.");
    open(CLPFILE,"<$error_summary_file") or die ("Cannot open $error_summary_file}.\n");
    my $line = "";
    while(<CLPFILE>) {
      $line = $_;
      if ($line =~ /Power Intent Compare:/) {
        last;
      }
    }
    close(CLPFILE);
    my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
    open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
    my %vars;
    while(<UVAR>) {
      # Remove comments
      $_ =~ s/^\s*#.*//;
      $_ =~ s/\s+#.*$//;
      if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
        my ($varname, $varvalue) = ($1, $2);
        $varvalue =~ s/^["{]|["}]$//g;
        $vars{$varname} = $varvalue;
      }
    }
    close(UVAR);
    my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../README.txt | awk '{print \$3}'`;
    chomp($flow_version);
    my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
    my $uid = (stat $workdir)[4];
    my $workdiruser = (getpwuid $uid)[0];
    open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
    print MFILE "$tool.run_area;$workdir\n";
    print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
    print MFILE "$tool.global_dir;$global_dir\n";
    print MFILE "$tool.flow_version;$flow_version\n";
    print MFILE "$tool.design;$vars{top_design}\n";
    print MFILE "$tool.user;$workdiruser\n";
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    if ($line =~ /Power Intent Compare: Equivalent/) {
      if ($log_errors > 0) {
        CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
        printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
        print MFILE "$tool.status;FAIL\n";
      } else {
        CoreUtils::DualPrint($tee_fp,"\nCLP Compare mode showed equivalent UPFs.");
        printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "PASS";
        print MFILE "$tool.status;PASS\n";
        $score += $score_per_tool;
      }
    } elsif ($line =~ /Power Intent Compare: Non-Equivalent/) {
      CoreUtils::DualPrint($tee_fp,"\nError: CLP Compare mode showed non equivalent points. Please review $error_summary_file.");
      printf SFILE "%-25s %-20s %-20s\n", $tool, "> 0", "FAIL";
      print MFILE "$tool.status;FAIL\n";
    } else {
      CoreUtils::DualPrint($tee_fp,"\nError: CLP Compare report missing compare result. Please review $error_summary_file.");
      printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "FAIL";
      print MFILE "$tool.status;FAIL\n";
    }
    close(SFILE);
    close(MFILE);
  }
}

sub clp_lint_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/clp_session.log");
  my $log_errors = &log_errors($tool_log);
  my $error_summary_file = abs_path(<${workdir}/report/*.rule_check.error.rpt>);
  my $rule_filters_file = abs_path(<${workdir}/report/*.rule_filters.rpt>);
  if (! defined $error_summary_file || ! -f $error_summary_file || ! defined $rule_filters_file || ! -f $rule_filters_file) {
    CoreUtils::DualPrint($tee_fp,"\nError: CLP Lint run was unsucessful. Failed to detect ${workdir}/report/*.rule_check.error.rpt violation summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${error_summary_file}.");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_filters_file}.");
    my $size_summary = -s $error_summary_file;
    my $size_filters = -s $rule_filters_file;
    my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
    open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
    my %vars;
    while(<UVAR>) {
      # Remove comments
      $_ =~ s/^\s*#.*//;
      $_ =~ s/\s+#.*$//;
      if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
        my ($varname, $varvalue) = ($1, $2);
        $varvalue =~ s/^["{]|["}]$//g;
        $vars{$varname} = $varvalue;
      }
    }
    close(UVAR);
    my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../README.txt | awk '{print \$3}'`;
    chomp($flow_version);
    my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
    my $uid = (stat $workdir)[4];
    my $workdiruser = (getpwuid $uid)[0];
    open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
    print MFILE "$tool.run_area;$workdir\n";
    print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
    print MFILE "$tool.global_dir;$global_dir\n";
    print MFILE "$tool.flow_version;$flow_version\n";
    print MFILE "$tool.design;$vars{top_design}\n";
    print MFILE "$tool.user;$workdiruser\n";
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    if ($size_summary != 0) {
      CoreUtils::DualPrint($tee_fp,"\nCLP Lint was completed with errors. Please review ${error_summary_file}");
      printf SFILE "%-25s %-20s %-20s\n", $tool, 0, "PASS";
      print MFILE "$tool.status;PASS\n";
    } else {
      if ($size_filters != 0) {
        CoreUtils::DualPrint($tee_fp,"\nCLP Lint was completed without errors, but using rule filters. Please review ${rule_filters_file}");
        printf SFILE "%-25s %-20s %-20s\n", $tool, 0, "PASS";
        print MFILE "$tool.status;PASS\n";
        $score += ($score_per_tool - 2.5);
      } elsif ($log_errors > 0) {
        CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
        printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
        print MFILE "$tool.status;FAIL\n";
      } else {
        CoreUtils::DualPrint($tee_fp,"\nCLP Lint was successful. Completed without errors and waivers.");
        printf SFILE "%-25s %-20s %-20s\n", $tool, 0, "PASS";
        print MFILE "$tool.status;PASS\n";
        $score += $score_per_tool;
      }
    }
    close(SFILE);
    close(MFILE);
  }
}

sub litmus1_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Directory not found";
    close(SFILE);
    return;
  }
  $workdir = abs_path($workdir);
  my $tool_log = abs_path("${workdir}/litmus_*_sdc_run.log");
  my $log_errors = &log_errors($tool_log);
  my ($severity,$pass,$tot_errors,$tot_waived,$changed_rules) = ("","",0,0,0);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  my $rule_summary_report = abs_path(<${workdir}/modified_rules/*_changed_rules.txt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"Error: Litmus run was unsuccessful. Failed to detect ${workdir}/modified_rules/*_changed_rules.txt.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_summary_report}.");
    open(SUMFILE,"<$rule_summary_report") or die ("Cannot open ${rule_summary_report}.\n");
    while(<SUMFILE>) {
      if ($_ =~ /^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
        $severity = $3;
        $pass = $4;
        if ($severity eq "Error") {
          if ($pass ne "Pass") {
            $tot_errors++;
          }
        } elsif ($severity eq "Warning" || $severity eq "Ignore") {
          if ($pass ne "Pass") {
            $tot_waived++;
          }
        }
        $changed_rules++;
      }
    }
    $changed_rules--;
    close(SUMFILE);
  }
  my $error_summary_file = abs_path(<${workdir}/report/*severity_error_fail_summary.txt>);
  my $size = 0;
  if (! defined $error_summary_file || ! -f $error_summary_file) {
    CoreUtils::DualPrint($tee_fp,"\nError: Litmus run was unsucessful. Failed to detect ${workdir}/report/*severity_error_fail_summary.txt violation summary file.");
    open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
    printf SFILE "%-25s %-20s %-20s\n", $tool, "N/A", "Report not found";
    close(SFILE);
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${error_summary_file}.");
    $size = -s $error_summary_file;
  }
  my $local_user_vars_file = abs_path(<${workdir}/omega_local_user_vars.tcl>);
  open(UVAR,"<$local_user_vars_file") or die ("Cannot open ${local_user_vars_file}.\n");
  my %vars;
  while(<UVAR>) {
    # Remove comments
    $_ =~ s/^\s*#.*//;
    $_ =~ s/\s+#.*$//;
    if ($_ =~ /^\s*set\s+(\w+)\s+("[^"]*"|\{[^}]*\}|\S+)/) {
      my ($varname, $varvalue) = ($1, $2);
      $varvalue =~ s/^["{]|["}]$//g;
      $vars{$varname} = $varvalue;
    }
  }
  close(UVAR);
  my $flow_version = `grep 'Package version:' $vars{prl_script_root_dir}/../../README.txt | awk '{print \$3}'`;
  chomp($flow_version);
  my $global_dir = abs_path("$vars{prl_script_root_dir}/../../");
  my $uid = (stat $workdir)[4];
  my $workdiruser = (getpwuid $uid)[0];
  print MFILE "$tool.run_area;$workdir\n";
  print MFILE "$tool.tech_process_dir;$tech_process_dir\n";
  print MFILE "$tool.global_dir;$global_dir\n";
  print MFILE "$tool.flow_version;$flow_version\n";
  print MFILE "$tool.design;$vars{top_design}\n";
  print MFILE "$tool.user;$workdiruser\n";
  open(SFILE, '>>', $summary_filename) or die ("Cannot open $summary_filename.\n");
  if ($size != 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Litmus was completed with errors. Please review ${workdir}/report/*severity_error_fail_summary.txt");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, "> 0", "FAIL";
  } elsif ($tot_waived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nWarning: Litmus run was completed successfully, but rules that failed were waived. Please review ${rule_summary_report}.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, 0, "PASS";
    $score += ($score_per_tool - 2.5);
  } elsif ($log_errors > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
    print MFILE "$tool.status;FAIL\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "LOG FAIL";
  } else {
    CoreUtils::DualPrint($tee_fp,"\nLitmus run was completed successfully and without waivers.");
    print MFILE "$tool.status;PASS\n";
    printf SFILE "%-25s %-20s %-20s\n", $tool, $log_errors, "PASS";
    $score += $score_per_tool;
  }
  close(SFILE);
  print MFILE "$tool.metric.waived;$tot_waived\n";
  print MFILE "$tool.metric.tot_errors;$size\n";
  print MFILE "$tool.metric.changed_rules;$changed_rules\n";
  close(MFILE);
}

sub log_errors {
  my ($tool_log) = @_;
  my $orig_name = $tool_log;
  ( $tool_log ) = glob($tool_log);
  my $log_errors = 0;
  $tech_process_dir = "";
  if (! defined $tool_log || ! -f $tool_log) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} ($tool) run was unsuccessful. Failed to detect log file ${orig_name}.");
    return 1;
  } else {
    open(LOGFILE,"<$tool_log") or die ("Cannot open ${tool_log}.\n");
    CoreUtils::DualPrint($tee_fp,"\nChecking $toolname_map{$tool} ($tool) log: ".abs_path(${tool_log}).".");
    while(<LOGFILE>) {
      if ($tech_process_dir eq "") {
        if ($_ =~ /Parsing file (\S+)/) {
          $tech_process_dir = $1;
        }
        if ($_ =~ /Reading file (\S+)/) {
          $tech_process_dir = $1;
          $tech_process_dir =~ s/\'//g;
        }
        if ($_ =~ /Finished reading library (\S+)/) {
          $tech_process_dir = $1;
        }
      }
      if ($_ =~ /(^\/\/ Error:|\[ERROR|^ERROR|^Error|invalid command name|\/\/ Warning: Error exit from dofile)/) {
        chomp($_);
        CoreUtils::DualPrint($tee_fp,"$_");
        $log_errors++;
      }
    }
    close(LOGFILE);
    if ($tech_process_dir =~ /^\//) {
      $tech_process_dir = dirname($tech_process_dir);
    }
    $tech_process_dir =~ s/\.$//;
    if ($log_errors > 0) {
      CoreUtils::DualPrint($tee_fp,"\nFound errors in $toolname_map{$tool} log. Please verify it.");
      return $log_errors;
    } else {
      CoreUtils::DualPrint($tee_fp,"\nNo errors were found in $toolname_map{$tool} log.");
      return 0;
    }
  }
}

sub folder_check {
  my ($dir) = @_;
  my $dirtouse = "";
  if (! exists $directory{$tool}) {
    my @dirlists = ();
    @dirlists = glob($dir);
    if (!@dirlists) {
      CoreUtils::DualPrint($tee_fp,"\nError: Didn't find any folder with pattern ${dir} in current directory. Please change current directory, or use -dir \"$tool <dir>\".\n");
      return 0;
    } else {
      my @dates = ();
      foreach my $dir (@dirlists) {
        (my $date = $dir)  =~ s/.*\///g;
        $date =~ s/${tool}|joules|_run_//g;
        $date =~ s/_Flow_\d//g;
        my $newdate = substr($date, 4, 4).substr($date, 0, 2).substr($date, 2, 2).substr($date, 9, 6);
        push(@dates, $newdate);
      }
      @dates = sort {$b <=> $a} @dates;
      my $chosendate = $dates[0];
      if ($tool =~ /joules/) {
        $dirtouse = "joules_run_".substr($chosendate, 4, 2).substr($chosendate, 6, 2).substr($chosendate, 0, 4)."_".substr($chosendate, 8, 6);
        ($dirtouse) = glob("$dirtouse*");
      } else {
        $dirtouse = "${tool}_run_".substr($chosendate, 4, 2).substr($chosendate, 6, 2).substr($chosendate, 0, 4)."_".substr($chosendate, 8, 6);
      }
    }
  } else {
    $dirtouse = $directory{$tool};
  }
  if (-d $dirtouse) {
    CoreUtils::DualPrint($tee_fp,"\nScript will use folder: $dirtouse.");
    return $dirtouse;
  } else {
    CoreUtils::DualPrint($tee_fp,"\n$dirtouse doesn't exist. Please define correct folder using -dir \"$tool <dir>\".");
    return 0;
  }
}

sub which_exe {
  my ($exe_name) = @_;
  my @envpaths = split(/:/,$ENV{PATH});
  foreach my $path (@envpaths) {
    if (-e "$path/$exe_name") {
      return "$path/$exe_name"; 
    }
  }
  return "0";
}
