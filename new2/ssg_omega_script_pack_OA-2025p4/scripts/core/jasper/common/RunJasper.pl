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
use Cwd qw(abs_path);
use POSIX;
use English;
use File::Path;
use File::Copy;
use File::Basename;
use File::Spec::Functions qw(:ALL);
use FindBin qw($RealBin);

use lib "$RealBin/../../common/";
use CoreUtils;

#########################################################
# Setup and documentation				#
#########################################################

my $script_options = "@ARGV";
my $help = 0;
my $ret;
my $pwd = cwd();
my $datestamp = `date +%m%d%Y_%H%M%S`;
chomp($datestamp);
my %app_hash;
$app_hash{cdc} =       {supported => 1, min_stage => 1, max_stage => 6, selected => 0, has_hier_flow => 1, app_tag => "-cdc",       output_dirs => [qw(db csv html report collateral)]};
$app_hash{mcp} =       {supported => 1, min_stage => 1, max_stage => 4, selected => 0, has_hier_flow => 0, app_tag => "-mcp",       output_dirs => [qw(db report collateral)]};
$app_hash{lpv} =       {supported => 0, min_stage => 1, max_stage => 7, selected => 0, has_hier_flow => 0, app_tag => "-lpv",       output_dirs => [qw(db report collateral)]};
$app_hash{superlint} = {supported => 1, min_stage => 1, max_stage => 5, selected => 0, has_hier_flow => 1, app_tag => "-superlint", output_dirs => [qw(db csv html report collateral)]};
my ($rtl_flow,$hier_flow,$threadcount,$dirclean) = (1,0,1,0);
my ($run_stage,$gen_reports,$add_perl_vars,$envload) = (0,0,1,0);
my ($workdir,$jg_app,$ten_dpc,$invoke_gui,$bsub_args) = ("","",0,0,"");
my ($bsubCmd,$jgExe,$jgCmd,$runlog,$rule_summary_report) = ("","","","","");
my @dirs_to_create = ();
my $rule_level;

my $usage = <<USAGE;
$0 [options]

This script controls the various Jasper Apps that need to be run
to satisfy the Omega validation flow requirements. Do not rename
or move any of the TCL scripts provided with this Perl script.
Jasper Apps can only be run one at a time. An App of the set
{superlint,cdc,mcp,lpv} must be specified, as no default is set.

NOTE: For multithreading, by default the scripts take the value
      of the "tool_thread_count" variable from within
      omega_user_vars.tcl. However this value may be
      overridden by the \$CDNS_MULTITHREAD_COUNT environment
      variable.

Current functionality:

App	    Supported	Required Version
----------------------------------------
Superlint   Yes		2025.03p001
CDC	    Yes		2025.03p001
MCP	    Yes		2025.03p001
LPV         No

-dir <dir>	Specify the target output directory for all generated
		Jasper content. If not specified, the default
		is ./jasper_<app>_run_${datestamp}

-app <string>	Specify which Jasper App to run. This is mandatory.
		Allowed value is one of {superlint,cdc,mcp,lpv}
		subject to the support table shown above.
		No default is set.

-gui		Launch Jasper with GUI and interactive command shell.
		If not specified, Jasper runs in batch mode.

-stage <int>	If using Jasper interactively via the "-gui" option, it is
		often useful to run the flow script up to a certain stage in
		the App and then continue to use the GUI to debug issues
		as they are found. Specify the number of the corresponding
		stage from the table below. For example, "-stage 3" on
		the CDC app would complete clock domain identification, CDC
		pair location, and scheme detection, then stop for interactive
		use. The "-stage" option is only valid with the "-gui" option.
		If the "-stage" option is not used, Jasper will complete the
		full run with report generation.

		Stage # |      CDC      |     MCP     |     LPV     |    Lint     |
		--------|---------------|-------------|-------------|-------------|
		   1    | load design   | load design | load design | load design |
		   2    | domain        | generate    | load upf    | configure   |
		   3    | scheme        | prove       | generate    | extract     |
		   4    | reset         | full run    | structural  | prove       |
		   5    | metastability |             | functional  | full run    |
		   6    | full run      |             | prove       |             |
		   7    |               |             | full run    |             |

-rules <str>	Configure the number and severity of Jasper Superlint rules that
		are being applied. The "-rules" option is only valid if specified
		with "-app superlint". The default set of rules used by Jasper
		is defined within <install_dir>/etc/res/rtlds/rules/superlint.def.
		The custom set of rules used by the Omega flow is defined within
		core/jasper/superlint/jasper_superlint_core_rules.tcl. Use this
		option to adjust the ruleset to one of the following levels:

		   <str> value	   | Description
		-------------------|-------------------------------------------------
		     sanity	   | Basic custom set of severity warning and error
				   | rules from the following categories: synthesis,
				   | structural, blackbox, dft_functional, integration,
				   | test_coverage
				   |
		 custom_no_formal  | All rules defined in jasper_superlint_core_rules.tcl
				   | but excluding the AUTO_FORMAL domain rules (default)
				   |
		custom_with_formal | All rules defined in jasper_superlint_core_rules.tcl
				   |
		   full_install	   | All rules defined within the default superlint.def
				   | file that comes installed with Jasper

		The "custom_no_formal" option is the default. Note the user can further
		manipulate rules using the jasper_superlint_user_rule_settings.tcl file.

-hier		Perform a hierarchical analysis for the supported set of Apps:
		{superlint,cdc}. Each sub-module IP must first be run through the
		standard top-down App flow and declared clean. A subsequent run
		using this "-hier" option will load all sub-module jdb files and
		perform the App analysis again at the top-level, with additional rules
		activated for consistency checking between the top-level and sub-modules.
		See the "hier_jdb_mod_app" user variable description for more details.

-bsub "args"	Specify the entire bsub option string containing:
		    queue, host, resource, memory requirements
		but omitting:
		    threadcount, target tool, input TCL file
		If not specified, the default behavior is to directly
		call the Jasper executable; whether or not you have
		a wrapper script, this will either run on the local
		machine outside of LSF or run LSF with your custom
		wrapper script. The path to the Jasper executable may be
		set via the \$JASPER environment variable; if not specified, it
		will call "jasper" directly and rely on the local environment.
		Contents must be specified in quotes, for example:
		"-q rc -m tencad -R span[hosts=1] -Ip"
		If running in TenDPC, "-bsub" should not be used.

-clean		Force the deletion of any pre-existing output directories
		of the type jasper_<app>_run_<date> from the invocation
		directory of this script.

-envload	Prior to reading omega_user_vars.tcl, import the entire set of
		environment variables and assign them to global TCL variables of
		the same name.

-tip		Setup LSF environment for running within TenDPC. This
		option cannot be specified together with "-bsub".
USAGE

$ret = GetOptions(
         "help"    => \$help,
	 "tip"     => \$ten_dpc,
	 "gui"     => \$invoke_gui,
	 "stage=i" => \$run_stage,
	 "rules=s" => \$rule_level,
	 "hier"    => \$hier_flow,
	 "clean"   => \$dirclean,
	 "envload" => \$envload,
	 "dir=s"   => \$workdir,
	 "app=s"   => \$jg_app,
	 "bsub=s"  => \$bsub_args);

if ($help || ! $ret) {
  print "$usage";
  exit;
}

die "Error: The \"-app\" option must be specified.\n" if ($jg_app eq "");
die "Error: Invalid App name \"$jg_app\".\n" unless (defined $app_hash{$jg_app});
die "Error: The $jg_app App is not currently supported.\n" unless ((defined $app_hash{$jg_app}) && ($app_hash{$jg_app}{supported} == 1));
die "Error: The \"-tip\" and \"-bsub\" options are mutually exclusive.\n" if (($ten_dpc == 1) && ($bsub_args ne ""));
die "Error: The \"-stage\" option requires the \"-gui\" option.\n" if (($run_stage != 0) && ($invoke_gui == 0));
die "Error: The $jg_app App does not support a hierarchical flow.\n" if (($hier_flow == 1) && ($app_hash{$jg_app}{has_hier_flow} == 0));
if (defined $rule_level) {
  die "Error: The \"-rules\" option can only be used with \"-app superlint\".\n" unless ($jg_app eq "superlint");
  unless ($rule_level =~ /^(sanity|custom_no_formal|custom_with_formal|full_install)$/) {
    die "Error: The \"-rules\" option must be one of \"sanity\", \"custom_no_formal\", \"custom_with_formal\" or \"full_install\".\n";
  }
} else {
  $rule_level = "custom_no_formal";
}

if ($run_stage != 0) {
  if (($run_stage < $app_hash{$jg_app}{min_stage}) || ($run_stage > $app_hash{$jg_app}{max_stage})) {
    die "Error: The $jg_app App accepts stages $app_hash{$jg_app}{min_stage} through $app_hash{$jg_app}{max_stage}, not ${run_stage}.\n";
  }
} else {
  $run_stage = $app_hash{$jg_app}{max_stage};
}
$gen_reports = 1 if ($run_stage == $app_hash{$jg_app}{max_stage});

if ($workdir eq "") {
  $workdir = "$pwd/" . "jasper_" . $jg_app . "_run_" . $datestamp;
} else {
  $workdir =~ s/^\.\///;
  $workdir = "$pwd/" . $workdir if ($workdir !~ /^\//);
}

my @prevdirs = <$pwd/jasper_${jg_app}_run_*>;
if ($dirclean && (scalar(@prevdirs) > 0)) {
  foreach my $onedir (@prevdirs) {
    CoreUtils::RunSystemCommand("rm -fr $onedir");
  }
}
if (-d $workdir) {
  CoreUtils::RunSystemCommand("rm -fr $workdir");
}
my $scriptdir = rel2abs("$RealBin");

if (defined $app_hash{$jg_app}) {
  $app_hash{$jg_app}{selected} = 1;
  $jgCmd = $app_hash{$jg_app}{app_tag};
  $runlog = "${workdir}/jg_${jg_app}_run.log";
  @dirs_to_create = @{$app_hash{$jg_app}{output_dirs}};
}

foreach my $dtc (@dirs_to_create) {
  mkpath "$workdir/$dtc";
}
chdir $workdir;

my $teelog = "${workdir}/prl_stdout_tee.log";
my $tee_fp = new FileHandle ($teelog, '>');
die "$0: $! - Cannot create $teelog\n" unless defined $tee_fp;

#########################################################
# Edit omega_user_vars.tcl to local copy		#
#########################################################

my $loc_user_vars = "${workdir}/omega_local_user_vars.tcl";
my $out_fp = new FileHandle ($loc_user_vars, '>');
die "$0: $! - Cannot create $loc_user_vars\n" unless defined $out_fp;
my $golden_user_vars = "$scriptdir/../../../user/common/omega_user_vars.tcl";
my $user_vars_root_dir = dirname(abs_path($golden_user_vars));
open(INFILE,"<$golden_user_vars") or die ("Cannot open ${golden_user_vars}.\n");
while(<INFILE>) {
  if ($_ =~ /^#\s+their\s+descriptions\./) {
    print $out_fp $_;
    print $out_fp "#\t\t\t\t\t\t\t#\n# NOTE: this file has been processed by RunJasper.pl\t#\n#\t\t\t\t\t\t\t#\n";
    if ($envload == 1) {
      for (my $index = 0; $index < 2; $index++) {
	$_ = <INFILE>;
	print $out_fp $_;
      }
      CoreUtils::ImportEnv2Tcl($out_fp);
    }
  } elsif ($_ =~ /^\s*set\s+rtl_flow\s+(\S+)\s*$/) {
    $rtl_flow = $1;
    print $out_fp $_;
  } elsif ($_ =~ /^\s*set\s+tool_thread_count\s+(\S+)\s*$/) {
    $threadcount = $1;
    if (exists $ENV{CDNS_MULTITHREAD_COUNT} && defined $ENV{CDNS_MULTITHREAD_COUNT}) {
      CoreUtils::DualPrint($tee_fp,"Info: environment variable \$CDNS_MULTITHREAD_COUNT is already set to $ENV{CDNS_MULTITHREAD_COUNT}; overriding \"tool_thread_count\" variable.");
      $threadcount = $ENV{CDNS_MULTITHREAD_COUNT};
    } else {
      CoreUtils::DualPrint($tee_fp,"Info: using \"tool_thread_count\" value of $threadcount for \$CDNS_MULTITHREAD_COUNT environment variable.");
      $ENV{CDNS_MULTITHREAD_COUNT} = $threadcount;
    }
    print $out_fp "set tool_thread_count $threadcount\n";
  } else {
    print $out_fp $_;
  }
}
if ($add_perl_vars) {
  print $out_fp "\n##########################################\n# Additional variables from RunJasper.pl #\n##########################################\n\n";
  print $out_fp "set prl_gui ${invoke_gui}\n";
  print $out_fp "set prl_stage ${run_stage}\n";
  print $out_fp "set prl_rule_level ${rule_level}\n";
  print $out_fp "set prl_hier_flow ${hier_flow}\n";
  print $out_fp "set prl_generate_reports ${gen_reports}\n";
  print $out_fp "set prl_run_cdc $app_hash{cdc}{selected}\n";
  print $out_fp "set prl_run_mcp $app_hash{mcp}{selected}\n";
  print $out_fp "set prl_run_lpv $app_hash{lpv}{selected}\n";
  print $out_fp "set prl_run_superlint $app_hash{superlint}{selected}\n";
  print $out_fp "set prl_user_vars_root_dir ${user_vars_root_dir}\n";
  print $out_fp "set prl_script_root_dir ${scriptdir}\n";
  print $out_fp "set prl_stamped_base_dir ${workdir}\n";
}
close(INFILE);
close($out_fp);

#########################################################
# Define Jasper options and invoke tool			#
#########################################################

if ($ten_dpc) {
  CoreUtils::DualPrint($tee_fp,"Info: invoking Jasper executable through TIP loc_jg wrapper script.");
  $jgExe = "loc_jg";
} elsif ($bsub_args eq "") {
  CoreUtils::DualPrint($tee_fp,"Info: invoking Jasper executable directly.");
  $jgExe = "jg";
} else {
  CoreUtils::DualPrint($tee_fp,"Info: invoking Jasper through user-specified LSF commands.");
  if (exists $ENV{JASPER} && defined $ENV{JASPER}) {
    CoreUtils::DualPrint($tee_fp,"Info: using the existing \$JASPER environment variable to invoke Jasper.");
    $ENV{PATH} = "$ENV{JASPER}/bin:$ENV{PATH}";
    $jgExe = "$ENV{JASPER}/bin/jg";
  } else {
    CoreUtils::DualPrint($tee_fp,"Warning: the \$JASPER environment variable is undefined; bsub will just use \"jg\" directly.");
    $jgExe = "jg";
  }
  $bsubCmd = "bsub -n ${threadcount},${threadcount} " . $bsub_args;
}

$jgCmd .= " -batch" unless $invoke_gui;
$jgCmd .= " -proj ${workdir}/jgproject";
$jgCmd .= " ${scriptdir}/top_down_jasper.tcl";

my $input_message = ($rtl_flow) ? "RTL" : "netlist";
CoreUtils::DualPrint($tee_fp,"Info: $jg_app App will run at the $input_message level.") if ($jg_app eq "cdc");
my $mode_message = ($hier_flow) ? "hierarchical" : "top-down";
CoreUtils::DualPrint($tee_fp,"Info: $jg_app App will run in $mode_message mode.") if ($app_hash{$jg_app}{has_hier_flow} == 1);
CoreUtils::DualPrint($tee_fp,"Info: rule check level is set to \"${rule_level}\".") if ($jg_app eq "superlint");

open(DEBUGFILE,">${workdir}/debug.cmd") or die ("Cannot create ${workdir}/debug.cmd.\n");
print DEBUGFILE "Original command line:\n\n";
print DEBUGFILE "$PROGRAM_NAME $script_options\n\n";
print DEBUGFILE "Which translates to this Jasper invocation:\n\n";

if ($bsub_args eq "") {
  print DEBUGFILE "$jgExe $jgCmd > $runlog 2>&1\n";
  CoreUtils::RunSystemCommand("$jgExe $jgCmd > $runlog 2>&1");
} else {
  print DEBUGFILE "$bsubCmd \"$jgExe $jgCmd\" > $runlog 2>&1\n";
  CoreUtils::RunSystemCommand("$bsubCmd \"$jgExe $jgCmd\" > $runlog 2>&1");
}

close(DEBUGFILE);

chdir $pwd;

if ($jg_app eq "cdc") {
  my $ipqc_clockmatrix_file = <${workdir}/csv/*_cdc_ipqc.csv_clockmatrix.csv>;
  unlink $ipqc_clockmatrix_file if (-r $ipqc_clockmatrix_file);
  $rule_summary_report = <${workdir}/report/*all_cdc_violations_summary.txt>;
} elsif ($jg_app eq "superlint") {
  $rule_summary_report = <${workdir}/report/*_summary.txt>;
} elsif ($jg_app eq "mcp") {
  $rule_summary_report = <${workdir}/report/*_audit_summary.txt>;
}
&JasperRunCheck($runlog,$rule_summary_report,$gen_reports,$jg_app,$run_stage,$tee_fp);
close($tee_fp);

#########################################################
# Subroutines unique to RunJasper.pl			#
#########################################################

sub JasperSummaryFileCheck {
  my ($loc_fail_count,$app_summary_report,$loc_app,$loc_fp) = @_;
  my ($loc_tag,$loc_severity,$loc_checks,$loc_waived,$loc_total) = ("","",0,0,0);
  my ($loc_err_cnt,$loc_warn_cnt,$loc_info_cnt,$total_problem_count) = (0,0,0,0);
  my ($loc_mcp_prov,$loc_mcp_viol,$loc_mcp_unreach,$loc_mcp_undeter,$loc_mcp_unproc) = (0,0,0,0,0);
  my ($loc_mcp_sdc_problem_count,$loc_mcp_proven_count,$loc_sdc_failed,$loc_sdc_unsup) = (0,0,0,0);
  my ($loc_sdc_good,$loc_mcp_sdc_good_count) = (0,0);
  if (!(-r $app_summary_report)) {
    CoreUtils::DualPrint($loc_fp,"Error: Jasper $loc_app reporting was unsuccessful. Failed to detect $loc_app violation summary file ${app_summary_report}.");
    $loc_fail_count++;
  } else {
    open(SUMFILE,"<$app_summary_report") or die ("Cannot open ${app_summary_report}.\n");
    if ($loc_app eq "cdc") {
      while(<SUMFILE>) {
	if ($_ =~ /^\s*Tag\s+\|\s+Severity\s+\|\s+Checks/) {
	  until (($_ =~ /\*\*\*\*\*/) || (eof)) {
	    $_ = <SUMFILE>;
	    if ($_ =~ /^\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
	      $loc_tag = $1;
	      $loc_severity = $2;
	      $loc_checks = $3;
	      $loc_waived = $4;
	      $loc_total = $5;
	      next if ($loc_tag eq "Total");
	      $total_problem_count += $loc_checks;
	    }
	  }
	}
      }
    } elsif ($loc_app eq "superlint") {
      while(<SUMFILE>) {
	if ($_ =~ /^\s*Category\s+\|\s+Error\s+\|\s+Warning\s+\|\s+Info/) {
	  until (($_ =~ /\*\*\*\*\*/) || (eof)) {
	    $_ = <SUMFILE>;
	    if ($_ =~ /^\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
	      $loc_tag = $1;
	      $loc_err_cnt = $2;
	      $loc_warn_cnt = $3;
	      $loc_info_cnt = $4;
	      $loc_waived = $5;
	      $loc_total = $6;
	      next if ($loc_tag eq "Total");
	      $total_problem_count += ($loc_err_cnt + $loc_warn_cnt + $loc_info_cnt);
	    }
	  }
	}
      }
    } elsif ($loc_app eq "mcp") {
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
	    if ($_ =~ /^\s*\|\s+(MCP|FP)\s+\(\S+\)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+(\S+)\s+\|\s+\S+\s+\|\s+\S+\s*$/) {
	      $loc_mcp_prov = $2;
	      $loc_mcp_viol = $3;
	      $loc_mcp_unreach = $4;
	      $loc_mcp_undeter = $5;
	      $loc_mcp_unproc = $6;
	      $loc_mcp_proven_count += $loc_mcp_prov;
	      $total_problem_count += ($loc_mcp_viol + $loc_mcp_unreach + $loc_mcp_undeter + $loc_mcp_unproc);
	    }
	  }
	}
      }
    }
    close(SUMFILE);
    if ($loc_app eq "mcp") {
      if ($loc_mcp_sdc_problem_count > 0) {
	CoreUtils::DualPrint($loc_fp,"Error: Jasper $loc_app validation shows a total of $loc_mcp_sdc_problem_count MCP/FP SDC commands that failed to load. Review the following file: ${app_summary_report}.");
	$loc_fail_count++;
      } elsif (($loc_mcp_sdc_good_count > 0) && ($loc_mcp_proven_count == 0) && ($total_problem_count == 0)) {
	CoreUtils::DualPrint($loc_fp,"Error: Jasper $loc_app validation shows successfully loaded MCP/FP SDC commands but none that are proven. Review the following file: ${app_summary_report}.");
	$loc_fail_count++;
      } elsif ($total_problem_count > 0) {
	CoreUtils::DualPrint($loc_fp,"Error: Jasper $loc_app validation shows a total of $total_problem_count MCP/FP SDC commands that are not successfully proven. Review the following file: ${app_summary_report}.");
	$loc_fail_count++;
      } else {
	CoreUtils::DualPrint($loc_fp,"Info: Jasper $loc_app completed with no unwaived failing checks; the validation was successful.");
      }
    } else {
      if ($total_problem_count > 0) {
	CoreUtils::DualPrint($loc_fp,"Error: Jasper $loc_app validation shows a total of $total_problem_count unwaived error/warning/info messages. Review the following file: ${app_summary_report}.");
	$loc_fail_count++;
      } else {
	CoreUtils::DualPrint($loc_fp,"Info: Jasper $loc_app completed with no unwaived failing checks; the validation was successful.");
      }
    }
  }
  return $loc_fail_count;
}

sub JasperRunCheck {
  my ($log,$summary,$reports,$loc_app,$loc_stage,$loc_fp) = @_;
  my ($log_error_count,$fail_count) = (0,0);
  if (!(-r $log)) {
    CoreUtils::DualPrint($loc_fp,"Error: Jasper $loc_app run was unsuccessful. Failed to detect logfile ${log}.");
    $fail_count++;
  } else {
    CoreUtils::DualPrint($loc_fp,"Info: Summary of Jasper $loc_app logfile issues:");
    open(LOGFILE,"<$log") or die ("Cannot open ${log}.\n");
    while(<LOGFILE>) {
      if ($_ =~ /(\[ERROR|^ERROR|^Error   :)/) {
	CoreUtils::DualPrint($loc_fp,$_);
	$log_error_count++;
      }
    }
    close(LOGFILE);
    if ($log_error_count > 0) {
      CoreUtils::DualPrint($loc_fp,"Error: Jasper $loc_app run was unsuccessful due to above errors.");
      $fail_count++;
    } else {
      CoreUtils::DualPrint($loc_fp,"Info: Jasper $loc_app run log is free of errors.");
    }
  }
  if ($reports == 1) {
    $fail_count = &JasperSummaryFileCheck($fail_count,$summary,$loc_app,$loc_fp);
    if ($fail_count == 0) {
      CoreUtils::DualPrint($loc_fp,"Jasper $loc_app run status: FULL PASS - logfile and reports are clean.");
    }
  } else {
    CoreUtils::DualPrint($loc_fp,"Info: reports are only generated for a full run.");
    if ($fail_count == 0) {
      CoreUtils::DualPrint($loc_fp,"Jasper $loc_app run status: STAGE $loc_stage COMPLETE - logfile is clean, but there are no reports to parse at this intermediate stage.");
    }
  }
  if ($fail_count > 0) {
    CoreUtils::DualPrint($loc_fp,"Jasper $loc_app run status: FAIL - see above error messages.");
  }
}
