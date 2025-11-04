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

use lib "$RealBin/../common/";
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
my @dirs_to_create = qw(db applied_filter modified_rules report xlsx collateral);
my ($rtl_flow,$add_perl_vars,$hier_flow) = (1,1,0);
my ($enable_profile,$debug_mode,$envload) = (0,0,0);
my ($workdir,$litmusX,$invoke_gui,$bsub_args) = ("",0,0,"");
my ($rtl_search_path,$top_design,$rule_level) = ("","","std");
my ($threadcount,$dirclean,$no_libs,$force_run) = (1,0,0,0);
my @file_array;

my $usage = <<USAGE;
$0 [options]

This script controls the interface to the Litmus tool that needs to
be run to satisfy the Omega validation flow requirements. Do not
rename or move any of the TCL scripts provided with this Perl script.

NOTE: For multithreading, by default the scripts take the value
      of the "tool_thread_count" variable from within
      omega_user_vars.tcl. However this value may be
      overridden by the \$CDNS_MULTITHREAD_COUNT environment
      variable.

Current functionality:

Tool        Supported    Min Required Version
---------------------------------------------
Litmus1	    Yes          23.20-s700
LitmusX	    No

-dir <dir>	Specify the target output directory for all generated
		Litmus content. If not specified, the default
		is ./litmus[1|X]_run_${datestamp}

-nolib		If specified, Litmus will ignore the contents of the
		MMMC specification file and the "single_corner_libs"
		user variable and instead run without any node-specific
		library files. This is useful for early SDC development.
		Note that if "use_mmmc" is 0 and "single_corner_libs"
		remains empty, then this option is mandatory.

-force		Continue execution of the Litmus TCL script even in
		the presence of errors. Default behavior is to exit
		the session on the first encountered error.

-rules <str>	Configure the number and severity of Litmus rules that
		are being validated. Litmus1 by default has 3.9k total
		rules covering RTL, library, and SDC checks. Use this
		option to change the rule deck to one of three levels:

		<str> value | Description
		------------|---------------------------------------------
		     min    | Minimize the set of constraint signoff rules
			    | to 14 for completeness and correctness; the
			    | basic set to "scrub" the SDC.
			    |
		     std    | Customized set of rules from Front End team
		     	    | that must be error-free to consider the SDC
			    | ready for PD implementation.
			    |
		     all    | Every single Litmus rule is checked, including
			    | those of severity "Note".

		The "std" option is the default. Note the user can further
		manipulate rules using the litmus_user_rule_filters.tcl file.

-hier		Launch Litmus in hierarchical compare mode to perform
		constraint consistency validation between the top-level
		SDC and any number of submodule-level SDCs. All SDCs
		and their respective designs should first be run separately
		through the standard top-down Litmus flow to ensure
		each SDC is clean before attempting the hierarchical flow.
		Note that this option cannot be used in conjunction
		with setting "use_mmmc" to 1. See the "hier_inst_sdc"
		user variable description for more details.

-gui		Launch Litmus GUI at the end of the run script instead
		of directly exiting. As the tool is still in batch
		mode, no command line access is provided. To properly
		exit the flow, select "exit" from the GUI menu and
		confirm your choice; otherwise this Perl script will
		not complete. If not specified, Litmus will directly
		exit out of batch mode at the end of the flow.

-bsub "args"	Specify the entire bsub option string containing:
		    queue, host, resource, memory requirements
		but omitting:
		    threadcount, input TCL file
		If not specified, the default behavior is to directly
		call the Litmus executable; whether or not you have
		a wrapper script, this will either run on the local
		machine outside of LSF or run LSF with your custom
		wrapper script. The path to the Litmus executable
		may be set via the \$CDN_LITMUS_ROOT environment
		variable; if not specified, it will call "litmus"
		directly and rely on the local environment. Contents
		must be specified in quotes, for example:
		"-q rc -m tencad -R span[hosts=1] -Ip"
		If running in TenDPC, -bsub should not be used.

-clean		Force the deletion of any pre-existing output
		directories of the type litmus[1|X]_run_<date>
		from the invocation directory of this script.

-envload	Prior to reading omega_user_vars.tcl, import the entire
		set of environment variables and assign them to global
		TCL variables of the same name.

-debug		If specified, Litmus will run interactively in the
		same terminal in which RunLitmus.pl was invoked, and
		it will not exit at the end of script processing. By
		default Litmus will run in batch mode and will exit
		at the end of script processing. If specified together
		with "-gui", the GUI will be brought up at the end
		of the scripted flow and command line access is provided.

-profile	Run Litmus in profiling mode, which will print subroutine
		info and runtime stamps into the logfile. This should be
		used only to debug long runtime or tool hang issues as it
		increases overall runtime.
USAGE

$ret = GetOptions(
         "help"    => \$help,
	 "gui"     => \$invoke_gui,
	 "nolib"   => \$no_libs,
	 "force"   => \$force_run,
	 "rules=s" => \$rule_level,
	 "hier"    => \$hier_flow,
	 "clean"   => \$dirclean,
	 "envload" => \$envload,
	 "litX"    => \$litmusX,
	 "debug"   => \$debug_mode,
	 "profile" => \$enable_profile,
	 "dir=s"   => \$workdir,
	 "bsub=s"  => \$bsub_args);

if ($help || ! $ret) {
  print "$usage";
  exit;
}

die "Error: LitmusX is not currently supported.\n" if ($litmusX);
die "Error: The -rules option must be one of \"min\", \"std\", \"all\".\n" unless ($rule_level =~ /^(min|std|all)$/);
my $ver_tag = ($litmusX) ? "X" : "1";

if ($workdir eq "") {
  $workdir = "$pwd/" . "litmus" . $ver_tag . "_run_" . $datestamp;
} else {
  $workdir =~ s/^\.\///;
  $workdir = "$pwd/" . $workdir if ($workdir !~ /^\//);
}

my @prevdirs = <$pwd/litmus${ver_tag}_run_*>;
if ($dirclean && (scalar(@prevdirs) > 0)) {
  foreach my $onedir (@prevdirs) {
    CoreUtils::RunSystemCommand("rm -fr $onedir");
  }
}

if (-d $workdir) {
  CoreUtils::RunSystemCommand("rm -fr $workdir");
}
foreach my $dtc (@dirs_to_create) {
  mkpath "$workdir/$dtc";
}
chdir $workdir;

my $scriptdir = rel2abs("$RealBin");

my $teelog = "${workdir}/prl_stdout_tee.log";
my $tee_fp = new FileHandle ($teelog, '>');
die "$0: $! - Cannot create $teelog\n" unless defined $tee_fp;

#########################################################
# Edit omega_user_vars.tcl to local copy		#
#########################################################

my $loc_user_vars = "${workdir}/omega_local_user_vars.tcl";
my $out_fp = new FileHandle ($loc_user_vars, '>');
die "$0: $! - Cannot create $loc_user_vars\n" unless defined $out_fp;
my $golden_user_vars = "$scriptdir/../../user/common/omega_user_vars.tcl";
my $user_vars_root_dir = dirname(abs_path($golden_user_vars));
open(INFILE,"<$golden_user_vars") or die ("Cannot open $golden_user_vars\n");
while(<INFILE>) {
  if ($_ =~ /^#\s+their\s+descriptions\./) {
    print $out_fp $_;
    print $out_fp "#\t\t\t\t\t\t\t#\n# NOTE: this file has been processed by RunLitmus.pl\t#\n#\t\t\t\t\t\t\t#\n";
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
  } elsif ($_ =~ /^\s*set\s+top_design\s+(.*)\s*$/) {
    $top_design = $1;
    $top_design =~ s/{|}//g;
    $top_design =~ s/"//g;
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
  print $out_fp "\n##########################################\n# Additional variables from RunLitmus.pl #\n##########################################\n\n";
  print $out_fp "set prl_no_libs ${no_libs}\n";
  print $out_fp "set prl_force_run ${force_run}\n";
  print $out_fp "set prl_hier_flow ${hier_flow}\n";
  print $out_fp "set prl_debug_mode ${debug_mode}\n";
  print $out_fp "set prl_invoke_gui ${invoke_gui}\n";
  print $out_fp "set prl_rule_level ${rule_level}\n";
  print $out_fp "set prl_use_litmusX ${litmusX}\n";
  print $out_fp "set prl_user_vars_root_dir ${user_vars_root_dir}\n";
  print $out_fp "set prl_script_root_dir ${scriptdir}\n";
  print $out_fp "set prl_stamped_base_dir ${workdir}\n";
  if ($rtl_search_path eq "") {
    print $out_fp "set prl_rtl_search_path {.}\n";
  } else {
    print $out_fp "set prl_rtl_search_path {${rtl_search_path}}\n";
  }
}
close(INFILE);
close($out_fp);

#########################################################
# Setup optional LSF settings and invoke Litmus		#
#########################################################

my ($bsubCmd,$litLic,$litExe,$litCmd,$runlog) = ("","","","","");
if ($bsub_args eq "") {
  CoreUtils::DualPrint($tee_fp,"Info: invoking Litmus executable directly.");
  $litExe = "litmus";
} else {
  CoreUtils::DualPrint($tee_fp,"Info: invoking Litmus through user-specified LSF commands.");
  if (exists $ENV{CDN_LITMUS_ROOT} && defined $ENV{CDN_LITMUS_ROOT}) {
    CoreUtils::DualPrint($tee_fp,"Info: using the existing \$CDN_LITMUS_ROOT environment variable to invoke Litmus.");
    $ENV{PATH} = "$ENV{CDN_LITMUS_ROOT}/bin:$ENV{PATH}";
    $litExe = "$ENV{CDN_LITMUS_ROOT}/bin/litmus";
  } else {
    CoreUtils::DualPrint($tee_fp,"Warning: the \$CDN_LITMUS_ROOT environment variable is undefined; bsub will just use \"litmus\" directly.");
    $litExe = "litmus";
  }
  $bsubCmd = "bsub -n ${threadcount},${threadcount} " . $bsub_args;
}
$litExe .= " -enable_profile" if ($enable_profile);
$litCmd = "-f ${scriptdir}/top_down_litmus.tcl";

if ($debug_mode) {
  $runlog = "${workdir}/litmus_session.log";
} elsif ($rtl_flow) {
  $runlog = "${workdir}/litmus_rtl_sdc_run.log";
} else {
  $runlog = "${workdir}/litmus_gate_sdc_run.log";
}

if ($rtl_flow == 1) {
  CoreUtils::DualPrint($tee_fp,"Info: the SDC will be linted against the RTL specified by \"golden_vf_file\".");
} else {
  CoreUtils::DualPrint($tee_fp,"Info: the SDC will be linted against the netlist specified by \"golden_netlist_file\".");
}
if ($hier_flow == 1) {
  CoreUtils::DualPrint($tee_fp,"Info: Litmus will run in hierarchical mode.");
  $litLic = "-constraint_management";
} else {
  CoreUtils::DualPrint($tee_fp,"Info: Litmus will run in top-down mode.");
  $litLic = "-signoff";
}
CoreUtils::DualPrint($tee_fp,"Info: rule check level is set to \"${rule_level}\".");
CoreUtils::DualPrint($tee_fp,"Info: debug mode has been enabled; session will run in an interactive shell instead of batch mode.") if ($debug_mode);
CoreUtils::DualPrint($tee_fp,"Info: code profiling has been enabled; logfile will contain detailed step and runtime information.") if ($enable_profile);

open(DEBUGFILE,">${workdir}/debug.cmd") or die ("Cannot create ${workdir}/debug.cmd\n");
print DEBUGFILE "Original command line:\n\n";
print DEBUGFILE "$PROGRAM_NAME $script_options\n\n";
print DEBUGFILE "Which translates to this Litmus invocation:\n\n";

if ($bsub_args eq "") {
  if ($debug_mode) {
    print DEBUGFILE "$litExe $litLic $litCmd\n";
    CoreUtils::RunSystemCommand("$litExe $litLic $litCmd");
  } else {
    print DEBUGFILE "$litExe $litLic $litCmd > $runlog 2>&1\n";
    CoreUtils::RunSystemCommand("$litExe $litLic $litCmd > $runlog 2>&1");
  }
} else {
  if ($debug_mode) {
    print DEBUGFILE "$bsubCmd \"$litExe $litLic $litCmd\"\n";
    CoreUtils::RunSystemCommand("$bsubCmd \"$litExe $litLic $litCmd\"");
  } else {
    print DEBUGFILE "$bsubCmd \"$litExe $litLic $litCmd\" > $runlog 2>&1\n";
    CoreUtils::RunSystemCommand("$bsubCmd \"$litExe $litLic $litCmd\" > $runlog 2>&1");
  }
}

close(DEBUGFILE);

chdir $pwd;

my $projdir = <${workdir}/litmus_project>;
CoreUtils::RunSystemCommand("rm -fr $projdir") if (-d $projdir);

my $error_summary_file = <${workdir}/report/*_severity_error_fail_summary.txt>;
&LitmusRunCheck($runlog,$error_summary_file);

my $initial_rule_settings = <${workdir}/modified_rules/*_initial_rule_settings.txt>;
my $final_rule_settings = <${workdir}/modified_rules/*_final_rule_settings.txt>;
my $changed_rule_settings = "${workdir}/modified_rules/${top_design}_changed_rules.txt";
my $suppressed_rule_settings = "${workdir}/modified_rules/${top_design}_suppressed_rules.txt";
&LitmusCheckRuleSettings($initial_rule_settings,$final_rule_settings,$changed_rule_settings,$suppressed_rule_settings);

#########################################################
# Subroutines unique to RunLitmus.pl			#
#########################################################

sub LitmusCheckRuleSettings {
  my ($initial,$final,$loc_diff,$loc_sup) = @_;
  my ($tmp_rule,$tmp_state,$tmp_status) = ("","","");
  my %RuleHash;

  open(INITFILE,"<$initial") or die ("Cannot open ${initial}\n");
  open(FINFILE,"<$final") or die ("Cannot open ${final}\n");
  open(DIFFILE,">$loc_diff") or die ("Cannot create ${loc_diff}\n");
  open(SUPFILE,">$loc_sup") or die ("Cannot create ${loc_sup}\n");
  while(<INITFILE>) {
    next if ($_ =~ /(======|Rule Name|\-\-\-\-\-\-)/);
    if ($_ =~ /^\s*(\S+)\s+(\S+)\s+(.*)$/) {
      $RuleHash{$1} = {initial_state => $2, final_state => "N_A", status => $3};
    }
  }
  while(<FINFILE>) {
    next if ($_ =~ /(======|Rule Name|\-\-\-\-\-\-)/);
    if ($_ =~ /^\s*(\S+)\s+(\S+)\s+(.*)$/) {
      $tmp_rule = $1;
      $tmp_state = $2;
      $tmp_status = $3;
      if (defined $RuleHash{$tmp_rule}) {
	$RuleHash{$tmp_rule}{final_state} = $tmp_state;
	$RuleHash{$tmp_rule}{status} = $tmp_status;
      } else {
	$RuleHash{$tmp_rule} = {initial_state => "N_A", final_state => $tmp_state, status => $tmp_status};
      }
    }
  }
  printf DIFFILE ("%-30s%-20s%-20s%-20s\n","Rule Name","Initial Severity","Final Severity","Status");
  print DIFFILE "-" x 90, "\n";
  printf SUPFILE ("%-30s%-20s%-20s%-20s\n","Rule Name","Initial Severity","Final Severity","Status");
  print SUPFILE "-" x 90, "\n";
  foreach my $loc_rule (sort keys %RuleHash) {
    next if ($RuleHash{$loc_rule}{initial_state} eq $RuleHash{$loc_rule}{final_state});
    if ($RuleHash{$loc_rule}{final_state} eq "N_A") {
      next if ($RuleHash{$loc_rule}{initial_state} eq "Note");
      printf SUPFILE ("%-30s%-20s%-20s%-20s\n",$loc_rule,$RuleHash{$loc_rule}{initial_state},"Suppressed",$RuleHash{$loc_rule}{status});
    } else {
      printf DIFFILE ("%-30s%-20s%-20s%-20s\n",$loc_rule,$RuleHash{$loc_rule}{initial_state},$RuleHash{$loc_rule}{final_state},$RuleHash{$loc_rule}{status});
    }
  }
  close(INITFILE);
  close(FINFILE);
  close(DIFFILE);
  close(SUPFILE);
}

sub LitmusRunCheck {
  my ($log,$summary) = @_;
  my ($log_error_count,$failed_run) = (0,0);
  if (!(-r $log)) {
    CoreUtils::DualPrint($tee_fp,"Error: Litmus run was unsuccessful. Failed to detect logfile ${log}.");
    $failed_run++;
  } else {
    CoreUtils::DualPrint($tee_fp,"Info: Summary of Litmus logfile issues:");
    open(LOGFILE,"<$log") or die ("Cannot open ${log}.\n");
    while(<LOGFILE>) {
      if ($_ =~ /^(\/\/ Error:|Error   :|invalid command name|\/\/ Warning: Error exit from dofile)/) {
	CoreUtils::DualPrint($tee_fp,$_);
	$log_error_count++;
      }
    }
    close(LOGFILE);
    if ($log_error_count > 0) {
      CoreUtils::DualPrint($tee_fp,"Error: Litmus run was unsuccessful due to above errors.");
      $failed_run++;
    } else {
      CoreUtils::DualPrint($tee_fp,"Info: Litmus run log is free of errors.");
    }
  }
  if (!(-r $summary)) {
    CoreUtils::DualPrint($tee_fp,"Error: Litmus run was unsuccessful. Failed to detect summary file ${summary}.");
    $failed_run++;
  } else {
    my $summary_error_count = 0;
    open(SUMFILE,"<$summary") or die ("Cannot open ${summary}.\n");
    while(<SUMFILE>) {
      next if ($_ =~ /^\s*(Start|Finish):/);
      $summary_error_count++;
    }
    close(SUMFILE);
    if ($summary_error_count == 0) {
      CoreUtils::DualPrint($tee_fp,"Info: Litmus completed full SDC checks without any detected errors.");
    } else {
      CoreUtils::DualPrint($tee_fp,"Error: Litmus run completed, though there are remaining errors in the SDC analysis. Review ${summary}.");
      $failed_run++;
    }
  }
  if ($failed_run > 0) {
    CoreUtils::DualPrint($tee_fp,"Litmus run status: FAIL - see above error messages.");
  } else {
    CoreUtils::DualPrint($tee_fp,"Litmus run status: PASS - logfile and reports are clean.");
  }
}
