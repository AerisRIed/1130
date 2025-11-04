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
my @tools = ('clp_comp', 'clp_lint', 'jasper_cdc', 'jasper_mcp', 'jasper_superlint', 'joules_flow1', 'joules_flow2', 'joules_flow3', 'litmus1');
my %toolname_map = (
  "clp_comp" => "CLP Compare",
  "clp_lint" => "CLP Lint",
  "jasper_cdc" => "Jasper CDC",
  "jasper_mcp" =>  "Jasper MCP",
  "jasper_superlint" =>  "Jasper Superlint",
  "joules_flow1" => "Joules Flow 1",
  "joules_flow2" => "Joules Flow 2",
  "joules_flow3" => "Joules Flow 3",
  "litmus1" => "Litmus",
);
my @tools_to_score = ('clp_comp', 'clp_lint', 'jasper_cdc', 'jasper_mcp', 'jasper_superlint', 'joules_flow3', 'litmus1');
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
";

$ret = GetOptions(
    "help" => \$help,
    "dir=s" => \$dir,
    "signoff" => \$signoff,
    "disable_tool=s" => \$disable_tool);

if ($help || ! $ret) {
  print "$usage";
  exit;
}


our %directory;
our $tool;
our $score = 0;

my $workdir = "$pwd/" . "output_validation_" . $datestamp;
mkpath "$workdir";

my $teelog = $workdir."/omega_validation_report.txt";
my $tee_fp = new FileHandle ($teelog, '>');
die "$0: $! - Cannot create $teelog\n" unless defined $tee_fp;

my $metrics_filename = $workdir."/omega_metrics.csv";

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
    my $required_tools = "clp_lint|jasper_superlint|joules_flow3|litmus1";
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

  @tools = grep {! ($_ ~~ @disable_tools) } @tools;
  @tools_to_score = grep {! ($_ ~~ @disable_tools) } @tools_to_score;
  CoreUtils::DualPrint($tee_fp,"\n".basename($0)." will exclude ".join(', ',@disable_tools)." from the analysis.\n");

  $score_per_tool = sprintf("%.2f", 100/($#tools_to_score + 1));
}

open(MFILE, '>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
print MFILE "metric; flow_phase; count\n";
close(MFILE);

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

sub jasper_cdc_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    return;
  }
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
  print MFILE "design.cdc.error; cdc; $tot_error\n";
  print MFILE "design.cdc.error_waived; cdc; $tot_error_waived\n";
  print MFILE "design.cdc.warn; cdc; $tot_warn\n";
  print MFILE "design.cdc.warn_waived; cdc; $tot_warn_waived\n";
  print MFILE "design.cdc.info; cdc; $tot_info\n";
  print MFILE "design.cdc.total; cdc; $total_problem_count\n";
  print MFILE "design.cdc.total_waived; cdc; $tot_waived\n";
  print MFILE "design.cdc.total_unwaived; cdc; $total_problem_count_unwaived\n";
  print MFILE "design.cdc.number_of_gates; cdc; $number_gates\n";
  print MFILE "design.cdc.number_of_flops; cdc; $number_flops\n";
  close(MFILE);

  if ($total_problem_count_unwaived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper CDC validation shows a total of $total_problem_count_unwaived unwaived error/warning/info messages. Review the following file: ".join(', ',@report_errors).".");
  } elsif ($tot_waived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nWarning: Jasper CDC validation shows a total of 0 problems, but contains $tot_waived waived messages. Please review all waivers.");
    $score += ($score_per_tool - 2.5);
  } elsif ($log_errors > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
  } else {
    CoreUtils::DualPrint($tee_fp,"\nJasper CDC completed with no unwaived checks; the validation was successful.");
    $score += $score_per_tool;
  }
}

sub jasper_mcp_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    return;
  }
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
  print MFILE "design.mcp.sdc_failed; mcp; $loc_mcp_sdc_problem_count\n";
  print MFILE "design.mcp.sdc_good; mcp; $loc_mcp_sdc_good_count\n";
  print MFILE "design.mcp.proven; mcp; $tot_prov\n";
  print MFILE "design.mcp.violation; mcp; $tot_viol\n";
  print MFILE "design.mcp.unreachable; mcp; $tot_unreach\n";
  print MFILE "design.mcp.undetermined; mcp; $tot_undeter\n";
  print MFILE "design.mcp.unprocessed; mcp; $tot_unproc\n";
  print MFILE "design.mcp.waived; mcp; $tot_waived\n";
  print MFILE "design.mcp.total_issues; mcp; $total_problem_count\n";
  close(MFILE);
  if ($loc_mcp_sdc_problem_count > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper MCP validation shows a total of $loc_mcp_sdc_problem_count MCP/FP SDC commands that failed to load. Review the following file: ${rule_summary_report}.");
  } elsif (($loc_mcp_sdc_good_count > 0) && ($tot_prov == 0) && ($total_problem_count == 0)) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper MCP validation shows successfully loaded MCP/FP SDC commands but none that are proven. Review the following file: ${rule_summary_report}.");
  } elsif ($total_problem_count > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper MCP validation shows a total of $total_problem_count MCP/FP SDC commands that are not successfully proven. Review the following file: ${rule_summary_report}.");
  } elsif ($tot_waived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nWarning: Jasper MCP validation shows a total of 0 problems, but contains $tot_waived waived messages. Please review all waivers.");
    $score += ($score_per_tool - 2.5);
  } elsif ($log_errors > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
  } else {
    CoreUtils::DualPrint($tee_fp,"\nInfo: Jasper MCP completed with no unwaived failing checks; the validation was successful.");
    $score += $score_per_tool;
  }
}


sub jasper_superlint_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    return;
  }
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
  print MFILE "design.superlint.error; superlint; $tot_error\n";
  print MFILE "design.superlint.error_waived; superlint; $tot_error_waived\n";
  print MFILE "design.superlint.warn; superlint; $tot_warn\n";
  print MFILE "design.superlint.warn_waived; superlint; $tot_warn_waived\n";
  print MFILE "design.superlint.info; superlint; $tot_info\n";
  print MFILE "design.superlint.total; superlint; $total_problem_count\n";
  print MFILE "design.superlint.total_waived; superlint; $tot_waived\n";
  print MFILE "design.superlint.total_unwaived; superlint; $total_problem_count_unwaived\n";
  print MFILE "design.superlint.total_coverage; superlint; $total_coverage\n";
  print MFILE "design.superlint.detectable_coverage; superlint; $detectable_coverage\n";
  print MFILE "design.superlint.ignored_coverage; superlint; $ignored_coverage\n";
  print MFILE "design.superlint.inactive_coverage; superlint; $inactive_coverage\n";
  print MFILE "design.superlint.untested_coverage; superlint; $untested_coverage\n";
  print MFILE "design.superlint.redundant_coverage; superlint; $redundant_coverage\n";
  print MFILE "design.superlint.estimated_coverage; superlint; $estimated_coverage\n";
  print MFILE "design.superlint.number_of_gates; superlint; $number_gates\n";
  print MFILE "design.superlint.number_of_flops; superlint; $number_flops\n";
  close(MFILE);

  if ($total_problem_count_unwaived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Jasper superlint validation shows a total of $total_problem_count_unwaived\n unwaived error/warning/info messages. Review the following file: ".join(', ',@report_errors).".");
  } elsif ($tot_waived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nWarning: Jasper superlint validation shows a total of 0 problems, but contains $tot_waived waived messages. Please review all waivers.");
    $score += ($score_per_tool - 2.5);
  } elsif ($log_errors > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
  } else {
    CoreUtils::DualPrint($tee_fp,"\nJasper superlint completed with no unwaived checks; the validation was successful.");
    $score += $score_per_tool;
  }
}

sub joules_flow1_check {
  my $workdir = &folder_check("joules_run_*Flow_1");
  if ($workdir eq 0) {
    return;
  }
  my $tool_log = abs_path("${workdir}/joules_rtl_run.log");
  my $log_errors = &log_errors($tool_log);
  my $rule_summary_report = abs_path(<${workdir}/power_estimate/Joules_CTS.rpt>);
  my ($buf_leaf, $buf_branch, $buf_root) = (0,0,0);
  my ($cts_levels, $cts_endpoints) = (0,0);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: Joules Flow 1 reporting was unsuccessful. Failed to detect ${workdir}/power_estimate/Joules_CTS.rpt file.");
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
  print MFILE "design.joules.buf_root; joules; $buf_root\n";
  print MFILE "design.joules.buf_branch; joules; $buf_branch\n";
  print MFILE "design.joules.buf_leaf; joules; $buf_leaf\n";
  print MFILE "design.joules.cts_levels; joules; $cts_levels\n";
  print MFILE "design.joules.cts_endpoints; joules; $cts_endpoints\n";
  close(MFILE);
}

sub joules_flow2_check {
  my $workdir = &folder_check("joules_run_*Flow_2");
  if ($workdir eq 0) {
    return;
  }
  my $tool_log = abs_path("${workdir}/joules_rtl_run.log");
  my $log_errors = &log_errors($tool_log);
  my ($odc_flops, $odc_flops_enable, $odc_flops_enable_perc) = (0,0,0);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  my $rule_summary_report = abs_path(<${workdir}/odc_analysis/statistical/odc/structural_cg_odc_pp_mc.rpt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    print "\nError: Joules Flow 2 reporting was unsuccessful. Failed to detect ${workdir}/odc_analysis/statistical/odc/structural_cg_odc_pp_mc.rpt file.";
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
  print MFILE "design.joules.odc_flops; joules; $odc_flops\n";
  print MFILE "design.joules.odc_flops_enable; joules; $odc_flops_enable\n";
  print MFILE "design.joules.odc_flops_enable_perc; joules; $odc_flops_enable_perc\n";
  print MFILE "design.joules.stb_flops; joules; $stb_flops\n";
  print MFILE "design.joules.stb_regbanks; joules; $stb_regbanks\n";
  close(MFILE);
}

sub joules_flow3_check {
  my $workdir = &folder_check("joules_run_*Flow_3");
  if ($workdir eq 0) {
    return;
  }
  my $tool_log = abs_path("${workdir}/joules_rtl_run.log");
  my $log_errors = &log_errors($tool_log);
  my $regcone_report = abs_path(<${workdir}/structural_analysis/reg_cone/reg_cone_summary.rpt>);
  my ($issue_found,$fanin,$fanout,$product,$fanin_pathdepth,$fanout_pathdepth) = (0,0,0,0,0,0);
  my ($maxfanin,$maxfanout,$maxproduct,$maxfanin_pathdepth,$maxfanout_pathdepth) = (0,0,0,0,0);
  my $combo_loops = 1;
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  if (! defined $regcone_report || ! -f $regcone_report) {
    CoreUtils::DualPrint($tee_fp,"\nError: Litmus Flow 3 reporting was unsuccessful. Failed to detect ${workdir}/structural_analysis/reg_cone/reg_cone_summary.rpt.");
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
  print MFILE "design.joules.maxfanin; joules; $maxfanin\n";
  print MFILE "design.joules.maxfanout; joules; $maxfanout\n";
  print MFILE "design.joules.maxproduct; joules; $maxproduct\n";
  print MFILE "design.joules.maxfanin_pathdepth; joules; $maxfanin_pathdepth\n";
  print MFILE "design.joules.maxfanout_pathdepth; joules; $maxfanout_pathdepth\n";
  print MFILE "design.joules.combo_loops; joules; $combo_loops\n";
  close(MFILE);
  if ($combo_loops) {
    CoreUtils::DualPrint($tee_fp,"\nError: Joules showed a combo loop. Please review ${workdir}/structural_analysis/combo_loops/combinational_loops.rpt.");
    $issue_found = 1;
  }
  if ($maxfanin > 10000) {
    CoreUtils::DualPrint($tee_fp,"\nError: Joules showed a fanin greater than 10000. Please review ${workdir}/structural_analysis/reg_cone/reg_cone_summary.rpt.");
    $issue_found = 1;
  }
  if ($maxfanout > 10000) {
    CoreUtils::DualPrint($tee_fp,"\nError: Joules showed a fanout greater than 10000. Please review ${workdir}/structural_analysis/reg_cone/reg_cone_summary.rpt.");
    $issue_found = 1;
  }
  if ($issue_found == 0) {
    if ($log_errors > 0) {
      CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
    } else {
      CoreUtils::DualPrint($tee_fp,"\nJoules completed without big fanin/fanout cones; the validation was successful.");
      $score += $score_per_tool;
    }
  }
}

sub clp_comp_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    return;
  }
  my $tool_log = abs_path("${workdir}/clp_session.log");
  my $log_errors = &log_errors($tool_log);
  my $error_summary_file = abs_path(<${workdir}/report/*.compare_power_intent.rpt>);
  if (! defined $error_summary_file || ! -f $error_summary_file) {
    CoreUtils::DualPrint($tee_fp,"\nError: CLP Compare mode was unsuccessful. Failed to detect ${workdir}/report/*.compare_power_intent.rpt.");
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
    if ($line =~ /Power Intent Compare: Equivalent/) {
      if ($log_errors > 0) {
        CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
      } else {
        CoreUtils::DualPrint($tee_fp,"\nCLP Compare mode showed equivalent UPFs.");
        $score += $score_per_tool;
      }
    } elsif ($line =~ /Power Intent Compare: Non-Equivalent/) {
      CoreUtils::DualPrint($tee_fp,"\nError: CLP Compare mode showed non equivalent points. Please review $error_summary_file.");
    } else {
      CoreUtils::DualPrint($tee_fp,"\nError: CLP Compare report missing compare result. Please review $error_summary_file.");
    }
  }
}

sub clp_lint_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    return;
  }
  my $tool_log = abs_path("${workdir}/clp_session.log");
  my $log_errors = &log_errors($tool_log);
  my $error_summary_file = abs_path(<${workdir}/report/*.rule_check.error.rpt>);
  my $rule_filters_file = abs_path(<${workdir}/report/*.rule_filters.rpt>);
  if (! defined $error_summary_file || ! -f $error_summary_file || ! defined $rule_filters_file || ! -f $rule_filters_file) {
    CoreUtils::DualPrint($tee_fp,"\nError: CLP Lint run was unsucessful. Failed to detect ${workdir}/report/*.rule_check.error.rpt violation summary file.");
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${error_summary_file}.");
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${rule_filters_file}.");
    my $size_summary = -s $error_summary_file;
    my $size_filters = -s $rule_filters_file;
    if ($size_summary != 0) {
      CoreUtils::DualPrint($tee_fp,"\nCLP Lint was completed with errors. Please review ${error_summary_file}");
    } else {
      if ($size_filters != 0) {
        CoreUtils::DualPrint($tee_fp,"\nCLP Lint was completed without errors, but using rule filters. Please review ${rule_filters_file}");
        $score += ($score_per_tool - 2.5);
      } elsif ($log_errors > 0) {
        CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
      } else {
        CoreUtils::DualPrint($tee_fp,"\nCLP Lint was successful. Completed without errors and waivers.");
        $score += $score_per_tool;
      }
    }
  }
}

sub litmus1_check {
  my $workdir = &folder_check($tool."_run_*");
  if ($workdir eq 0) {
    return;
  }
  my $tool_log = abs_path("${workdir}/litmus_*_sdc_run.log");
  my $log_errors = &log_errors($tool_log);
  my ($severity,$pass,$tot_errors,$tot_waived,$changed_rules) = ("","",0,0,0);
  open(MFILE, '>>', $metrics_filename) or die ("Cannot open $metrics_filename.\n");
  my $rule_summary_report = abs_path(<${workdir}/modified_rules/*_changed_rules.txt>);
  if (! defined $rule_summary_report || ! -f $rule_summary_report) {
    CoreUtils::DualPrint($tee_fp,"Error: Litmus run was unsuccessful. Failed to detect ${workdir}/modified_rules/*_changed_rules.txt.");
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
    return;
  } else {
    CoreUtils::DualPrint($tee_fp,"Analyzing $toolname_map{$tool} report: ${error_summary_file}.");
    $size = -s $error_summary_file;
  }
  if ($size != 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: Litmus was completed with errors. Please review ${workdir}/report/*severity_error_fail_summary.txt");
  } elsif ($tot_waived > 0) {
    CoreUtils::DualPrint($tee_fp,"\nWarning: Litmus run was completed successfully, but rules that failed were waived. Please review ${rule_summary_report}.");
    $score += ($score_per_tool - 2.5);
  } elsif ($log_errors > 0) {
    CoreUtils::DualPrint($tee_fp,"\nError: No errors were found in the reports, but found errors in the log file: $tool_log.");
  } else {
    CoreUtils::DualPrint($tee_fp,"\nLitmus run was completed successfully and without waivers.");
    $score += $score_per_tool;
  }
  print MFILE "design.litmus1.waived; litmus1; $tot_waived\n";
  print MFILE "design.litmus1.tot_errors; litmus1; $size\n";
  print MFILE "design.litmus1.changed_rules; litmus1; $changed_rules\n";
  close(MFILE);
}

sub log_errors {
  my ($tool_log) = @_;
  my $orig_name = $tool_log;
  ( $tool_log ) = glob($tool_log);
  my $log_errors = 0;
  if (! defined $tool_log || ! -f $tool_log) {
    CoreUtils::DualPrint($tee_fp,"\nError: $toolname_map{$tool} ($tool) run was unsuccessful. Failed to detect log file ${orig_name}.");
    return 1;
  } else {
    open(LOGFILE,"<$tool_log") or die ("Cannot open ${tool_log}.\n");
    CoreUtils::DualPrint($tee_fp,"\nChecking $toolname_map{$tool} ($tool) log: ".abs_path(${tool_log}).".");
    while(<LOGFILE>) {
      if ($_ =~ /(^\/\/ Error:|\[ERROR|^ERROR|^Error|invalid command name|\/\/ Warning: Error exit from dofile)/) {
        chomp($_);
        CoreUtils::DualPrint($tee_fp,"$_");
        $log_errors++;
      }
    }
    close(LOGFILE);
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

