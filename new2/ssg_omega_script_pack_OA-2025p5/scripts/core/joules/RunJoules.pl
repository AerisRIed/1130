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
use File::Find;
use FindBin qw($RealBin);
use Storable qw/freeze/;
use Cwd qw(abs_path);

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
my @dirs_to_create = qw(dbs);
my ($workdir,$joules_flow,$bsub_args,$envload) = ("",1,"",0);
my ($threadcount,$dirclean) = (1,0);
my ($structure_threshold,$depth_threshold) = (100,10);
my $rtl_search_path = "";
#my @hdl_file_list = ();
my ($rtl_flow,$add_perl_vars) = (1,1);

my $usage = <<USAGE;
$0 [options]

This script controls the interface to the Joules tool that needs to
be run to satisfy the Front-End (FE) validation flow requirements. All
Joules TCL scripts need to reside in the same location as this Perl
script.

NOTE 1: The scripts require Joules version 23.14-s077_1 to be used.

NOTE 2: For multithreading, by default the scripts take the value
	of the "tool_thread_count" variable from within
	omega_user_vars.tcl. However this value can be
	overridden by the \$CDNS_MULTITHREAD_COUNT environment
	variable.

-dir <dir>	Specify the target output directory for all generated
		Joules content. If not specified, the default
		is ./joules_run_${datestamp}_<Joules_Flow>

-joules_flow	Specify the flow to be run with joules
		supported flows are
		1 = Power analysis flow - runs RTL quick synthesis and estimates power for all the input stimulus file provided
                    Generates clock gating report and report for better clock gating opportunities                 
		2 = Power optimization flow - runs ODC/STB analysis to find power optimization opportunities in the design
		3 = Path depth and structure Analysis to display high depth path and large fanout and fanin registers

-bsub "args"	Specify the entire bsub option string containing:
		    queue, host, resource, memory requirements
		but omitting:
		    threadcount, input TCL file
		If not specified, the default behavior is to directly
		call the Joules executable; whether or not you have
		a wrapper script, this will either run on the local
		machine outside of LSF or run LSF with your custom
		wrapper script. The path to the Joules executable is
		expected to be set via the \$CDN_JLS_ROOT environment
		variable. Contents must be specified in quotes, for example:
		"-q rc -m tencad -R span[hosts=1] -Ip"
		If running in TenDPC, -bsub should not be used.

-clean		Force the deletion of any pre-existing output
		directories of the type joules_run_<date>
		from the invocation directory of this script.

-envload	Prior to reading omega_user_vars.tcl, import the entire
		set of environment variables and assign them to global
		TCL variables of the same name.
USAGE

$ret = GetOptions(
         "help" => \$help,
	 "joules_flow=s" => \$joules_flow,
	 "clean" => \$dirclean,
	 "envload" => \$envload,
	 "dir=s" => \$workdir,
	 "bsub=s" => \$bsub_args);

if ($help || ! $ret) {
  print "$usage";
  exit;
}


if ($workdir eq "") {
  $workdir = "$pwd/" . "joules_run_" . $datestamp . "_Flow_${joules_flow}";
} else {
  $workdir =~ s/^\.\///;
  $workdir = "$pwd/" . $workdir if ($workdir !~ /^\//);
}

my @prevdirs = <$pwd/joules_run_*>;
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

#########################################################
# Edit omega_user_vars.tcl to local copy		#
#########################################################
my $prl_out = "${workdir}/prl_stdout_tee.log";
my $prl_fp = new FileHandle ($prl_out, '>');
die "$0: $! - Cannot create $prl_out\n" unless defined $prl_fp;

my $golden_user_vars = File::Spec->canonpath("$scriptdir/../../user/common/omega_user_vars.tcl");
my $user_vars_root_dir = dirname(abs_path($golden_user_vars));

my $update_user_vars = "${workdir}/omega_local_user_vars.tcl";
my $out_fp = new FileHandle ($update_user_vars, '>');
die "$0: $! - Cannot create $update_user_vars\n" unless defined $out_fp;

open(INFILE,"<$golden_user_vars") or die ("Cannot open $golden_user_vars\n");
while(<INFILE>) {
  if ($_ =~ /^#\s+their\s+descriptions\./) {
    print $out_fp $_;
    print $out_fp "#\t\t\t\t\t\t\t#\n# NOTE: this file has been processed by RunJoules.pl\t#\n#\t\t\t\t\t\t\t#\n";
    if ($envload == 1) {
      for (my $index = 0; $index < 2; $index++) {
	$_ = <INFILE>;
	print $out_fp $_;
      }
      CoreUtils::ImportEnv2Tcl($out_fp);
    }
  } elsif ($_ =~ /^\s*set\s+rtl_flow\s+(\S+)\s*$/) {
    $rtl_flow = $1;
    if ($rtl_flow == 1) {
      CoreUtils::DualPrint($prl_fp,"Info: the run will start from RTL and the existing database will be overwritten \"golden_vf_file\".\n"); 
    } else {
      CoreUtils::DualPrint($prl_fp, "Info: the run will read in the DB specified by \"golden_db_file\".\n");
    }
    print $out_fp $_;
  } elsif ($_ =~ /^set\s+tool_thread_count\s+(\S+)\s*$/) {
    $threadcount = $1;
    if (exists $ENV{CDNS_MULTITHREAD_COUNT} && defined $ENV{CDNS_MULTITHREAD_COUNT}) {
      CoreUtils::DualPrint($prl_fp, "Info: environment variable \$CDNS_MULTITHREAD_COUNT is already set to $ENV{CDNS_MULTITHREAD_COUNT}; overriding \"tool_thread_count\" variable.\n");
      $threadcount = $ENV{CDNS_MULTITHREAD_COUNT};
    } else {
      CoreUtils::DualPrint($prl_fp, "Info: using \"tool_thread_count\" value of $threadcount for \$CDNS_MULTITHREAD_COUNT environment variable.\n");
      $ENV{CDNS_MULTITHREAD_COUNT} = $threadcount;
    }
    print $out_fp "set tool_thread_count $threadcount\n";
  } elsif ($_ =~ /^set\s+structure_threshold\s+(\S+)\s*$/) {
    $structure_threshold = $1;
    print $out_fp $_;
  } elsif ($_ =~ /^set\s+depth_threshold\s+(\S+)\s*$/) {
    $depth_threshold = $1;
    print $out_fp $_;
  } else {
    print $out_fp $_;
  }
}
if ($add_perl_vars) {
  print $out_fp "\n##########################################\n# Additional variables from RunJoules.pl #\n##########################################\n\n";
  print $out_fp "set prl_joules_flow ${joules_flow}\n";
  print $out_fp "set prl_script_root_dir ${scriptdir}\n";
  print $out_fp "set prl_stamped_base_dir ${workdir}\n";
  print $out_fp "set prl_user_vars_root_dir ${user_vars_root_dir}\n";
  if ($rtl_search_path eq "") {
    print $out_fp "set prl_rtl_search_path {.}\n";
  } else {
    print $out_fp "set prl_rtl_search_path {${rtl_search_path}}\n";
  }
  #print $out_fp "set prl_hdl_file_list {@hdl_file_list}\n";
}
close(INFILE);
close($out_fp);

unless (exists $ENV{CDN_JLS_ROOT} && defined $ENV{CDN_JLS_ROOT}) {
  die "Error: the \$CDN_JLS_ROOT environment variable is undefined; this must be set to a valid Joules installation area.\n";
}

#########################################################
# Setup optional LSF settings and invoke Joules		#
#########################################################

my ($bsubCmd,$joulesExe,$joulesCmd,$runlog) = ("","","","");

if ($bsub_args eq "") {
  CoreUtils::DualPrint($prl_fp, "Info: invoking Joules executable directly.\n");
  $joulesExe = "$ENV{CDN_JLS_ROOT}/tools.lnx86/studio/bin/joules_studio";
} else {
  CoreUtils::DualPrint($prl_fp, "Info: invoking Joules through user-specified LSF commands.\n");
  $ENV{PATH} = "$ENV{CDN_JLS_ROOT}/tools.lnx86/studio/bin:$ENV{PATH}";
  $joulesExe = "$ENV{CDN_JLS_ROOT}/tools.lnx86/studio/bin/joules_studio";
  $bsubCmd = "bsub -n ${threadcount},${threadcount} " . $bsub_args;
}

close($prl_fp);

$runlog = "${workdir}/joules_cmd_run.log";
$joulesCmd = "-f ${scriptdir}/joules_studio_top_down.tcl -abort_on_error";

open(DEBUGFILE,">${workdir}/debug.cmd") or die ("Cannot create ${workdir}/debug.cmd\n");
print DEBUGFILE "Original command line:\n\n";
print DEBUGFILE "$PROGRAM_NAME $script_options\n\n";
print DEBUGFILE "Which translates to this Joules invocation:\n\n";

if ($bsub_args eq "") {
  print DEBUGFILE "$joulesExe $joulesCmd | tee -ia $prl_out\n";
  CoreUtils::RunSystemCommand("$joulesExe $joulesCmd | tee -ia $prl_out");
} else {
  print DEBUGFILE "$bsubCmd \"$joulesExe $joulesCmd\" | tee -ia $prl_out\n";
  CoreUtils::RunSystemCommand("$bsubCmd \"$joulesExe $joulesCmd\" | tee -ia $prl_out");
}

close(DEBUGFILE);

$prl_fp = new FileHandle ($prl_out, '>>');

chdir $pwd;

#my $projdir = <${pwd}/joules_project>;
#CoreUtils::RunSystemCommand("rm -fr $projdir") if (-d $projdir);

my $log_file = <${workdir}/joules_studio_work/joules_studio.log>;
&JoulesRunCheck($log_file,$prl_fp);

close($prl_fp);

#########################################################
# Subroutines						#
#########################################################

sub JoulesRunCheck {
  my ($file,$prl_fp) = @_;
  my ($log_error_count,$failed_run) = (0,0);
  if (!(-r $file)) {
    CoreUtils::DualPrint($prl_fp,"Error: Joules run was unsuccessful. Failed to detect log file ${file}.\n");
    $failed_run++;
  } else {
    CoreUtils::DualPrint($prl_fp, "Info: Summary of Joules logfile issues:\n");
    open(LOGFILE,"<$file") or die ("Cannot open ${file}.\n");
    while(<LOGFILE>) {
      if ($_ =~ /^(\/\/ Error:|Error   :|invalid command name|\/\/ Warning: Error exit from dofile)/) {
	CoreUtils::DualPrint($prl_fp, $_);
	$log_error_count++;
      }
    }
    close(LOGFILE);
    if ($log_error_count > 0) {
      CoreUtils::DualPrint($prl_fp, "Error: Joules run had the above errors. Please fix and rerun\n");
      $failed_run++;
    } else {
      CoreUtils::DualPrint($prl_fp, "Info: Joules run log is free of errors.\n");
    }
  } 

  #Files check for Joules flow 1
  if (${joules_flow} == 1) {
    my $flow1_dir = "${workdir}/power_estimate";
    if (-e "$flow1_dir/Joules_gates.rpt" && -e "$flow1_dir/Joules_CTS.rpt") {
      my @sub_dirs;       
      find (sub {return unless -d; push @sub_dirs, $File::Find::name}, $flow1_dir);
      foreach my $diag_dir ( @sub_dirs ) {
        my $diag_name = basename($diag_dir);
        if ($diag_name ne "power_estimate") {
          if (-e "$diag_dir/annotation.rpt" && -e "$diag_dir/data_gate_opportunity.rpt" && -e "$diag_dir/power_engine.rpt" && -e "$diag_dir/power.rpt" && -e "$diag_dir/ungated_flops.rpt" && -e "$diag_dir/clock_gate_opportunity.rpt" && -e "$diag_dir/icg_efficiency.rpt" && -e "$diag_dir/power.hier.rpt" && -e "$diag_dir/unassertedflops.rpt") {
            CoreUtils::DualPrint($prl_fp, "Info: All report files for stimulus $diag_name have been reported\n");
          } else {
  	    CoreUtils::DualPrint($prl_fp, "Warning: There are missing report files for stimulus $diag_name\n");
            $failed_run++;
          }
	}
      }
    } else {
      $failed_run++;
    }
  }
  
  #Files check for Joules flow 2
  if (${joules_flow} == 2) {
    my $flow_error_count = 0;
    my $flow2_vector_dir = "${workdir}/odc_analysis/vector";
    my $flow2_statistical_dir = "${workdir}/odc_analysis/statistical";
    my @files_path_list = ();
    my @files_list = ();
    my @statistical_rpt_list = ("structural_logic_opt_pp.rpt", "structural_reset_opt.rpt", "structural_odc_pp.rpt", "structural_standard_stb.rpt", "structural_constant_stb.rpt", "structural_logic_opt_no-pp.rpt", "structural_odc_no-pp.rpt");

    finddepth (sub {return unless -f; return unless /\.rpt$/; push @files_path_list, $File::Find::name}, $flow2_statistical_dir);
    foreach my $file_path ( @files_path_list ) {
      my $file_name = basename($file_path);   
      push (@files_list, $file_name);
    }
    my %stat_hash = map {$_ => 1} @files_list;
    foreach my $file_rpt ( @statistical_rpt_list ) {
      unless (defined $stat_hash{$file_rpt}) {
        CoreUtils::DualPrint($prl_fp, "Warning: $file_rpt not found in output Directory for statistical analysis\n");
        $flow_error_count++;
      }
    }


    my @vector_rpt_list = ("simulation_logic_opt_pp.rpt", "simulation_odc_pp.rpt", "simulation_standard_stb.rpt", "simulation_constant_stb.rpt", "simulation_logic_opt_no-pp.rpt", "simulation_odc_no-pp.rpt");

    if (-d $flow2_vector_dir) {
      opendir my $dh, $flow2_vector_dir or die "$0: opendir: $!";
      #find (sub {return unless -d; push @vector_sub_dirs, $File::Find::name}, $flow2_vector_dir);
      my @vector_sub_dirs = grep {-d "$flow2_vector_dir/$_" && ! /^\.{1,2}$/} readdir($dh);
      foreach my $diag_name ( @vector_sub_dirs ) {
        my @files_path_list_diag = ();
        my @files_list_diag = ();
  
        finddepth (sub {return unless -f; return unless /\.rpt$/; push @files_path_list_diag, $File::Find::name}, "$flow2_vector_dir/$diag_name");
        foreach my $file_path_diag ( @files_path_list_diag ) {
  	  my $file_name_diag = basename($file_path_diag);
  	  push (@files_list_diag, $file_name_diag);
        }
  
        my %vect_hash = map {$_ => 1} @files_list_diag;
        foreach my $file_rpt ( @vector_rpt_list ) {
  	unless (defined $vect_hash{$file_rpt}) {
            CoreUtils::DualPrint($prl_fp, "Warning: $file_rpt not found in output Directory for Vector analysis of $diag_name\n");
            $flow_error_count++;
          }
        }
      }
    } else {
      CoreUtils::DualPrint($prl_fp, "Warning: No stimulus file was provided. Vector based analysis not performed\n");
    }
  
    if ($flow_error_count > 0) {
      CoreUtils::DualPrint($prl_fp, "Error: Joules did not report the above files for the provided stimulus\n");
      $failed_run++;
    } else {
      CoreUtils::DualPrint($prl_fp, "Info: All the reports for flow 2 for the provided stimulus have been generated\n");
    }

  }

  if (${joules_flow} == 3) {
    my $flow_error_count = 0;
    my $flow3_dir = "${workdir}/structural_analysis";
    my @files_path_list = ();
    my @files_list = ();
    my @flow3_rpt_list = ("struct_seq_fanout_${structure_threshold}.rpt", "struct_seq_fanin_${structure_threshold}.rpt", "reg_cone_summary.rpt", "depth_inst_${depth_threshold}.rpt", "depth_inst_Detail.rpt", "PI_to_CG.timing", "through_paths.timing", "combinational_loops.rpt");

    finddepth (sub {return unless -f; return unless /\.rpt$|\.timing$/; push @files_path_list, $File::Find::name}, $flow3_dir);
    
    foreach my $file_path ( @files_path_list ) {
      my $file_name = basename($file_path);
      push (@files_list, $file_name);
    }

    my %flow3_hash = map {$_ => 1} @files_list;
    foreach my $file_rpt ( @flow3_rpt_list ) {
      unless (defined $flow3_hash{$file_rpt}) {
        CoreUtils::DualPrint($prl_fp, "Warning: $file_rpt not found in output Directory for Flow 3\n");
        $flow_error_count++;
      } else {
	if ($file_rpt eq "combinational_loops.rpt") {
	  my $combo_status = system("grep 'No combo loops to report' $flow3_dir/combo_loops/combinational_loops.rpt");
	  if ($combo_status != 0) {
	    CoreUtils::DualPrint($prl_fp, "Error: Combinational loops found in design\n");
            $failed_run++;
	  }
	}
      }
    }
    if ($flow_error_count > 0) {
      CoreUtils::DualPrint($prl_fp, "Error: Joules did not report the above files for the design\n");
      $failed_run++;
    } else {
      CoreUtils::DualPrint($prl_fp, "Info: All the reports for Flow 3 have been generated\n");
    }

  }

  if ($failed_run > 0) {
    CoreUtils::DualPrint($prl_fp, "Joules run status: FAIL - see above error messages.\n");
  } else {
    CoreUtils::DualPrint($prl_fp, "Joules run status: PASS - logfile and reports are clean.\n");
  }

}
