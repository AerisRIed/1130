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
use File::Path;
use File::Copy;
use File::Basename;
use File::Spec::Functions qw(:ALL);
use FindBin qw($RealBin);
use Cwd qw(abs_path);

use lib "$RealBin/../common/";
use CoreUtils;

#########################################################
# Setup and documentation                               #
#########################################################
my $script_options = "@ARGV";
my $help = 0;
my $ret;
my $pwd = cwd();
my $datestamp = `date +%m%d%Y_%H%M%S`;
chomp($datestamp);
my ($workdir,$compare,$design,$user_dir,$invoke_gui,$bsub_args) = ("",0,"","user",0,"");
my ($threadcount,$dirclean) = (1,"",0);
my ($rtl_flow,$add_perl_vars,$envload) = (1,1,0);

my $usage = <<USAGE;
$0 [options]

This script controls the interface to the Conformal-LP tool that needs to
be run to satisfy the Front-End (FE) validation flow requirements. All
Conformal-LP TCL scripts need to reside in the same location as this Perl
script.

NOTE 1: The scripts require Conformal version 25.10-p100 or later to be used.

NOTE 2: For multithreading, by default the scripts take the value
   of the "tool_thread_count" variable from within
   omega_user_vars.tcl. However this value can be
   overridden by the \$CDNS_MULTITHREAD_COUNT environment
   variable.

-dir <dir>     Specify the target output directory for all generated
               Conformal-LP content. If not specified, the default
               is ./clp_lint_run_${datestamp} when running Lint and
               ./clp_comp_run_${datestamp} when running UPF LEQ (-compare)

-compare       Run Conformal-LP in compare mode. This will compare 2 different 
               UPFs and 2 different RTL/netlists to check if both are equivalent.
               Ex.: RTL and golden UPF vs post synthesis netlist and UPF.

-design        Specify design name. This can be used when you want to 
               run multiple runs in parallel with same scripts, just
               changing "top_design" from omega_user_vars.tcl. By default
               the tool will use the one defined in omega_user_vars.tcl.

-user_dir      Specify user scripts directory. This can be used when you
               want to run multiple runs in parallel just changing the user scripts.
               By default the tool will use "user".

-gui           Launch Conformal GUI at the end of the run script instead
               of directly exiting. As the tool is still in batch
               mode, no command line access is provided. To properly
               exit the flow, select "exit" from the GUI menu and
               confirm your choice; otherwise this Perl script will
               not complete. If not specified, Conformal will directly
               exit out of batch mode at the end of the flow.

-bsub "args"   Specify the entire bsub option string containing:
               queue, host, resource, memory requirements
               but omitting:
               threadcount, input TCL file
               If not specified, the default behavior is to directly
               call the Conformal executable; whether or not you have
               a wrapper script, this will either run on the local
               machine outside of LSF or run LSF with your custom
               wrapper script. The path to the Conformal executable is
               expected to be set via the \$VERPLEX_HOME environment
               variable. Contents must be specified in quotes, for example:
               "-q rc -m tencad -R span[hosts=1] -Ip"
               If running in TenDPC, -bsub should not be used.

-clean         Force the deletion of any pre-existing output
               directories of the type clp_lint_run_<date> or clp_comp_run_<date>
               from the invocation directory of this script.

-envload	Prior to reading omega_user_vars.tcl, import the entire set of
		environment variables and assign them to global TCL variables of
		the same name.

USAGE

$ret = GetOptions(
    "help" => \$help,
    "compare" => \$compare,
    "design=s" => \$design,
    "user_dir=s" => \$user_dir,
    "gui" => \$invoke_gui,
    "clean" => \$dirclean,
    "dir=s" => \$workdir,
    "envload" => \$envload,
    "bsub=s" => \$bsub_args);

if ($help || ! $ret) {
  print "$usage";
  exit;
}

if ($workdir eq "") {
  if ($compare) {
    $workdir = "$pwd/" . "clp_comp_run_" . $datestamp;
  } else {
    $workdir = "$pwd/" . "clp_lint_run_" . $datestamp;
  }
} else {
  $workdir =~ s/^\.\///;
  $workdir = "$pwd/" . $workdir if ($workdir !~ /^\//);
}

my @prevdirs = ();
if ($compare) {
  @prevdirs = <$pwd/clp_comp_run_*>;
} else {
  @prevdirs = <$pwd/clp_lint_run_*>;
}

if ($dirclean && (scalar(@prevdirs) > 0)) {
  foreach my $onedir (@prevdirs) {
    CoreUtils::RunSystemCommand("rm -fr $onedir");
  }
}

if (-d $workdir) {
  CoreUtils::RunSystemCommand("rm -fr $workdir");
}
mkpath "$workdir/report";
chdir $workdir;

my $scriptdir = rel2abs("$RealBin");

#########################################################
# Edit omega_user_vars.tcl to local copy                #
#########################################################
my $teelog = "${workdir}/prl_stdout_tee.log";
my $tee_fp = new FileHandle ($teelog, '>');
die "$0: $! - Cannot create $teelog\n" unless defined $tee_fp;

my $loc_user_vars = "${workdir}/omega_local_user_vars.tcl";
my $out_fp = new FileHandle ($loc_user_vars, '>');
die "$0: $! - Cannot create $loc_user_vars\n" unless defined $out_fp;
my $golden_user_vars = File::Spec->canonpath("$scriptdir/../../user/common/omega_user_vars.tcl");
my $user_vars_root_dir = dirname(abs_path($golden_user_vars));
open(INFILE,"<$golden_user_vars") or die ("Cannot open $golden_user_vars\n");
while(<INFILE>) {
  if ($_ =~ /^#\s+their\s+descriptions\./) {
    print $out_fp $_;
    print $out_fp "#\t\t\t\t\t\t\t#\n# NOTE: this file has been processed by RunCLP.pl\t#\n#\t\t\t\t\t\t\t#\n";
    if ($envload == 1) {
      for (my $index = 0; $index < 2; $index++) {
        $_ = <INFILE>;
        print $out_fp $_;
      }
      CoreUtils::ImportEnv2Tcl($out_fp);
    }
  } elsif ($_ =~ /^set\s+rtl_flow\s+(\S+)/) {
    $rtl_flow = $1;
    if ($rtl_flow == 1 && $compare == 0) {
      print "Info: the UPF analysis will use the RTL specified by \"golden_vf_file\".\n";
    } else {
      if ($compare == 0) {
        print "Info: the UPF analysis will use the netlist specified by \"golden_netlist_file\".\n";
      } else {
          print "Info: CLP will run in compare mode.\n";
      }
    }
    print $out_fp $_;
  } elsif ($_ =~ /^set\s+tool_thread_count\s+(\S+)\s*$/) {
    $threadcount = $1;
    if (exists $ENV{CDNS_MULTITHREAD_COUNT} && defined $ENV{CDNS_MULTITHREAD_COUNT}) {
      CoreUtils::DualPrint($tee_fp,"Info: environment variable \$CDNS_MULTITHREAD_COUNT is already set to $ENV{CDNS_MULTITHREAD_COUNT}; overriding \"tool_thread_count\" variable.");
      $threadcount = $ENV{CDNS_MULTITHREAD_COUNT};
    } else {
      CoreUtils::DualPrint($tee_fp,"Info: using \"tool_thread_count\" value of $threadcount for \$CDNS_MULTITHREAD_COUNT environment variable.");
      $ENV{CDNS_MULTITHREAD_COUNT} = $threadcount;
    }
    print $out_fp "set tool_thread_count $threadcount\n";
  } elsif ($_ =~ /^set\s+top_design\s+(\S+)\s*$/) {
    if ($design ne "") {
      print $out_fp "set top_design ${design}";
    } else {
      print $out_fp $_;
    }
  } else {
    print $out_fp $_;
  }
}

if ($add_perl_vars) {
  print $out_fp "\n##########################################\n# Additional variables from RunCLP.pl #\n##########################################\n\n";
  print $out_fp "set prl_script_root_dir ${scriptdir}\n";
  print $out_fp "set prl_stamped_base_dir ${workdir}\n";
  print $out_fp "set prl_compare ${compare}\n";
  print $out_fp "set prl_user_dir ${user_dir}\n";
  print $out_fp "set prl_gui ${invoke_gui}\n";
  print $out_fp "set prl_user_vars_root_dir ${user_vars_root_dir}\n";
}

close(INFILE);
close($out_fp);

my $clpExe = which_exe("lec");
if ($clpExe ne "0") {
  CoreUtils::DualPrint($tee_fp, "\nCLP will run using $clpExe\nIf that is not the desired version, please change your PATH environment variable and run again.\n");
} else {
  die "\nError: Please add LEC binary root path to the PATH environment variable before continue. Recommended version: 25.10 or later.\n";
}

#########################################################
# Setup optional LSF settings and invoke CLP            #
#########################################################
my ($bsubCmd,$clpCmd) = ("","");

if ($bsub_args eq "") {
  CoreUtils::DualPrint($tee_fp, "Info: invoking CLP executable directly.\n");
} else {
  CoreUtils::DualPrint($tee_fp, "Info: invoking CLP through user-specified LSF commands.\n");
  $bsubCmd = "bsub -n ${threadcount},${threadcount} " . $bsub_args;
}
$clpCmd = "-lp -do ${scriptdir}/top_down_clp.tcl";

if (!$compare) {
  $clpCmd = $clpCmd." -verify";
}

if ($invoke_gui) {
  $clpCmd = $clpCmd." -gui";
} else {
  $clpCmd = $clpCmd." -nogui";
}

open(DEBUGFILE,">${workdir}/debug.cmd") or die ("Cannot create ${workdir}/debug.cmd\n");
print DEBUGFILE "Original command line:\n\n";
print DEBUGFILE "$PROGRAM_NAME $script_options\n\n";
print DEBUGFILE "Which translates to this CLP invocation:\n\n";


close($tee_fp);
if ($bsub_args eq "") {
  print DEBUGFILE "$clpExe $clpCmd | tee -ia $teelog\n";
  CoreUtils::RunSystemCommand("$clpExe $clpCmd | tee -ia $teelog");
} else {
  print DEBUGFILE "$bsubCmd \"$clpExe $clpCmd\" | tee -ia $teelog\n";
  CoreUtils::RunSystemCommand("$bsubCmd \"$clpExe $clpCmd\" | tee -ia $teelog");
}
$tee_fp = new FileHandle ($teelog, '>>');
die "$0: $! - Cannot create $teelog\n" unless defined $tee_fp;

close(DEBUGFILE);

chdir $pwd;

my $projdir = <${pwd}/clp_project>;
CoreUtils::RunSystemCommand("rm -fr $projdir") if (-d $projdir);

my $log_file = abs_path(<${workdir}/clp_session.log>);
my $log_errors = &log_errors($log_file);
&CLPRunCheck($tee_fp,$log_errors,$compare,$workdir);
close($tee_fp);

#########################################################
# Subroutines                                           #
#########################################################
sub log_errors {
  my ($tool_log) = @_;
  ( $tool_log ) = glob($tool_log);
  my $log_errors = 0;
  if (! defined $tool_log || ! -f $tool_log) {
    CoreUtils::DualPrint($tee_fp,"\nError: CLP run was unsuccessful. Failed to detect log file ${tool_log}.");
    return 0;
  } else {
    open(LOGFILE,"<$tool_log") or die ("Cannot open ${tool_log}.\n");
    CoreUtils::DualPrint($tee_fp,"\nChecking CLP log: ".abs_path(${tool_log}).".");
    while(<LOGFILE>) {
      if ($_ =~ /(^\/\/ Error:|\[ERROR|^ERROR|^Error|invalid command name|\/\/ Warning: Error exit from dofile)/) {
        chomp($_);
        CoreUtils::DualPrint($tee_fp,"$_");
        $log_errors++;
      }
    }
    close(LOGFILE);
    if ($log_errors > 0) {
      CoreUtils::DualPrint($tee_fp,"\nError: Found errors in CLP log. Please verify it.");
      return $log_errors;
    } else {
      CoreUtils::DualPrint($tee_fp,"\nNo errors were found in CLP log.");
      return 0;
    }
  }
}

sub CLPRunCheck {
  my ($tee_fp, $log_errors,$compare,$workdir) = @_;
  my $pass = 1;
  my $error_summary_file;
  if ($compare) {
    $error_summary_file = <${workdir}/report/*.compare_power_intent.rpt>;
    if (! defined $error_summary_file || ! -f $error_summary_file) {
      CoreUtils::DualPrint($tee_fp,"\nError: CLP Compare mode was unsuccessful. Failed to detect ${workdir}/report/*.compare_power_intent.rpt.");
      $pass = 0;
    } else {
      CoreUtils::DualPrint($tee_fp,"\nAnalyzing ".abs_path(${error_summary_file}).".");
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
        CoreUtils::DualPrint($tee_fp,"\nCLP Compare mode showed equivalent UPFs.");
      } elsif ($line =~ /Power Intent Compare: Non-Equivalent/) {
        CoreUtils::DualPrint($tee_fp,"\nError: CLP Compare mode showed non equivalent points. Please review $error_summary_file.");
        $pass = 0;
      } else {
        CoreUtils::DualPrint($tee_fp,"\nError: CLP Compare report missing compare result. Please review $error_summary_file.");
        $pass = 0;
      }
    }
  } else {
    $error_summary_file = <${workdir}/report/*.rule_check.error.rpt>;
    my $rule_filters_file = <${workdir}/report/*.rule_filters.rpt>;
    if (! defined $error_summary_file || ! -f $error_summary_file || ! defined $rule_filters_file || ! -f $rule_filters_file) {
      CoreUtils::DualPrint($tee_fp,"\nError: CLP Lint run was unsucessful. Failed to detect ${workdir}/report/*.rule_check.error.rpt violation summary file.");
      $pass = 0;
    } else {
      CoreUtils::DualPrint($tee_fp,"\nAnalyzing report: ".abs_path(${error_summary_file}).".");
      CoreUtils::DualPrint($tee_fp,"Analyzing report: ".abs_path(${rule_filters_file}).".");
      my $size_summary = -s $error_summary_file;
      my $size_filters = -s $rule_filters_file;
      if ($size_summary != 0) {
        CoreUtils::DualPrint($tee_fp,"\nCLP Lint was completed with errors. Please review ${error_summary_file}");
        $pass = 0;
      } else {
        if ($size_filters != 0) {
          CoreUtils::DualPrint($tee_fp,"\nCLP Lint was completed without errors, but using rule filters. Please review ${rule_filters_file}");
        } else {
          CoreUtils::DualPrint($tee_fp,"\nCLP Lint was successful. Completed without errors and waivers.");
        }
      }
    }
  }
  if ($log_errors > 0 || $pass == 0) {
    CoreUtils::DualPrint($tee_fp, "CLP run status: FAIL - see above error messages.\n");
  } else {
    CoreUtils::DualPrint($tee_fp, "CLP run status: PASS - logfile and reports are clean.\n");
  }
}

sub which_exe {
  my $exe_name = $_;
  my @envpaths = split(/:/,$ENV{PATH});
  foreach my $path (@envpaths) {
    if (-e "$path/lec") {
      return "$path/lec"; 
    }
  }
  return "0";
}
