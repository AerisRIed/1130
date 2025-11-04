#!/usr/bin/env perl

#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

use strict;
use File::Spec::Functions qw(:ALL);
use FileHandle;
use Getopt::Long;
use Cwd;
use File::Path;
use File::Copy;
use File::Basename;
use FindBin qw($RealBin);
use lib $RealBin;

my $core = "";
if (defined $ENV{'DESIGN'}) {
   $core = "$ENV{'DESIGN'}";
} else {
  print "Error: DESIGN is not set in env_design.sh. Specify the top module name.\n";
  exit(1);
}
my $help = 0;
my $ret;
my $pwd = cwd();
my $force_liberty = 0;
my $compare = "r2g";
my $golden = "not_user_specified";
my $revised = "$RealBin/../../syn_genus/${core}_syn.v";
my $mem_revised = "$RealBin/../../syn_genus/${core}_syn.v";
my $user_controlled_revised = "";
my $initial_retiming_state = 0;
my $retiming_has_groups = 0;
my $retiming = 0;
my $scan = 1;
my $csf = "$RealBin/../../CadSetup.file";
my $design = "";
my $user_controlled_design = "";
my $TargetDir = "";
my $time_limit = 72;

my $usage = <<USAGE;
$0 [options]

This script provides the formal verification interface. Using the
Cadence Conformal-Ultra tool, RTL-to-RTL, RTL-to-gate, or gate-to-gate
verification can be performed. Default behavior is to perform RTL (golden)
to gate (revised) verification using the Cadence Conformal-Ultra tool on
the post-Genus netlist.

NOTE:	Simulation libraries are prefered to synthesis libraries, so the default
	behavior is to search CadSetup.file first for the
	Lib_VerilogSimulationLibrary variable, and if there are no readable
	files, then the Lib_CadenceLIB files are used instead. To force
	checking for synthesis libraries first, use the "-use_synlib" switch.

NOTE:   If performing an r2r or r2g comparison and there are direct 
	DesignWare instantiations in the RTL, make sure that the DesignWare
	simulation libraries for the given module are included in the
	Lib_VerilogSimulationLibrary variable.

-compare <r2r|r2g|g2g>	Selects what kind of verification is being performed.
			Either RTL-to-RTL (r2r), RTL-to-gate (r2g), or
			gate-to-gate (g2g). If "r2g" is used, it is required
			that RTL be used for the golden option, and the netlist
			as the revised option. If not specified, default
			is "r2g".

-golden <file>		Path to golden RTL or netlist. This serves as the
			reference design which is considered to be functionally
			correct. If this is RTL, the argument is expected to be
			a single file containing the absolute paths of all
			target RTL files. Otherwise the argument should be the
			path to the gate-level netlist.
			Defaults to <FILE_LIST> variable defined in env_design.sh file

-revised <file>		Path to revised RTL or netlist. This is the post-
			modification RTL or synthesized netlist to be compared
			against the golden reference design. If this is RTL, the
			argument is expected to be a single file containing the
			absolute paths of all target RTL files. Otherwise the
			argument should be the path to the gate-level netlist.
			If there are multiple gate-level netlists, such as those
			generated at checkpoint steps from a synthesis tool
			performing retiming, select the final netlist, which will
			always be called ${core}_*.v.
			Default depends on the implementation level selected in
			the CadSetup.file:
			If Syn_UseMemoryMacros is 1, default is:
			$mem_revised
			Otherwise, default is:
			$revised

-csf <file>		Location of CadSetup.file that contains either the
			Verilog simulation libraries (preferred), or the Liberty
			format synthesis libraries. Defaults to $csf

-use_synlib		Forces using Liberty format synthesis libraries from the
			CadSetup.file first; if none are available, verilog
			simulation libraries are used. By default, simulation
			libraries are checked first, then synthesis libraries.

-[no]scan		Specify if the design is scan enabled. Defaults to
			build-time configuration, which assumes scan was
			enabled for this design. However, if Syn_InsertScan is
			set to zero in the specified CadSetup.file, it is
			assumed that scan insertion was not performed.

-[no]retiming		Specify if the revised netlist has undergone retiming.
			Initial setting is determined by whether or not modules
			requiring retiming were present in the RTL for this
			build, which is false for this build. However,
			if both Genus_Allow*Retiming variables are set to zero in the
			specified CadSetup.file, it is assumed that retiming was
			not performed. The retiming flag is only necessary if
			the sequential elements of the golden and revised design
			are no longer in the same location with respect to each
			other. Thus, if performing a gate-to-gate or RTL-to-RTL
			comparison, retiming will be set to false unless
			overridden by this switch.

-design <name>		Specify top design name of golden and revised inputs.
			Default is: $design

-output <dir>		Specifies target output directory where results are
			stored. Defaults to <toolname>_<compare_point>_results
			in the present directory, i.e., ./conformal_r2g_results.
			This option is ignored for the special case of
			performing an RTL-to-gate comparison using Conformal-
			Ultra, in which Genus was used to create the netlist.
			Since Genus creates its own Conformal-Ultra scripts, the
			comparison is performed in the xda/syn_genus directory.
			Check there for all output results.

-time_limit <integer>	Specifies the time limit, in hours, that the formal
			compare tool is allowed to spend during the compare
			process. When the tool reaches the specified limit, it
			stops all processing and exits. This value must be an
			integer. Defaults to $time_limit hours. This option is
			ignored for the special case of performing an
			RTL-to-gate comparison using Conformal-Ultra, in which
			Genus was used to create the netlist; these runs are
			always given $time_limit hours to complete.
USAGE

my $CommandString = "$0 ";
foreach my $entry (@ARGV) {
  $CommandString .= "$entry ";
}
chop($CommandString);

$ret = GetOptions(
	"help" => \$help,
	"compare=s" => \$compare,
	"golden=s" => \$golden,
	"revised=s" => \$user_controlled_revised,
	"csf=s" => \$csf,
	"use_synlib" => \$force_liberty,
	"scan!" => \$scan,
	"retiming!" => \$retiming,
	"design=s" => \$user_controlled_design,
	"output=s" => \$TargetDir,
	"time_limit=i" => \$time_limit);

if ($help || ! $ret) {
  print "$usage";
  exit;
}

#################################################################################
# Perform error checking on inputs, set defaults				#
#################################################################################

unless (($compare eq "r2r") || ($compare eq "r2g") || ($compare eq "g2g")) {
  print "Error: The only valid options to the -compare argument are \"r2r\", \"r2g\", or \"g2g\".\n";
  exit;
}

$retiming = (($retiming == 1) || (($initial_retiming_state == 1) && ($compare eq "r2g"))) ? 1:0;

my $RTL_PATH="";

if (defined $ENV{'RTL_PATH'}) {
  $RTL_PATH = "$ENV{'RTL_PATH'}";
} 


if ($golden eq "not_user_specified") {
  if (defined $ENV{'FILE_LIST'}) {
    $golden = "$ENV{'FILE_LIST'}";
  } else {
    print "Error: Provide the path to golden netlist by either setting FILE_LIST variable in env_design.sh or -golden option to this script\n";
    exit(1);
  }
}
$golden =~ s/^\.\///;
$golden =~ s/^\..\///;
$golden = "$pwd/$golden" unless ($golden =~ /^\//);
die "The file $golden is not readable\n" unless (-r $golden);
unless ($user_controlled_revised eq "") {
  $revised = $user_controlled_revised;
  $revised =~ s/^\.\///;
  $revised = "$pwd/$revised" unless ($revised =~ /^\//);
}
$csf =~ s/^\.\///;
$csf = "$pwd/$csf" unless ($csf =~ /^\//);
die "The file $csf is not readable\n" unless (-r $csf);

my $genus_to_conformal_flow = 0;
my $test_dir = dirname($revised);
my $special_case = (($compare eq "r2g") && ((-e "$test_dir/int_to_final.do") || (-e "$test_dir/retimed_to_final.do"))) ? 1:0;
my $using_any_genus_flow = (($compare eq "r2g") && (-e "$test_dir/Genus_generic_define.tcl")) ? 1:0;
if ($TargetDir eq "") {
  $TargetDir = "$pwd/" . "conformal_" . $compare . "_results";
} else {
  if ($special_case) {
    print "Error: The -output directory option is invalid for the special case of using Conformal-Ultra to perform an\n";
    print "Error: RTL-to-gate comparison of a post-Genus netlist. Instead, all results will be generated\n";
    print "Error: in the local eda/syn_genus synthesis directory.\n";
    exit;
  }
  $TargetDir =~ s/^\.\///;
  $TargetDir = "$pwd/$TargetDir" unless ($TargetDir =~ /^\//);
}

if (-d $TargetDir) {
  system("rm -fr $TargetDir");
}
mkpath $TargetDir;
chdir $TargetDir;

my (@simulation_array, @liberty_array, $temp_line, @LibArray, $lib_list);
my $csf_insert_scan = 1;
my $superthread_count = 1;
my $using_liberty_files = 0;
my $use_direct_primitives = 0;
my $use_memory_macros = 0;
my $use_low_power_flow = 0;
my $genus_user_retiming = 1;
my $genus_coproc_retiming = 0;
open(CADFILE,"<$csf") or die ("Cannot open $csf");
while(<CADFILE>) {
  if ($_ =~ /^\s*Target_LowPowerFlow\s+(\S+)/) {
    $use_low_power_flow = $1;
  }  elsif ($_ =~ /^\s*Syn_UseDirectPrimitives\s+(\S+)/) {
    $use_direct_primitives = $1;
  } elsif ($_ =~ /^\s*Syn_InsertScan\s+(\S+)/) {
    $csf_insert_scan = $1;
  } elsif ($_ =~ /^\s*Syn_SuperthreadCount\s+(\S+)/) {
    $superthread_count = $1;
  } elsif ($_ =~ /^\s*Syn_UseMemoryMacros\s+(\S+)/) {
    $use_memory_macros = $1;
  } elsif ($_ =~ /^\s*Genus_AllowUserRetiming\s+(\S+)/) {
    $genus_user_retiming = $1;
  } elsif ($_ =~ /^\s*Genus_AllowCoprocRetiming\s+(\S+)/) {
    $genus_coproc_retiming = $1;
  } elsif ($_ =~ /^Lib_VerilogSimulationLibrary\s+(.*)$/) {
    $temp_line = $1;
    $temp_line =~ s/{|}//g;
    $temp_line =~ s/,/ /g;
    @simulation_array = split(/\s+/,$temp_line);
  } elsif ($_ =~ /^Lib_CadenceLIB\s+(.*)$/) {
    $temp_line = $1;
    $temp_line =~ s/{|}//g;
    $temp_line =~ s/,/ /g;
    @liberty_array = split(/\s+/,$temp_line);
  }
}
close(CADFILE);

my @RetimedArray = ();
my @UserRetimedArray = ();
my @CoprocRetimedArray = ();
if (($using_any_genus_flow == 1) && ($genus_user_retiming == 1)) {
  push(@RetimedArray, @UserRetimedArray);
}
if (($using_any_genus_flow == 1) && ($genus_coproc_retiming == 1)) {
  push(@RetimedArray, @CoprocRetimedArray);
}

my $genus_allow_retiming = 0;
if ((($genus_user_retiming == 1) && (scalar(@UserRetimedArray) != 0)) || (($genus_coproc_retiming == 1) && (scalar(@CoprocRetimedArray) != 0))) {
  $genus_allow_retiming = 1;
}

if ($user_controlled_design ne "") {
  $design = $user_controlled_design;
} elsif (defined $ENV{'DESIGN'}) {
  $design = "$ENV{'DESIGN'}";
} else {
  print "Error: Provide the design name by either setting DESIGN variable set in env_design.sh or -design option to this script\n";
  exit (1);
}
my $FileHeader = $core;
if ($user_controlled_revised eq "") {
  if ($use_memory_macros == 1) {
    $revised = $mem_revised;
  }
}
die "The file $revised is not readable\n" unless (-r $revised);

if ($retiming && (($using_any_genus_flow == 1) && ($genus_allow_retiming == 0))) {
  print "\n\nWarning: If there are modules that may require retiming, yet either both of the\n";
  print "Warning: Genus_Allow*Retiming variables were set to zero in the CadSetup.file. Or, one of the user/coprocessor\n";
  print "Warning: allow retiming variables was set to one, but there is actually no user/coprocessor to retime in this config. Either way,\n";
  print "Warning: this means that a deliberate decision was made to prevent synthesis from performing retiming, so formal verification will\n";
  print "Warning: proceed as if retiming were not performed. If you want formal verification to treat the revised design as if it has been\n";
  print "Warning: retimed, and that there is user/coprocessor to be retimed, please set the correct variable\n";
  print "Warning: within the pair of Genus_Allow*Retiming variables to one in the CadSetup.file and run this flow again.\n\n";
  $retiming = 0;
}

if ($force_liberty) {
  foreach my $element (@liberty_array) {
    if (-e $element) {
      push @LibArray, $element;
      $using_liberty_files = 1;
    } else {
      print "Error: Lib_CadenceLIB value $element does not exist.\n";
      exit;
    }
  }
  if (scalar(@LibArray) == 0) {
    print "\n\nWarning: No Liberty synthesis libraries were found in ${csf}. Will attempt to use verilog simulation libraries instead.\n\n";
    foreach my $element (@simulation_array) {
      if (-r $element) {
	push @LibArray, $element;
      } else {
	print "Error: Lib_VerilogSimulationLibrary value $element is unreadable.\n";
	exit;
      }
    }
  }
} else {
  foreach my $element (@simulation_array) {
    if (-r $element) {
      push @LibArray, $element;
    } else {
      print "Error: Lib_VerilogSimulationLibrary value $element is unreadable.\n";
      exit;
    }
  }
  if (scalar(@LibArray) == 0) {
    print "\n\nWarning: No verilog simulation libraries were found in ${csf}. Will attempt to use Liberty synthesis libraries instead.\n\n";
    foreach my $element (@liberty_array) {
      if (-e $element) {
        push @LibArray, $element;
        $using_liberty_files = 1;
      } else {
        print "Error: Lib_CadenceLIB value $element does not exist.\n";
        exit;
      }
    }
  }
}

if (scalar(@LibArray) == 0) {
  print "Error: Neither Lib_VerilogSimulationLibrary nor Lib_CadenceLIB variables in $csf have readable files.\n";
  exit;
}
foreach my $element (@LibArray) {
  $lib_list = $element . " " . $lib_list;
}
chop($lib_list);

if (($compare eq "r2r") || ($compare eq "r2g")) {
  open(GOLDENFM,">golden_fm.vf") or die ("Cannot create golden_fm.vf");
  open(GOLDENFILES,"<$golden") or die ("Cannot open $golden");
  while(<GOLDENFILES>) {
    chomp($_);
    next if (($_ =~ /^\s*$/) || ($_ =~ /^#/) || ($_ =~ /^\/\//));
    $_ =~ s/^-v\s+//;
    print GOLDENFM "$_\n";
    next if ($_ =~ /\+incdir\+/);
  }
  close(GOLDENFILES);
  close(GOLDENFM);
  system("rm -f golden_fm.vf");
}
if ($compare eq "r2r") {
  open(REVFM,">revised_fm.vf") or die ("Cannot create revised_fm.vf");
  open(REVFILES,"<$revised") or die ("Cannot open $revised");
  while(<REVFILES>) {
    chomp($_);
    next if (($_ =~ /^\s*$/) || ($_ =~ /^#/) || ($_ =~ /^\/\//));
    $_ =~ s/^-v\s+//;
    print REVFM "$_\n";
    next if ($_ =~ /\+incdir\+/);
  }
  close(REVFILES);
  close(REVFM);
  system("rm -f revised_fm.vf");
}

my $renaming_rule_design = $design;
my $conformal_define_string = "";
if ($use_memory_macros == 1) {
  $conformal_define_string .= "-define ${renaming_rule_design}_MEMORY_SYNTHESIS ";
}
if ($use_direct_primitives) {
  $conformal_define_string .= "-define DIRECT_PRIMITIVES -define DW_DIRECT_PRIMITIVES ";
}
chop($conformal_define_string) unless ($conformal_define_string eq "");

my $golden_dir = dirname($golden);
my $revised_dir = dirname ($revised);
my ($macro_list_golden,$macro_list_revised);
if ($use_memory_macros == 1) {
  $macro_list_golden = "$golden_dir/${core}_syn.memory_macro_list";
  $macro_list_revised = "$revised_dir/${core}_syn.memory_macro_list";
}
my $memory_macro_list = "";
my (@macro_fp_array,@MacroArray,%MacroHash);
if (-r $macro_list_golden) {
  push @macro_fp_array, $macro_list_golden;
} elsif (-r $macro_list_revised) {
  push @macro_fp_array, $macro_list_revised;
}
foreach my $fp_entry (@macro_fp_array) {
  open(MACROLIST,"<$fp_entry") or die ("Cannot open $fp_entry\n");
  while(<MACROLIST>) {
    if ($_ =~ /set\s+UNIQUE_MACRO_CELLS\s+\{(.*)\}/) {
      @MacroArray = split(/\s+/,$1);
      foreach my $entry (@MacroArray) {
	$MacroHash{$entry} = 1 unless (defined $MacroHash{$entry});
      }
    }
  }
  close(MACROLIST);
}
foreach my $ram (keys %MacroHash) {
  $memory_macro_list .= "$ram ";
}
chop($memory_macro_list);

if (($retiming == 1) && (($compare eq "r2r") || ($compare eq "g2g"))) {
  print "\n\nWarning: You have specified the -retiming option for an RTL-to-RTL or gates-to-gates comparison,\n";
  print "Warning: which is unusual. Verification will proceed assuming the revised design underwent retiming.\n";
  print "Warning: Make sure this is the intended behavior.\n\n";
}
if (($retiming == 1) && ($compare eq "r2g") && (($revised =~ /intermediate/) || ($revised =~ /retiming/))) {
  print "Error: When performing an RTL-to-gates formal comparison on a retimed design, the revised netlist\n";
  print "Error: specified with the -revised option should always be the final netlist generated by the synthesis\n";
  print "Error: tool, with a name ending in *_syn.v, not one of the intermediate netlists.\n";
  exit;
}

#################################################################################
# Create Cadence Conformal-Ultra scripts, launch job, analyze results		#
#################################################################################

if ($compare eq "r2r") {
  open(DOFILE,">conformal_r2r.do") or die ("Cannot create conformal_r2r.do");
  print DOFILE "set dofile abort off\n";
  print DOFILE "set log file conformal_r2r.log -replace\n";
  print DOFILE "set undefined cell black_box -noascend -both\n";
  print DOFILE "set undriven signal Z -both\n";
  print DOFILE "set mapping method -noreport_unreach -report_summary_show_zero_count\n\n";
  print DOFILE "add notranslate modules -library -both $memory_macro_list\n\n" unless ($memory_macro_list eq "");
  if ($using_liberty_files) {
    print DOFILE "read library -statetable -liberty -both $lib_list\n";
  } else {
    print DOFILE "read library -verilog -both $lib_list\n";
  }
  print DOFILE "read design -verilog2k -golden -lastmod $conformal_define_string -root $design -file $golden\n";
  print DOFILE "set root module $design -golden\n";
  print DOFILE "read design -verilog2k -revised -lastmod $conformal_define_string -file $revised\n";
  print DOFILE "report design data\n";
  print DOFILE "report module\n";
  print DOFILE "report black box -detail\n";
  print DOFILE "set modeling effort high\n";
  print DOFILE "set compare effort auto\n";
  print DOFILE "set cpu limit $time_limit -hours -walltime\n";
  print DOFILE "set flatten model -nodff_to_dlat_zero -nodff_to_dlat_feedback -gated_clock\n";
  print DOFILE "set flatten model -seq_constant -seq_constant_x_to 0\n";
  print DOFILE "set parallel option -threads $superthread_count -license \"xl lp gxl lpgxl eco ecogxl\" -norelease_license\n";
  print DOFILE "set analyze option -auto\n";
  print DOFILE "write hier_compare dofile hier_conformal_r2r.do -run_hier_compare \\\n";
  print DOFILE "        -noexact_pin_match -constraint -usage -replace \\\n";
  print DOFILE "        -prepend_string \"report unmapped points -notmapped\" \\\n";
  print DOFILE "        -append_string \"report compare data -class nonequivalent -class abort -class notcompared\"\n";
  print DOFILE "run hier_compare hier_conformal_r2r.do\n";
  print DOFILE "set system mode lec\n";
  print DOFILE "tclmode\n";
  print DOFILE "if {[get_compare_points -diff -abort -unknown -count] > 0} {\n";
  print DOFILE "  vpxmode\n";
  print DOFILE "  vpx analyze setup -verbose\n";
  print DOFILE "  vpx map key points\n";
  print DOFILE "  vpx add compared points -all\n";
  print DOFILE "  vpx compare\n";
  print DOFILE "  usage\n";
  print DOFILE "  vpx delete mapped points -noneq\n";
  print DOFILE "  vpx analyze setup -verbose\n";
  print DOFILE "  vpx map key points\n";
  print DOFILE "  vpx add compared points -all\n";
  print DOFILE "  vpx compare\n";
  print DOFILE "}\n";
  print DOFILE "vpxmode\n";
  print DOFILE "usage\n";
  print DOFILE "report hier_compare result -dynamicflattened\n";
  print DOFILE "report unmapped points -notmapped -golden\n";
  print DOFILE "report unmapped points -notmapped -revised\n";
  print DOFILE "report compare data -summary\n";
  print DOFILE "report compare data -class nonequivalent -class abort -class notcompared\n";
  print DOFILE "report design similarity\n";
  print DOFILE "report verification -verbose\n";
  print DOFILE "report statistics\n";
  print DOFILE "tclmode\n";
  print DOFILE "puts \"No of compare points = [get_compare_points -count]\"\n";
  print DOFILE "puts \"No of diff points    = [get_compare_points -diff -count]\"\n";
  print DOFILE "puts \"No of abort points   = [get_compare_points -abort -count]\"\n";
  print DOFILE "puts \"No of unknown points = [get_compare_points -unknown -count]\"\n";
  print DOFILE "vpxmode\n";
  print DOFILE "exit -force\n";
  close(DOFILE);
} elsif ($compare eq "r2g") {
  if ((-e "$test_dir/rtl_to_retimed.do") && (-e "$test_dir/retimed_to_final.do")) {
    chdir $pwd;
    system("rm -fr $TargetDir") if (-d $TargetDir);
    print "\n\nNote: You are running Conformal-Ultra formal compare on a post-Genus netlist that underwent retiming.\n";
    print "Note: The Genus flow has generated multiple dofiles to run Conformal-Ultra easily in your syn_genus directory.\n";
    print "Note: These scripts will now be run and all results placed in $test_dir\n";
    print "Note: Look at the Conformal-Ultra logfiles in this directory to see if the designs are formally equivalent.\n";
    print "Note: The conformal_summary.txt file summarizes the results of the complete run.\n\n";
    chdir $test_dir;
    generate_command_file($test_dir,$CommandString);
    $genus_to_conformal_flow = 1;
  } elsif ((-e "$test_dir/rtl_to_int.do") && (-e "$test_dir/int_to_final.do") && !(-e "$test_dir/rtl_to_retimed.do")) {
    chdir $pwd;
    system("rm -fr $TargetDir") if (-d $TargetDir);
    print "\n\nNote: You are running Conformal-Ultra formal compare on a post-Genus netlist. The Genus flow has generated\n";
    print "Note: two dofiles that will now run in your syn_genus directory. All results will be placed in ${test_dir}.\n";
    print "Note: Look at the Conformal-Ultra logfiles in this directory to see if the designs are formally equivalent.\n";
    print "Note: The conformal_summary.txt file summarizes the results of the complete run.\n\n";
    chdir $test_dir;
    generate_command_file($test_dir,$CommandString);
    $genus_to_conformal_flow = 1;
  } elsif ($retiming) {
    open(DOFILE,">rtl_to_intermediate_retimed.do") or die ("Cannot create rtl_to_intermediate_retimed.do");
    print DOFILE "set dofile abort off\n";
    print DOFILE "set log file rtl_to_intermediate_retimed.log -replace\n";
    print DOFILE "set undefined cell black_box -noascend -both\n";
    print DOFILE "set undriven signal 0 -both\n";
    print DOFILE "set mapping method -noreport_unreach -report_summary_show_zero_count\n\n";
    print DOFILE "add notranslate modules -library -both $memory_macro_list\n\n" unless ($memory_macro_list eq "");
    if ($using_liberty_files) {
	print DOFILE "read library -statetable -liberty -both $lib_list\n";
    } else {
	print DOFILE "read library -verilog -both $lib_list\n";
    }
    print DOFILE "read design -verilog2k -golden -lastmod $conformal_define_string -noelab -root $design -file $golden \n";
    print DOFILE "elaborate design -golden\n";
    print DOFILE "set root module $design -golden\n";
    print DOFILE "read design -verilog2k -revised -lastmod $test_dir/intermediate_retimed.v\n";
    print DOFILE "report design data\n";
    print DOFILE "report module\n";
    print DOFILE "report black box -detail\n";
    print DOFILE "set modeling effort high\n";
    print DOFILE "set compare effort auto\n";
    print DOFILE "set cpu limit $time_limit -hours -walltime\n";
    foreach my $entry (@RetimedArray) {
	print DOFILE "add module attribute $entry -pipeline_retime -compare_effort auto -golden\n";
	print DOFILE "add module attribute $entry -pipeline_retime -compare_effort auto -revised\n";
    }
    print DOFILE "set retiming option -auto -retimed_module\n\n";
    print DOFILE "set flatten model -nodff_to_dlat_zero -nodff_to_dlat_feedback -gated_clock\n";
    print DOFILE "set flatten model -seq_constant -seq_constant_x_to 0\n";
    print DOFILE "set parallel option -threads $superthread_count -license \"xl lp gxl lpgxl eco ecogxl\" -norelease_license\n";
    print DOFILE "set analyze option -auto -noanalyze_abort\n";
    print DOFILE "write hier_compare dofile hier_rtl_to_intermediate_retimed.do -run_hier_compare \\\n";
    print DOFILE "        -noexact_pin_match -constraint -usage -replace \\\n";
    print DOFILE "        -prepend_string \"report unmapped points -notmapped; analyze datapath -module -verbose; analyze datapath -verbose\" \\\n";
    print DOFILE "        -append_string \"report compare data -class nonequivalent -class abort -class notcompared\"\n";
    print DOFILE "run hier_compare hier_rtl_to_intermediate_retimed.do -noanalyze_boundary\n";
    print DOFILE "usage\n";
    print DOFILE "report hier result -usage\n";
    print DOFILE "report hier result -noneq -usage\n";
    print DOFILE "set mapping method -noname\n\n";
    foreach my $entry (@RetimedArray) {
	next if ($entry =~ /TIE_semantic_group[0-9]+/);
	print DOFILE "set system mode setup\n";
	print DOFILE "set root module $entry -both\n";
	print DOFILE "set system mode lec\n";
	print DOFILE "delete mapped points -noneq\n";
	print DOFILE "analyze setup -verbose\n";
	print DOFILE "map key points\n";
	print DOFILE "add compared points -all\n";
	print DOFILE "compare\n";
	print DOFILE "usage\n";
	print DOFILE "save hier_compare result\n\n";
    }
    print DOFILE "set system mode setup\n";
    print DOFILE "set root module $design -both\n";
    print DOFILE "set system mode lec\n";
    print DOFILE "delete mapped points -noneq\n";
    print DOFILE "analyze setup -verbose\n";
    print DOFILE "map key points\n";
    print DOFILE "add compared points -all\n";
    print DOFILE "compare\n";
    print DOFILE "usage\n";
    print DOFILE "report hier result\n";
    print DOFILE "report unmapped points -notmapped -golden\n";
    print DOFILE "report unmapped points -notmapped -revised\n";
    print DOFILE "report compare data -summary\n";
    print DOFILE "report compare data -class nonequivalent -class abort -class notcompared\n";
    print DOFILE "report design similarity\n";
    print DOFILE "report verification -verbose\n";
    print DOFILE "report statistics\n";
    print DOFILE "tclmode\n";
    print DOFILE "puts \"No of compare points = [get_compare_points -count]\"\n";
    print DOFILE "puts \"No of diff points    = [get_compare_points -diff -count]\"\n";
    print DOFILE "puts \"No of abort points   = [get_compare_points -abort -count]\"\n";
    print DOFILE "puts \"No of unknown points = [get_compare_points -unknown -count]\"\n";
    print DOFILE "vpxmode\n";
    print DOFILE "exit -force\n";
    close(DOFILE);
    open(DOFILE,">intermediate_retimed_to_final.do") or die ("Cannot create intermediate_retimed_to_final.do");
    print DOFILE "set dofile abort off\n";
    print DOFILE "set log file intermediate_retimed_to_final.log -replace\n";
    print DOFILE "set undefined cell black_box -noascend -both\n";
    print DOFILE "set mapping method -noreport_unreach -report_summary_show_zero_count\n\n";
    print DOFILE "add notranslate modules -library -both $memory_macro_list\n\n" unless ($memory_macro_list eq "");
    if ($using_liberty_files) {
	print DOFILE "read library -statetable -liberty -both $lib_list\n";
    } else {
	print DOFILE "read library -verilog -both $lib_list\n";
    }
    print DOFILE "read design -verilog2k -golden -root $design $test_dir/intermediate_retimed.v\n";
    print DOFILE "set root module $design -golden\n";
    print DOFILE "read design -verilog2k -revised $revised\n";
    print DOFILE "report design data\n";
    print DOFILE "report module\n";
    print DOFILE "report black box -detail\n";
    print DOFILE "set modeling effort high\n";
    print DOFILE "set compare effort auto\n";
    print DOFILE "set cpu limit $time_limit -hours -walltime\n";
    if (($scan == 1) && ($csf_insert_scan == 1)) {
	print DOFILE "add pin constraints 0 test_se -revised\n";
	print DOFILE "add ignored inputs test_si* -revised\n";
	print DOFILE "add ignored outputs test_so* -revised\n";
    }
    print DOFILE "set flatten model -nodff_to_dlat_zero -nodff_to_dlat_feedback -gated_clock\n";
    print DOFILE "set flatten model -seq_constant -seq_constant_x_to 0\n";
    print DOFILE "set parallel option -threads $superthread_count -license \"xl lp gxl lpgxl eco ecogxl\" -norelease_license\n";
    print DOFILE "set analyze option -auto\n";
    print DOFILE "set system mode lec\n";
    print DOFILE "analyze setup -verbose\n";
    print DOFILE "remodel -seq_constant -repeat\n";
    print DOFILE "map key points\n";
    print DOFILE "report unmapped points -notmapped -golden\n";
    print DOFILE "report unmapped points -notmapped -revised\n";
    print DOFILE "add compared points -all\n";
    print DOFILE "compare -gate_to_gate\n";
    print DOFILE "usage\n";
    print DOFILE "report compare data -summary\n";
    print DOFILE "report compare data -class nonequivalent -class abort -class notcompared\n";
    print DOFILE "report design similarity\n";
    print DOFILE "report verification -verbose\n";
    print DOFILE "report statistics\n";
    print DOFILE "tclmode\n";
    print DOFILE "puts \"No of compare points = [get_compare_points -count]\"\n";
    print DOFILE "puts \"No of diff points    = [get_compare_points -diff -count]\"\n";
    print DOFILE "puts \"No of abort points   = [get_compare_points -abort -count]\"\n";
    print DOFILE "puts \"No of unknown points = [get_compare_points -unknown -count]\"\n";
    print DOFILE "vpxmode\n";
    print DOFILE "exit -force\n";
    close(DOFILE);
  } else {
    open(DOFILE,">conformal_r2g.do") or die ("Cannot create conformal_r2g.do");
    print DOFILE "set dofile abort off\n";
    print DOFILE "set log file conformal_r2g.log -replace\n";
    print DOFILE "set undefined cell black_box -noascend -both\n";
    print DOFILE "set undriven signal 0 -both\n";
    print DOFILE "set mapping method -noreport_unreach -report_summary_show_zero_count\n\n";
    print DOFILE "add notranslate modules -library -both $memory_macro_list\n\n" unless ($memory_macro_list eq "");
    if ($using_liberty_files) {
	print DOFILE "read library -statetable -liberty -both $lib_list\n";
    } else {
	print DOFILE "read library -verilog -both $lib_list\n";
    }
    print DOFILE "read design -verilog2k -golden -lastmod $conformal_define_string -noelab -root $design -file $golden \n";
    print DOFILE "elaborate design -golden\n";
    print DOFILE "set root module $design -golden\n";
    print DOFILE "read design -verilog2k -revised -lastmod $revised\n";
    print DOFILE "report design data\n";
    print DOFILE "report module\n";
    print DOFILE "report black box -detail\n";
    print DOFILE "set modeling effort high\n";
    print DOFILE "set compare effort auto\n";
    print DOFILE "set cpu limit $time_limit -hours -walltime\n";
    if (($scan == 1) && ($csf_insert_scan == 1)) {
	print DOFILE "add pin constraints 0 test_se -revised\n";
	print DOFILE "add ignored inputs test_si* -revised\n";
	print DOFILE "add ignored outputs test_so* -revised\n";
    }
    print DOFILE "\nset flatten model -nodff_to_dlat_zero -nodff_to_dlat_feedback -gated_clock\n";
    print DOFILE "set flatten model -seq_constant -seq_constant_x_to 0\n";
    print DOFILE "set parallel option -threads $superthread_count -license \"xl lp gxl lpgxl eco ecogxl\" -norelease_license\n";
    print DOFILE "set analyze option -auto\n";
    print DOFILE "write hier_compare dofile hier_conformal_r2g.do -run_hier_compare \\\n";
    print DOFILE "        -noexact_pin_match -constraint -usage -replace \\\n";
    print DOFILE "        -prepend_string \"report unmapped points -notmapped; analyze datapath -module -verbose; analyze datapath -verbose\" \\\n";
    print DOFILE "        -append_string \"report compare data -class nonequivalent -class abort -class notcompared\"\n";
    print DOFILE "run hier_compare hier_conformal_r2g.do\n";
    print DOFILE "set system mode lec\n";
    print DOFILE "tclmode\n";
    print DOFILE "if {[get_compare_points -diff -abort -unknown -count] > 0} {\n";
    print DOFILE "  vpxmode\n";
    print DOFILE "  vpx analyze setup -verbose\n";
    print DOFILE "  vpx map key points\n";
    print DOFILE "  vpx add compared points -all\n";
    print DOFILE "  vpx compare\n";
    print DOFILE "  usage\n";
    print DOFILE "  vpx delete mapped points -noneq\n";
    print DOFILE "  vpx analyze setup -verbose\n";
    print DOFILE "  vpx map key points\n";
    print DOFILE "  vpx add compared points -all\n";
    print DOFILE "  vpx compare\n";
    print DOFILE "}\n";
    print DOFILE "vpxmode\n";
    print DOFILE "usage\n";
    print DOFILE "report hier_compare result -dynamicflattened\n";
    print DOFILE "report unmapped points -notmapped -golden\n";
    print DOFILE "report unmapped points -notmapped -revised\n";
    print DOFILE "report compare data -summary\n";
    print DOFILE "report compare data -class nonequivalent -class abort -class notcompared\n";
    print DOFILE "report design similarity\n";
    print DOFILE "report verification -verbose\n";
    print DOFILE "report statistics\n";
    print DOFILE "tclmode\n";
    print DOFILE "puts \"No of compare points = [get_compare_points -count]\"\n";
    print DOFILE "puts \"No of diff points    = [get_compare_points -diff -count]\"\n";
    print DOFILE "puts \"No of abort points   = [get_compare_points -abort -count]\"\n";
    print DOFILE "puts \"No of unknown points = [get_compare_points -unknown -count]\"\n";
    print DOFILE "vpxmode\n";
    print DOFILE "exit -force\n";
    close(DOFILE);
  }
} elsif ($compare eq "g2g") {
  open(DOFILE,">conformal_g2g.do") or die ("Cannot create conformal_g2g.do");
  print DOFILE "vpx set mapping method -noreport_unreach -report_summary_show_zero_count\n";
  print DOFILE "vpx set dofile abort off\n";
  print DOFILE "vpx set screen display -noprogress\n";
  print DOFILE "tclmode\n";
  print DOFILE "tcl_set_command_name_echo on\n\n";
  print DOFILE "set_log_file conformal_g2g.log -replace\n\n";
  print DOFILE "usage -auto -elapse\n\n";
  print DOFILE "set wlec_analyze_dp_flowgraph true\n";
  print DOFILE "set share_dp_analysis false\n";
  print DOFILE "set DATAPATH_SOLVER_OPTION \"-flowgraph\"\n\n";
  print DOFILE "set_parallel_option -threads $superthread_count -license \"xl lp gxl lpgxl eco ecogxl\" -norelease_license\n";
  print DOFILE "set_compare_options -threads $superthread_count\n\n";
  print DOFILE "set_naming_rule _BAR -inverted_pin_extension -both\n";
  print DOFILE "set_undefined_cell black_box -noascend -both\n\n";
  print DOFILE "add_notranslate_modules -library -both $memory_macro_list\n\n" unless ($memory_macro_list eq "");
  if ($using_liberty_files) {
    print DOFILE "read_library -statetable -liberty -both $lib_list\n\n";
  } else {
    print DOFILE "read_library -verilog -both $lib_list\n\n";
  }
  print DOFILE "read_design -verilog2k -golden -lastmod -noelab $golden\n";
  print DOFILE "elaborate_design -golden -root {$design}\n\n";
  print DOFILE "read_design -verilog2k -revised -lastmod -noelab $revised\n";
  print DOFILE "elaborate_design -revised -root {$design}\n\n";
  print DOFILE "report_design_data\n";
  print DOFILE "set_cpu_limit $time_limit -hours -walltime\n";
  print DOFILE "report_black_box -detail\n\n";
  print DOFILE "set_flatten_model -seq_constant -seq_constant_x_to 0\n";
  print DOFILE "set_flatten_model -nodff_to_dlat_zero -nodff_to_dlat_feedback -hier_seq_merge\n\n";
  print DOFILE "set_compare_effort auto\n\n";
  if (($scan == 1) && ($csf_insert_scan == 1)) {
    print DOFILE "add_pin_constraints 0 {TMode} -both\n";
    print DOFILE "add_pin_constraints 0 {TModeClkGateOverride} -both\n";
    print DOFILE "add_pin_constraints 0 test_se -both\n";
    print DOFILE "add_ignored_inputs test_si* -both\n";
    print DOFILE "add_ignored_outputs test_so* -both\n\n";
  }
  print DOFILE "set_analyze_option -auto\n\n";
  print DOFILE "set_system_mode lec\n\n";
  print DOFILE "report_unmapped_points -summary\n";
  print DOFILE "report_unmapped_points -notmapped\n\n";
  print DOFILE "add_compared_points -all\n\n";
  print DOFILE "compare -gate_to_gate\n\n";
  print DOFILE "report_compare_data -summary\n";
  print DOFILE "report_compare_data -class nonequivalent -class abort -class notcompared\n";
  print DOFILE "report_verification -verbose\n";
  print DOFILE "report_implementation_information -verbose\n";
  print DOFILE "report_statistics\n\n";
  print DOFILE "tclmode\n";
  print DOFILE "puts \"No of compare points = [get_compare_points -count]\"\n";
  print DOFILE "puts \"No of diff points    = [get_compare_points -NONequivalent -count]\"\n";
  print DOFILE "puts \"No of abort points   = [get_compare_points -abort -count]\"\n";
  print DOFILE "puts \"No of unknown points = [get_compare_points -unknown -count]\"\n\n";
  print DOFILE "analyze_results -logfiles conformal_g2g.log\n\n";
  print DOFILE "vpxmode\n";
  print DOFILE "exit -force\n";
  close(DOFILE);
}
$ENV{CDNS_MULTITHREAD_COUNT} = $superthread_count;
generate_command_file($TargetDir,$CommandString) unless ($genus_to_conformal_flow == 1);
my @target_dofiles = <*.do>;
my ($lec_licenses, $use_lp_license);
foreach my $run_script (@target_dofiles) {
  next if (($run_script =~ /^hier_/) || ($run_script =~ /clp_pso_check/));
  $lec_licenses = "-xl";
  $use_lp_license = 0;
  open(INFILE,"<$run_script") or die ("Cannot open $run_script");
  while(<INFILE>) {
    $use_lp_license = 1 if ($_ =~ /\.(c|u)pf/);
  }
  close(INFILE);
  $lec_licenses = "-xl -lp" if ($use_lp_license);
  system("lec $lec_licenses -nogui -dofile $run_script > run.log; rm -f run.log");
}
my @run_logs = <*.log>;
open(SUMMARY,">conformal_summary.txt") or die ("Cannot create conformal_summary.txt");
my ($compare_points,$diff_points,$abort_points,$unknown_points);
my $found_error = 0;
my $non_eq_count = 0;
my $run_timed_out = 0;
my $total_timed_out = 0;
my $first_sys_message = 1;
my $first_error = 1;
foreach my $rl (@run_logs) {
  next if ($rl =~ /^hier_/);
  next unless (($rl =~ /conformal/) || ($rl =~ /_to_/) || ($rl =~ /retim/));
  $compare_points = "N/A";
  $diff_points = "N/A";
  $abort_points = "N/A";
  $unknown_points = "N/A";
  $non_eq_count = 0;
  $run_timed_out = 0;
  $first_sys_message = 1;
  $first_error = 1;
  open(RUNLOG,"<$rl") or die ("Cannot open $rl");
  while(<RUNLOG>) {
    if ($_ =~ /Wall time limit of .* exceeded/) {
	$run_timed_out = 1;
	$total_timed_out = 1;
	last;
    } elsif ($_ =~ /^No of compare points\s+=\s+(\S+)/) {
	$compare_points = $1;
    } elsif ($_ =~ /^No of diff points\s+=\s+(\S+)/) {
	$diff_points = $1;
    } elsif ($_ =~ /^No of abort points\s+=\s+(\S+)/) {
	$abort_points = $1;
    } elsif ($_ =~ /^No of unknown points\s+=\s+(\S+)/) {
	$unknown_points = $1;
    } elsif ($_ =~ /^Non-equivalent/) {
	$non_eq_count++;
    }
    if ($_ =~ /SYSTEM \(undefined\): \(.*R.*\)/) {
	if ($first_sys_message == 1) {
	  print SUMMARY "Warning: The reference design in logfile $rl contains undefined cells, meaning\n";
	  print SUMMARY "Warning: no corresponding library cell could be located. Check to make sure\n";
	  print SUMMARY "Warning: that all required input libraries are specified and spelled correctly\n\n";
	}
	$first_sys_message = 0;
    }
    if ($_ =~ /Error:/) {
	unless (($_ =~ /is\s+already\s+added\s+to\s+instance\s+equivalence\s+list/) || ($_ =~ /Equation\s+Syntax\s+Error/)) {
	  print SUMMARY "The following errors appeared in logfile ${rl}:\n\n" if ($first_error == 1);
	  print SUMMARY $_;
	  $first_error = 0;
	}
    }
  }
  close(RUNLOG);
  print SUMMARY "From logfile ${rl}:\n\n";
  if ($non_eq_count > 0) {
    print SUMMARY "Number of non-equivalent statements in logfile = $non_eq_count\n\n";
    print SUMMARY "Warning: There were non-equivalent compare points found in one or\n";
    print SUMMARY "Warning: more modules processed in this logfile. Check these manually\n";
    print SUMMARY "Warning: to see if they are true failures. For retimed modules, these are\n";
    print SUMMARY "Warning: usually proven correct in the subsequent incremental passes.\n";
    print SUMMARY "Warning: For non-retimed hierarchical designs, bottom-up verification may\n";
    print SUMMARY "Warning: sometimes show non-equivalent points - if the module does not get\n";
    print SUMMARY "Warning: black-boxed, and the subsequent top-level compare passes, then you\n";
    print SUMMARY "Warning: can safely ignore these intermediate non-equivalent points.\n\n";
  }
  print SUMMARY "Number of compare points = $compare_points\n";
  print SUMMARY "Number of different points = $diff_points\n";
  print SUMMARY "Number of abort points = $abort_points\n";
  print SUMMARY "Number of unknown points = $unknown_points\n\n\n";
  print SUMMARY "Error: No compare points detected\n" if ($compare_points == 0);
  print SUMMARY "Error: Different key points detected\n" if ($diff_points > 0);
  print SUMMARY "Error: Abort points detected\n" if ($abort_points > 0);
  print SUMMARY "Error: Unknown key points detected\n" if ($unknown_points > 0);
  $found_error = 1 if (($compare_points == 0) || ($diff_points > 0) || ($abort_points > 0) || ($unknown_points > 0));
  $run_timed_out = 1 if (($compare_points eq "N/A") || ($diff_points eq "N/A") || ($abort_points eq "N/A") || ($unknown_points eq "N/A"));
  if ($run_timed_out) {
    $total_timed_out = 1;
    print SUMMARY "\nWarning: The run recorded in logfile $rl either exceeded the user-specified runtime limit,\n";
    print SUMMARY "Warning: or failed to complete for some other reason. Check the logfile carefully.\n";
  }
}
if ($total_timed_out) {
  print SUMMARY "\nOverall, this Conformal-Ultra run was inconclusive due to a possible timeout\n";
} elsif ($found_error) {
  print SUMMARY "\nOverall, this Conformal-Ultra run was not successful\n";
} else {
  print SUMMARY "\nOverall, this Conformal-Ultra run was successful\n";
  system("rm -fr noneq*map* rtl_fv_map_db fv_map*db hier_tmp*do") == 0 or die ("Cannot perform final cleanup step on Conformal output\n");
}
close(SUMMARY);

#################################################################################
# Subroutines									#
#################################################################################

sub generate_command_file {
  my ($dirname, $cmd_string) = @_;
  open(OUTFILE,">$dirname/formal_compare.run") or die ("Cannot create $dirname/formal_compare.run");
  print OUTFILE "Command string used for this formal compare session:\n\n";
  print OUTFILE "$cmd_string\n";
  close(OUTFILE);
}
