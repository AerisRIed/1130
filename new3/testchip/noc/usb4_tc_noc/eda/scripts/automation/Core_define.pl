#!/usr/bin/env perl

#############################################################################################
#        Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

################################################################################
# Filename: Core_define.pl                                                     #
# Objective: Read in (variable, value) pairs from an implementation            #
#   specification file, which defaults to CadSetup.file, and write them into   #
#   the specified tool definition file.                                        #
#   For example, common output files are:                                      #
#   syn_genus/Genus_generic_define.tcl and layout_innovus/Innovus_define.cmd   #
# Input: implementation specification file                                     #
# Output: specified tool definition file                                       #
################################################################################

use strict;
use File::Spec::Functions qw(:ALL);
use FileHandle;
use Getopt::Long;
use File::Path;
use File::Copy;
use File::Basename;
use FindBin qw($RealBin);
use lib $RealBin;
use Cwd;

################################################################################
# configuration GUI based default variables                                    #
################################################################################
my $clock = int (1000 / 900 * 100 + 0.5) / 100;
my $bridge_clock = 2 * $clock;
my $skew = 0.0625 * $clock;
my $crit_range = 0.40 * $clock;
my $scan = 1;
my $needs_tmode = 0;
my $has_tmode = ($scan && $needs_tmode);
my $needs_cg_override = 1;
my $has_cg_override = ($scan && $needs_cg_override);
my $clock_delay = 0.40 * $clock;

################################################################################
# read in the options                                                          #
################################################################################
my $help = 0;
my $ret;
my $innovus = 0;
my $verify_tempus = 0;
my $tso = 0;
my $extract = 0;
my $NoCheck = 0;
my $topModule;
my $blockName;
my $showVar = "";
my ($inputFile, $outputFile);
my $usage = <<USAGE;
$0 -innovus -verify_tempus -extract
   -block blockName -top topModuleName
   -i inputDir/inputFile -o outputDir/outputFile

Read in synthesis variables from implementation specification file
and write them into a specified tool definition file. If the input
file is not specified, read CadSetup.file in the current directory.
USAGE
$ret = GetOptions(
         "help" => \$help,
         "innovus" => \$innovus,
         "verify_tempus" => \$verify_tempus,
         "tso" => \$tso,
         "extract" => \$extract,
         "no_check" => \$NoCheck,
         "top=s" => \$topModule,
         "block=s" => \$blockName,
         "show=s" => \$showVar,
         "i=s" => \$inputFile,
         "o=s" => \$outputFile);
if ($help || ! $ret) {
  print "$usage";
  exit(1);
}
$inputFile = "./CadSetup.file" unless defined $inputFile;
$outputFile = "./syn_genus/Genus_generic_define.tcl" unless defined $outputFile;

my $core = "";
my $core_cell = "Core";
$core_cell = $blockName if ((defined $blockName) && ($blockName ne ""));
if (defined $ENV{'DESIGN'}) {
  $core = "$ENV{'DESIGN'}";
} elsif ((defined $topModule) && ($topModule ne "")) {
  $core = $topModule;
} else {
  print "Error: DESIGN is not set in env_design.sh. Specify the top module name.\n";
  exit(1);
}  

my (@CLK_PORT,@CLK_FREQ,$JTAG_CLK_PORT,$JTAG_CLK_FREQ,@RST_PORT,@RST_ACTIVE,$JTAG_RST_PORT,$TESTMODE,$TESTMODE_OVERRIDE,$POWER_PLAN) = "";
if (defined $ENV{'CLK_PORT'}) {
  @CLK_PORT = "$ENV{'CLK_PORT'}";
} else {
  print "Error: CLK_PORT is not set in env_design.sh. Specify the Clock port name.\n";
  exit(1);
}
if (defined $ENV{'CLK_FREQ'}) {
  @CLK_FREQ = "$ENV{'CLK_FREQ'}";
} else {
  print "Error: CLK_FREQ is not set in env_design.sh. Specify the Clock frequency.\n";
  exit(1);
} 
if (defined $ENV{'RST_PORT'}) {
   @RST_PORT = "$ENV{'RST_PORT'}";
} else {
  print "Error: RST_PORT is not set in env_design.sh. Specify the Reset port name.\n";
  exit(1);
}
if (defined $ENV{'RST_ACTIVE'}) {
   @RST_ACTIVE = "$ENV{'RST_ACTIVE'}";
} else {
  print "Error: RST_ACTIVE is not set in env_design.sh. Specify the Reset port name.\n";
  exit(1);
}
if (defined $ENV{'JTAG_CLK_PORT'}) {
   $JTAG_CLK_PORT = "$ENV{'JTAG_CLK_PORT'}";
}
if (defined $ENV{'JTAG_CLK_FREQ'}) {
   $JTAG_CLK_FREQ = "$ENV{'JTAG_CLK_FREQ'}";
}
if (defined $ENV{'JTAG_RST_PORT'}) {
   $JTAG_RST_PORT = "$ENV{'JTAG_RST_PORT'}";
}
if (defined $ENV{'TESTMODE'}) {
   $TESTMODE = "$ENV{'TESTMODE'}";
}
if (defined $ENV{'TESTMODE_OVERRIDE'}) {
   $TESTMODE_OVERRIDE = "$ENV{'TESTMODE_OVERRIDE'}";
}

my $fin = new FileHandle ($inputFile, '<');
die "$0: $! - Can't open $inputFile\n" unless defined $fin;

################################################################################
# Data Structures                                                              #
# varMatrix                                                                    #
#   Array of anonymous array references                                        #
#   Each array refered has following entries:                                  #
#     1. inputName                                                             #
#     2. outputName                                                            #
#     3. defaultValue                                                          #
#     4. allowedValue: perl pattern representing allowed values                #
#     5. toolValue: the tools in which the variable should be used             #
#     6. check: variable contains path to file - check file is readable        #
#     7. hidden: these values are not present in an external CadSetup.file     #
# errTable                                                                     #
#   Array of anonymous array references                                        #
#   Each array refered has following entries:                                  #
#     1. line number in $inputFile where error occured                         #
#     2. the line itself                                                       #
#     3. error string                                                          #
################################################################################
my $float = "^-?[0-9]*\.?[0-9]+|^-?[0-9]+\.?[0-9]*";
my $pos_float = "^[0-9]*\.?[0-9]+|^[0-9]+\.?[0-9]*";
my $int = "^-?[0-9]+\$";
my $pos_int = "^[0-9]+\$";
my $bool = "^[0|1]\$";
my $str = ".+";
my $wstr = "[a-zA-Z0-9_\.]+";
my $gen_map = "^(low|medium|high)\$";
my $flow_goal = "^(None|LowPower|Balanced|Fmax_PLE|Fmax_iSpatial|RTL_Comp)\$";
my $tech_node = "^(N22|N12|N10|N7|N7Plus|N6|N5|N5PlusPlus|N4|N3|N3E|N2|S11|S10|S8|S7|S5|S4|S3|S2|G7|G5|ICF|I7|I5|P1277|P1278|P1280|C12|C7|unspecified)\$";
my $vlts_strat = "^[1|2|3]\$";
my $pwr_targ = "^[1|2|3|4|5]\$";
my $tempus_pba = "^[0|1|2]\$";
my $acns = "^[0|1|2]\$";
my $derate_method = "^[0|1|2|3]\$";
my $threads = "^(1|2|4|6|8|10|12|14|16|18|20|22|24|26|28|30|32)\$";
my $ch1 = $NoCheck ? "0" : "1";
my $ch2 = $NoCheck ? "0" : "2";
my $outputNameCol = 1;
my $defaultValueCol = 2;
my $allowedValueCol = 3;
my $TOOLNameCol = 4;
my $CheckCol = 5;
my $HiddenCol = 6;
my $specifiedValueCol = 7;
#  "InputName"			      	    "OutputName"		    		"DefaultValue"       	"AllowedValue"  "Tool"			"Check"	"Hidden"
my @varMatrix = (
  ["CORE_BLOCK",			    "CORE_BLOCK",		      		"$core_cell",       	$str,   	"_0_",			0,	1,		],
  ["TopDesign",			            "TOP_DESIGN",		    		$core,	     	        $str,   	"_0_",			0,	1,		],
  ["Target_FlowGoal",			    "GLOBAL_FLOW_GOAL",				"None",			$flow_goal,     "_0_2_",		0,	0,		],
  ["Target_MaxDataTransition",	            "MAX_DATA_TRANSITION",	     		0.2,	      		$pos_float, 	"_0_",			0,	0,		],
  ["Target_MaxClockTransition",		    "MAX_CLOCK_TRANSITION",			0.1,			$pos_float,	"_0_",			0,	0,		],
  ["Target_MaxFanout",			    "MAX_FANOUT",				0,			$pos_int,	"_0_",			0,	0,		],
  ["Target_MaxCapacitance",		    "MAX_CAPACITANCE",				0,			$pos_float,	"_0_",			0,	0,		],
  ["Target_ClockSkew",		      	    "CLOCK_SKEW",		    		$skew,	       		$float, 	"_0_",			0,	0,		],
  ["Target_MaxClockInsertion",	      	    "CLOCK_DELAY",		   		$clock_delay,		$pos_float, 	"_0_",			0,	0,		],
  ["Target_HoldMargin",		     	    "HOLD_MARGIN",			      	0.0,		    	$pos_float,     "_0_",	  		0,	0,		],
  ["Target_ClockJitter",		    "CLOCK_JITTER",		      		0.0,		   	$pos_float,	"_0_",			0,	0,		],
  ["Target_LowPowerFlow",		    "LOW_POWER_FLOW",		      		0,		   	$bool,		"_0_",			0,	0,		],
  ["Target_LowPowerGoal",		    "LOW_POWER_GOAL",		      		5,		   	$pwr_targ,	"_0_",			0,	0,		],
  ["Target_LowPowerLDR",		    "LOW_POWER_LDR",				0.5,			$pos_float,	"_0_",			0,	0,		],
  ["Target_UsePowerLibrary",		    "USE_POWER_LIBRARY",			0,			$bool,		"_0_",			0,	0,		],
  ["Target_LowPowerStimFile",		    "LOW_POWER_STIM_FILE",	      		"{}",		   	$str,		"_0_",			$ch2,	0,		],
  ["Target_UseMBCI",			    "USE_MULTIBIT_CELLS",			0,			$bool,		"_1_2_4_7_",		0,	0,		],
  ["Target_MBCIMapFile",		    "MBCI_MAP_FILE",				"_none_",		$str,		"_1_",			0,	0,		],
  ["Target_MBCIRegisterGroupFile",	    "MBCI_GROUP_FILE",				"_none_",		$str,		"_1_",			0,	0,		],
  ["Target_derate_max_late_data_cell",      "DERATE_SLDC",		      		1,		   	$pos_float,	"_1_4_5_6_7_",		0,	0,		],
  ["Target_derate_max_late_data_net",       "DERATE_SLDN",	       			1,		   	$pos_float,    	"_1_4_5_6_7_",		0,	0,		],
  ["Target_derate_max_late_clock_cell",     "DERATE_SLCC",	       			1,		   	$pos_float,    	"_1_4_5_6_7_",		0,	0,		],
  ["Target_derate_max_late_clock_net",      "DERATE_SLCN",	       			1,		   	$pos_float,    	"_1_4_5_6_7_",		0,	0,		],
  ["Target_derate_max_early_data_cell",     "DERATE_SEDC",	       			1,		   	$pos_float,    	"_1_4_5_6_7_",		0,	0,		],
  ["Target_derate_max_early_data_net",      "DERATE_SEDN",	       			1,		   	$pos_float,    	"_1_4_5_6_7_",		0,	0,		],
  ["Target_derate_max_early_clock_cell",    "DERATE_SECC",	       			1,		   	$pos_float,    	"_1_4_5_6_7_",		0,	0,		],
  ["Target_derate_max_early_clock_net",     "DERATE_SECN",	       			1,		   	$pos_float,    	"_1_4_5_6_7_",		0,	0,		],
  ["Target_derate_min_late_data_cell",      "DERATE_FLDC",	       			1,		   	$pos_float,    	"_1_4_5_6_",		0,	0,		],
  ["Target_derate_min_late_data_net",       "DERATE_FLDN",	       			1,		   	$pos_float,    	"_1_4_5_6_",		0,	0,		],
  ["Target_derate_min_late_clock_cell",     "DERATE_FLCC",	       			1,		   	$pos_float,    	"_1_4_5_6_",		0,	0,		],
  ["Target_derate_min_late_clock_net",      "DERATE_FLCN",	       			1,		   	$pos_float,    	"_1_4_5_6_",		0,	0,		],
  ["Target_derate_min_early_data_cell",     "DERATE_FEDC",	       			1,		   	$pos_float,    	"_1_4_5_6_",		0,	0,		],
  ["Target_derate_min_early_data_net",      "DERATE_FEDN",	       			1,		   	$pos_float,    	"_1_4_5_6_",		0,	0,		],
  ["Target_derate_min_early_clock_cell",    "DERATE_FECC",	       			1,		   	$pos_float,    	"_1_4_5_6_",		0,	0,		],
  ["Target_derate_min_early_clock_net",     "DERATE_FECN",	       			1,		   	$pos_float,    	"_1_4_5_6_",		0,	0,		],
  ["Lib_CadenceLIB",		       	    "Lib_CadenceLIB",	       			"{}",	  	   	$str,   	"_3_4_6_7_",		$ch1,	0,		],
  ["Lib_CadenceLIBML",		     	    "Lib_CadenceLIBML",		       		"{}",	  	   	$str,   	"_3_6_",		$ch2,	0,		],
  ["Lib_CadenceMinLIB",			    "Lib_CadenceMinLIB",	    		"{}",	  	   	$str,   	"_3_4_6_7_",		$ch1,	0,		],
  ["Lib_DriveCell",			    "DRIVE_CELL",		    		"DFFX4",	     	$str,   	"_1_5_6_7_",		0,	0,		],
  ["Lib_OperatingCondition",		    "OPERATING_CONDITION",	   		"_none_",	    	$str,   	"_1_4_5_6_7_",		0,	0,		],
  ["Lib_MinOperatingCondition",	     	    "MIN_OPERATING_CONDITION",       		"_none_",	    	$str,   	"_1_4_5_6_7_",		0,	0,		],
  ["Lib_DriveCellsPin",		     	    "DRIVE_PIN",		     		"D",		 	$str,   	"_1_5_6_7_",		0,	0,		],
  ["Lib_DriveCellPinFrom",		    "DRIVE_PIN_FROM",				"CK",			$str,   	"_1_5_6_7_",		0,	0,		],
  ["Lib_BoundaryLoad",		      	    "BOUNDARY_LOAD",		 		"slow/INVX1/A",      	$str,   	"_1_5_6_7_",		0,	0,		],
  ["Lib_PreferCells",		       	    "LIB_PREFER",		    		"{}",			$str,   	"_1_7_",		0,	0,		],
  ["Lib_DontUseCells",		      	    "LIB_DONT_USE",		  		"{}",			$str,   	"_1_6_7_",		0,	0,		],
  ["Lib_CadenceTechFile",		    "CADENCE_TECH_FILE",	      		"{}",  		   	$str,   	"_1_",			$ch1,	0,		],
  ["Lib_CadencePhysicalLibrary",	    "Lib_CadencePhysicalLibrary",    		"{}", 		   	$str,   	"_3_4_6_7_9_",		$ch1,	0,		],
  ["Lib_VerilogSimulationLibrary",	    "VERILOG_SIM_LIB",				"{}",			$str,		"_7_",			$ch2,	0,		],
  ["Lib_MaxTLUPlus",			    "MAX_TLU_PLUS",		      		"{}",	   	   	$str,		"_1_",			$ch2,	0,		],
  ["Lib_LayerNameMapFile",		    "LAYER_MAP_FILE",		      		"{}",	   	   	$str,		"_1_",			$ch2,	0,		],
  ["Lib_MaxQrcTechFile",		    "Lib_MaxQrcTechFile",			"{}",			$str,		"_3_4_7_9_",		$ch2,	0,		],
  ["Lib_TypQrcTechFile",		    "Lib_TypQrcTechFile",			"{}",			$str,		"_3_4_7_9_",		$ch2,	0,		],
  ["Lib_MinQrcTechFile",		    "Lib_MinQrcTechFile",			"{}",			$str,		"_3_4_7_9_",		$ch2,	0,		],
  ["Lib_MaxCornerTemp",		     	    "Lib_MaxCornerTemp",			125,		    	$int,	   	"_3_4_9_",		0,	0,		],
  ["Lib_TypCornerTemp",			    "Lib_TypCornerTemp",			25,			$int,		"_3_4_9_",		0,	0,		],
  ["Lib_MinCornerTemp",		     	    "Lib_MinCornerTemp",			0,		      	$int,	   	"_3_4_9_",		0,	0,		],
  ["Lib_MaxCapTable",		       	    "Lib_MaxCapTable",		  		"{}",			$str,   	"_4_7_",		$ch2,	0,		],
  ["Lib_TypCapTable",			    "Lib_TypCapTable",				"{}",			$str,		"_4_7_",		$ch2,	0,		],
  ["Lib_MinCapTable",		       	    "Lib_MinCapTable",		  		"{}",			$str,   	"_4_7_",		$ch2,	0,		],
  ["Lib_MaxSBOCV",			    "MAX_SBOCV",				"{}",			$str,		"_3_4_5_6_7_",		$ch2,	0,		],
  ["Lib_MinSBOCV",			    "MIN_SBOCV",				"{}",			$str,		"_3_4_5_6_7_",		$ch2,	0,		],
  ["Lib_ClockBuffers",			    "LIB_CLOCK_BUFFERS",	      		"{}",		   	$str,		"_4_7_",		0,	0,		],
  ["Lib_ClockInverters",		    "LIB_CLOCK_INVERTERS",	      		"{}",		   	$str,		"_4_7_",		0,	0,		],
  ["Lib_FillerCells",		            "Lib_FillerCells",	          		"{}",		   	$str,		"_3_4_",        	0,      0,		],
  ["Lib_IOBuffers",			    "LIB_IO_BUFFERS",				"{}",			$str,		"_4_7_",		0,	0,		],
  ["Lib_ProcessNode",			    "LIB_PROCESS_NODE",				28,			$pos_int,	"_1_3_4_6_7_9_",	0,	0,		],
  ["Lib_TechNode",			    "LIB_TECH_NODE",				"unspecified",		$tech_node,	"_1_3_4_6_7_9_",	0,	0,		],
  ["Lib_MixedHeightLibrary",		    "LIB_MH_LIBRARY",				0,			$bool,		"_1_3_4_6_7_9_",	0,	0,		],
  ["Lib_MHShortCellHeight",		    "LIB_MH_SHORT_HEIGHT",			0,			$pos_float,	"_1_3_4_6_7_9_",	0,	0,		],
  ["Lib_MHTallCellHeight",		    "LIB_MH_TALL_HEIGHT",			0,			$pos_float,	"_1_3_4_6_7_9_",	0,	0,		],
  ["Lib_MHDoubleCellHeight",		    "LIB_MH_DOUBLE_HEIGHT",			0,			$pos_float,	"_1_3_4_6_7_9_",	0,	0,		],
  ["Syn_InsertScan",			    "INSERT_SCAN",		   		0,	       		$bool,  	"_0_2_",		0,	0,		],
  ["Syn_MaxTestCoverage",		    "MAX_TEST_COVERAGE",	      		0,		   	$bool,		"_1_7_",		0,	0,		],
  ["Syn_MaxScanChainLength",		    "MAX_CHAIN_LENGTH",	      			50000,		   	$pos_int,	"_1_7_",		0,	0,		],
  ["Syn_UseAdvancedFeatures",		    "USE_ADVANCED_FEATURES",	      		0,		   	$bool,		"_1_7_",		0,	0,		],
  ["Syn_UseSPG",			    "USE_SPG",					0,			$bool,		"_1_2_",		0,	1,		],
  ["Syn_SuperthreadCount",		    "SUPERTHREAD_COUNT",			1,			$threads,	"_1_2_3_4_6_7_9_",	0,	0,		],
  ["Syn_ImplementPSO",			    "USE_PSO",					0,			$bool,		"_1_3_4_5_6_7_",	0,	1,		],
  ["Innovus_EnableFuSa",		    "ENABLE_FUSA",				0,			$bool,		"_3_4_6_7_",		0,	1,		],
  ["Syn_UseMemoryMacros",		    "USE_MEMORY_MACROS",	      		0,		   	$bool,		"_1_2_3_4_5_6_7_",	0,	1,		],
  ["Lib_CadenceTypLIB",			    "Lib_CadenceTypLIB",	    		"{}",		   	$str,  		"_1_3_4_6_7_",		$ch2,	0,		],
  ["Lib_TypOperatingCondition",	     	    "TYP_OPERATING_CONDITION",       		"_none_",	    	$str,  		"_1_4_5_6_7_",		0,	0,		],
  ["Lib_TypBoundaryLoad",		    "TYP_BOUNDARY_LOAD",	     		"typical/INVX1/A",   	$str,  		"_1_5_6_7_",		0,	0,		],
  ["Lib_TypPreferCells",		    "TYP_LIB_PREFER",				"{}",			$str,  		"_1_7_",		0,	0,		],
  ["Lib_TypDontUseCells",		    "TYP_LIB_DONT_USE",	      			"{}",			$str,  		"_1_7_",		0,	0,		],
  ["Genus_Dump",			    "GENUS_DUMP",		      		0,		   	$bool,		"_7_",  		0,	1,		],
  ["Genus_NumPaths",			    "GENUS_NUM_PATHS",		      		500,		   	$pos_int,	"_7_",  		0,	0,		],
  ["Genus_Effort",			    "GENUS_MAP_EFFORT",		      		"high",		   	$gen_map,	"_7_",			0,	0,		],
  ["Genus_AdditionalPasses",		    "GENUS_ADDITIONAL_PASSES",	      		2,		   	$pos_int,      	"_7_",			0,	0,		],
  ["Genus_iSpatialEnable",		    "GENUS_USE_ISPATIAL",			0,			$bool,		"_2_4_7_",		0,	0,		],
  ["Genus_CustomPLEFile",		    "GENUS_CUSTOM_PLE_FILE",			"_none_",		$str,		"_7_",			0,	1,		],
  ["Genus_AdditionalSDCCons",		    "GENUS_ADDITIONAL_SDC_CONS",		"_none_",		$str,		"_7_",			0,	0,		],
  ["Genus_CongestionOpt",		    "GENUS_CONGESTION",				0,			$bool,		"_7_",			0,	1,		],
  ["Genus_ResScaleFactor",		    "GENUS_RES_WIRE_SCALE",			1.0,			$pos_float,	"_7_",			0,	0,		],
  ["Genus_CapScaleFactor",		    "GENUS_CAP_WIRE_SCALE",			1.0,			$pos_float,	"_7_",			0,	0,		],
  ["Genus_OptimizeTNS",			    "GENUS_OPT_TNS",		      		1,		   	$bool,		"_7_",			0,	0,		],
  ["Genus_UseInitialTarget",		    "GENUS_USE_INITIAL_TARGET",			1,			$bool,		"_7_",			0,	0,		],
  ["Genus_SynthUncertainty",		    "GENUS_SYNTH_UNCERTAINTY",			$skew,			$float,		"_5_6_7_",		0,	0,		],
  ["Genus_WriteSPEF",			    "GENUS_WRITE_SPEF",				1,			$bool,		"_7_",			0,	0,		],
  ["Genus_WriteSDF",			    "GENUS_WRITE_SDF",		      		0,		   	$bool,		"_7_",			0,	1,		],
  ["Genus_DerateMethod",		    "GENUS_DERATE_METHOD",			0,			$derate_method,	"_7_",			0,	0,		],
  ["Genus_InsertMBIST",		    	    "GENUS_MBIST_INSERTION",      		0,		   	$derate_method,	"_7_",  		0,	0,		],
  ["Fplan_AspectRatio",		     	    "Fplan_AspectRatio",	     		1.0,		 	$pos_float, 	"_1_4_7_",		0,	0,		],
  ["Fplan_CoreUtilization",		    "Fplan_CoreUtilization",	 		0.60,			$pos_float, 	"_1_4_7_",		0,	0,		],
  ["Fplan_AddEndcapTap",		    "Fplan_AddEndcapTap",		       	0,		      	$bool,	  	"_4_",	  		0,	0,		],
  ["Fplan_CoreToIOSpacing",		    "Fplan_CoreToIOSpacing",	 		30,		  	$pos_float, 	"_4_",			0,	0,		],
  ["Fplan_MaxRoutingLayer",		    "Fplan_MaxRoutingLayer",	 		0,		   	$pos_int,   	"_4_7_",		0,	0,		],
  ["Fplan_TopBottomPinLayer",	       	    "Fplan_TopBottomPinLayer",       		"_none_",	    	$str,   	"_4_",			0,	0,		],
  ["Fplan_LeftRightPinLayer",	       	    "Fplan_LeftRightPinLayer",       		"_none_",	    	$str,   	"_4_",			0,	0,		],
  ["Fplan_LeftPinList",		     	    "Fplan_LeftPinList",	     		"{}",			$str,   	"_4_",			0,	1,		],
  ["Fplan_RightPinList",		    "Fplan_RightPinList",	    		"{}",			$str,   	"_4_",			0,	1,		],
  ["Fplan_TopPinList",		      	    "Fplan_TopPinList",	      			"{}",			$str,   	"_4_",			0,	1,		],
  ["Fplan_BottomPinList",		    "Fplan_BottomPinList",	   		"{}",			$str,   	"_4_",			0,	1,		],
  ["Fplan_PowerNetName",		    "Fplan_PowerNetName",	    		"VDD",	       		$str,   	"_1_3_4_6_",		0,	0,		],
  ["Fplan_GroundNetName",		    "Fplan_GroundNetName",	   		"VSS",	       		$str,   	"_1_3_4_6_",		0,	0,		],
  ["Fplan_PowerGroundRailLayer",	    "Fplan_PowerGroundRailLayer",		"AUTO",	    		$str,   	"_4_",			0,	0,		],
  ["Fplan_File",			    "FPLAN_FILE",			       	"_none_",	       	$str,	   	"_1_2_4_7_",		0,      0,      	],
  ["Fplan_FlipChipBumpCell",		    "Fplan_FlipChipBumpCell",			"_none_",	       	$str,	   	"_3_4_",		0,      0,      	],
  ["Fplan_FlipChipBumpPitch",		    "Fplan_FlipChipBumpPitch",			"0",		       	$pos_int,   	"_3_4_",		0,      0,      	],
  ["Fplan_AddFlipChipBump",		    "Fplan_AddFlipChipBump",			"0",		       	$pos_int,   	"_3_4_",		0,      0,      	],
  ["Innovus_UltraAccuracyMode",	       	    "Innovus_UltraAccuracyMode",	  	"0",		    	$pos_int,       "_4_6_7_",		0,	0,		],
  ["Innovus_EnablePowerPlan",	       	    "Innovus_EnablePowerPlan",		  	"0",		    	$pos_int,       "_3_4_",		0,	0,		],
  ["Innovus_NumPaths",			    "Innovus_NumPaths",				500,			$pos_int,	"_4_",			0,	0,		],
  ["Innovus_WriteSDF",		      	    "Innovus_WriteSDF",		 		0,		   	$bool,  	"_4_",			0,	0,		],
  ["Innovus_WriteSPEF",		     	    "Innovus_WriteSPEF",		 	0,		   	$bool,  	"_4_",			0,	0,		],
  ["Innovus_FP_Use",			    "Innovus_FP_USE",			   	0,		      	$pos_int,      	"_2_4_",		0,	0,		],
  ["Innovus_PlaceIOPins",		    "Innovus_PlaceIOPins",		      	2,		      	$pos_int,      	"_4_",			0,      0,      	],
  ["Innovus_TopPins",		    	    "Innovus_TopPins",			      	2,		      	$str,      	"_4_",			0,      0,      	],
  ["Innovus_BotPins",		    	    "Innovus_BotPins",			      	2,		      	$str,      	"_4_",			0,      0,      	],
  ["Innovus_LeftPins",		    	    "Innovus_LeftPins",			      	2,		      	$str,      	"_4_",			0,      0,      	],
  ["Innovus_RightPins",		    	    "Innovus_RightPins",		      	2,		      	$str,      	"_4_",			0,      0,      	],
  ["Innovus_CcoptUsefulSkewEnabled",	    "Innovus_CcoptUsefulSkewEnabled",	   	0,		      	$pos_int,      	"_4_7_",		0,      0,      	],
  ["Innovus_ClockShieldingEnabled",	    "Innovus_ClockShieldingEnabled",	    	0,		      	$pos_int,      	"_4_",	  		0,      0,      	],
  ["Innovus_PreCTSUncertainty",	     	    "Innovus_PreCTSUncertainty",		0,		      	$pos_float,    	"_4_",	  		0,      0,      	],
  ["Innovus_CTSUncertainty",		    "Innovus_CTSUncertainty",		   	0,		      	$pos_float,    	"_4_",	  		0,      0,      	],
  ["Innovus_PostRouteUncertainty",	    "Innovus_PostRouteUncertainty",	     	0,		      	$pos_float,    	"_4_",	  		0,      0,      	],
  ["Innovus_RoutingFlow",		    "Innovus_RoutingFlow",		      	"_default_",	      	$str,	   	"_4_",	  		0,      0,      	],
  ["Innovus_EnablePathGroups",	      	    "Innovus_EnablePathGroups",		 	1,		      	$pos_int,       "_4_",	  		0,      1,      	],
  ["Innovus_EnableIOPathGroup",	     	    "Innovus_EnableIOPathGroup",		1,		      	$pos_int,       "_4_",	  		0,      1,      	],
  ["Innovus_InsertionDelayFactor",	    "Innovus_InsertionDelayFactor",	     	1.5,  			$pos_float,     "_4_7_",  		0,      0,      	],
  ["Innovus_MaxAllowedDelay",	  	    "Innovus_MaxAllowedDelay",	    		1,  			$pos_float,     "_4_7_",  		0,      0,      	],
  ["Innovus_WFP",	  	   	    "Innovus_WFP",  			  	0,  			$bool,		"_4_",	  		0,      0,      	],
  ["Innovus_DerateMethod",		    "Innovus_DerateMethod",	       		0,		   	$derate_method, "_3_4_6_",		0,	0,		],
  ["Innovus_MixedPlacer",		    "Innovus_MixedPlacer",			0,			$bool,		"_2_4_",		0,	0,		],
  ["Innovus_PPlan_File",		    "Innovus_PPlan_File",			"_none_",		$str,		"_4_10_",		0,	0,		],
  ["Innovus_UseiSpatialDB",                 "Innovus_UseiSpatialDB",                    0,                      $bool,          "_4_",                  0,      0,              ],
  ["Innovus_ExtremeFlow",                   "Innovus_ExtremeFlow",                      0,                      $bool,          "_4_",                  0,      0,              ],
  ["Innovus_MinAreaFlow",                   "Innovus_MinAreaFlow",                      0,                      $bool,          "_4_",                  0,      0,              ],
  ["Innovus_EarlyClockFlow",                "Innovus_EarlyClockFlow",                   0,                      $bool,          "_4_7_",                0,      0,              ],  
  ["Innovus_DfmFlow",	 	            "Innovus_DfmFlow",	     	                0,  			$acns,	  	"_3_4_",	  	0,      0,      	],
  ["Innovus_ViaPillarFlow",                 "Innovus_ViaPillarFlow",                    0,                      $bool,          "_4_6_",                0,      0,              ],
  ["Lib_ViaPillar_LEF",                     "Lib_ViaPillar_LEF",                        "_none_",               $str,           "_4_6_",                0,      0,              ],
  ["Lib_ViaPillar_Associations",            "Lib_ViaPillar_Associations",               "_none_",               $str,           "_4_6_",                0,      0,              ],
  ["Lib_CNODEdge_Info",                     "Lib_CNODEdge_Info",                        "{}",                   $str,           "_3_4_6_7_",            $ch2,   0,              ],
  ["Lib_MinCNODLeak_Info",                  "Lib_MinCNODLeak_Info",                     "{}",                   $str,           "_3_4_6_7_",            $ch2,   0,              ],
  ["Lib_TypCNODLeak_Info",                  "Lib_TypCNODLeak_Info",                     "{}",                   $str,           "_3_4_6_7_",            $ch2,   0,              ],
  ["Lib_CNODLeak_Config",                   "Lib_CNODLeak_Config",                      "{}",                   $str,           "_3_4_6_7_",            $ch2,   0,              ],
  ["Innovus_DecapCells",	 	    "Innovus_DecapCells",	     		"_none_",  		$str,	  	"_3_4_",	  	0,      0,      	],
  ["Innovus_DecapPerUnitArea",	            "Innovus_DecapPerUnitArea",	     	        0,  			$pos_float,	"_4_",	  		0,      0,      	],
  ["QRC_LayerMappingFile",		    "QRC_LayerMappingFile",		     	"{}",		   	$str,	   	"_9_",	  		$ch2,   0,      	],
  ["QRC_CmdFile",			    "QRC_CmdFile",			      	"{}",		   	$str,	   	"_9_",	  		0,      0,      	],
  ["Tempus_WriteSDF",			    "TEMPUS_WRITE_SDF",				0,		   	$bool,   	"_6_",			0,	0,		],
  ["Tempus_NumPaths",			    "TEMPUS_NUM_PATHS",				500,			$pos_int,	"_6_",			0,	0,		],
  ["Tempus_SI", 	     		    "TEMPUS_SI", 		      		1,		   	$bool,   	"_6_",			0,	0,		],
  ["Tempus_PBA", 	     		    "TEMPUS_PBA", 		      		2,		   	$tempus_pba,  	"_6_",			0,	0,		],
  ["Tempus_WFP", 	     		    "TEMPUS_WFP", 		      		0,		   	$bool,   	"_6_",			0,	0,		],
  ["Tempus_TSO_Opt", 	     	    	    "TEMPUS_TSO_OPT",	      			0,		   	$pos_int,   	"_6_",			0,	0,		],
  ["Tempus_TSO_Opt_Pass2",     	    	    "TEMPUS_TSO_OPT_PASS2",	    		0,		   	$pos_int,   	"_6_",			0,	0,		],
  ["Tempus_GenerateETM",		    "TEMPUS_GENERATE_ETM",			0,			$bool,		"_6_",			0,	0,		],
);

################################################################################
# read in $inputFile                                                           #
################################################################################
my @errTable;
my $errTable;
my $line = 0;
my $found_error = 0;
my ($key, $value);
my $var;
my @varSubMatrix;
while (<$fin>) {
  $line++;
  chomp;
  s/^\s*//;
  next if (/^\s*$/ || /^\s*?#/);
  next if (/^Sim_/);
  unless (/^\s*(\S+)\s+([^#]*)/) {
    push @errTable, [$line, $_, "incorrect specification - ignoring\n"];
  } else {
    $key = $1;
    $value = $2;
    $value =~ s/\s*$//;
    $value =~ s/,/ /g;
    $value =~ s/{\s+/{/;
    $value =~ s/\s+}/}/;
    if (($innovus) && ((/^Innovus_/) || (/^Lib_CadencePhysicalLibrary/) || (/^Lib_CadenceMinLIB/) || (/^Lib_CadenceLIB/) ||  (/^Lib_CadenceTypLIB/) ||
	(/^Lib_MaxQrcTechFile/) || (/^Lib_TypQrcTechFile/) || (/^Lib_MinQrcTechFile/) || (/^Lib_MaxCapTable/) || (/^Lib_TypCapTable/) || (/^Lib_MinCapTable/) ||
	(/^Lib_ClockBuffers/) || (/^Lib_ClockInverters/) || (/^Lib_FillerCells/) || (/^Lib_MaxSBOCV/) || (/^Lib_MinSBOCV/) || (/^Target_LowPowerStimFile/) ||
	(/^Lib_ViaPillar/) || (/^Lib_CNOD/) || (/^Lib_TypCNODLeak_Info/) || (/^Lib_MinCNODLeak_Info/)) && ($value !~ /^{\s*}$/)) {
      $value =~ s/{//g;
      $value =~ s/}//g;
    }
    if ($value =~ /^\s*$/) {
      push @errTable, [$line, $_, "incorrect specification - ignoring\n"];
    } else {
      @varSubMatrix = grep($key eq $_->[0], @varMatrix);
      $var = $varSubMatrix[0];
      $var->[$specifiedValueCol] = $value;
    }
  }
}

################################################################################
# adjust variable values for special cases, perform some error checking        #
################################################################################
my $syn_mem_level = 0;
my $low_power_flow = 0;
my $pso_flow = 0;
my $specified_scan = 0;
my $tech_lef_file = "none";
my $user_defined_routing_layer = "none";
my $min_routing_layer = "";
my $max_routing_layer = "";
my $max_density = 0;
my $tsomllib = "none";
my $tsoopt = 0;
my $none_count = 0;
my $hier_flow_selector = 0;
my $ispatial_flow = 0;
my $specified_ldr = 0.5;
my $sfg = "None";
my $mixed_height_lib = 0;
my $mh_short_height = 0;
my $mh_tall_height = 0;
my $mh_double_height = 0;

foreach (@varMatrix) {
  if ($showVar ne "") {
    if (($_->[$outputNameCol] eq $showVar) && (($_->[$TOOLNameCol] =~ /_2_/) || ($_->[$TOOLNameCol] =~ /_6_/))) {
      if (! defined ($_->[$specifiedValueCol])) {
	print "$_->[$defaultValueCol]";
      } else {
	print "$_->[$specifiedValueCol]";
      }
      exit(0);
    }
    next;
  }
  if (($_->[$outputNameCol] eq "GLOBAL_FLOW_GOAL") && ($_->[$specifiedValueCol] =~ /${flow_goal}/)) {
    $sfg = $_->[$specifiedValueCol];
  }
  if (($_->[$outputNameCol] eq "USE_MEMORY_MACROS") && ($_->[$specifiedValueCol] == 1)) {
    $syn_mem_level = 1;
  }
  if (($_->[$outputNameCol] eq "LIB_MH_LIBRARY") && ($_->[$specifiedValueCol] == 1)) {
    $mixed_height_lib = 1;
  }
  if (($_->[$outputNameCol] eq "LIB_MH_SHORT_HEIGHT") && (defined $_->[$specifiedValueCol])) {
    $mh_short_height = $_->[$specifiedValueCol];
  }
  if (($_->[$outputNameCol] eq "LIB_MH_TALL_HEIGHT") && (defined $_->[$specifiedValueCol])) {
    $mh_tall_height = $_->[$specifiedValueCol];
  }
  if (($_->[$outputNameCol] eq "LIB_MH_DOUBLE_HEIGHT") && (defined $_->[$specifiedValueCol])) {
    $mh_double_height = $_->[$specifiedValueCol];
  }
  if (($_->[$outputNameCol] eq "GENUS_USE_ISPATIAL") && ($_->[$specifiedValueCol] == 1)) {
    $ispatial_flow = 1;
  }
  if (($_->[$outputNameCol] eq "LOW_POWER_FLOW") && ($_->[$specifiedValueCol] == 1)) {
    $low_power_flow = 1;
  }
  if (($_->[$outputNameCol] eq "INSERT_SCAN") && ($_->[$specifiedValueCol] == 1)) {
    $specified_scan = 1;
  }
  if (($_->[$outputNameCol] eq "LOW_POWER_LDR") && (defined $_->[$specifiedValueCol])) {
    $specified_ldr = $_->[$specifiedValueCol];
  }
  if (($_->[$outputNameCol] eq "Lib_CadencePhysicalLibrary") && (defined $_->[$specifiedValueCol])) {
    $tech_lef_file = $_->[$specifiedValueCol];
  }
  if (($_->[$outputNameCol] eq "Lib_CadenceLIBML") && (defined $_->[$specifiedValueCol])) {
    $tsomllib = $_->[$specifiedValueCol];
  }
  if (($_->[$outputNameCol] eq "TEMPUS_TSO_OPT") && (defined $_->[$specifiedValueCol])) {
    $tsoopt = $_->[$specifiedValueCol];
  }
  if (($_->[$outputNameCol] eq "Fplan_MaxRoutingLayer") && (defined $_->[$specifiedValueCol])) {
    $user_defined_routing_layer = $_->[$specifiedValueCol];
  }
  if ($_->[$outputNameCol] eq "Fplan_CoreUtilization") {
    if (defined $_->[$specifiedValueCol]) {
      $max_density = sprintf("%.2f",((1 + $_->[$specifiedValueCol]) / 2));
    } else {
      $max_density = sprintf("%.2f",((1 + $_->[$defaultValueCol]) / 2));
    }
  }
  if (($_->[$outputNameCol] eq "USE_PSO") && ($_->[$specifiedValueCol] == 1)) {
    $pso_flow = 1;
  }
}


if (($ispatial_flow == 1) && ($hier_flow_selector > 1)) {
  print "Error: The Genus iSpatial flow can only be used for top-down implementations. Bottom-up flows using\n";
  print "Error: ETMs or ILMs are not currently supported.\n";
  exit(1);
}
if (($mixed_height_lib == 1) && (($mh_short_height + $mh_tall_height) == 0)) {
  print "Error: If setting Lib_MixedHeightLibrary to 1, the specified values of Lib_MHShortCellHeight and Lib_MHTallCellHeight cannot remain at zero.\n";
  exit(1);
}
foreach (@varMatrix) {
  if ($_->[$outputNameCol] eq "CORE_BLOCK") {
    if ((defined $blockName) && ($blockName ne "")) {
      $_->[$specifiedValueCol] = $blockName;
    } elsif ($syn_mem_level == 1) {
	$_->[$specifiedValueCol] = "${core}";
    } else {
	$_->[$specifiedValueCol] = "${core}";
    }
  } elsif ($_->[$outputNameCol] eq "TOP_DESIGN") {
    if ((defined $topModule) && ($topModule ne "")) {
      $_->[$specifiedValueCol] = $topModule;
    }  elsif ($syn_mem_level == 1) {
	$_->[$specifiedValueCol] = "${core}";
    } else {
	$_->[$specifiedValueCol] = "${core}";
    }
  }
}
if (($specified_scan == 1) && ((($needs_tmode == 1) && ($has_tmode == 0)) || (($needs_cg_override == 1) && ($has_cg_override == 0)))) {
  print "Error: This configuration was not built with scan-ready RTL. The variable Syn_InsertScan cannot be set to 1 in CadSetup.file\n";
  exit(1);
}
if ($pso_flow == 1) {
  print "Error: This configuration was not built with a PCM module. The variable Syn_ImplementPSO cannot be set to 1 in CadSetup.file\n";
  exit(1);
}
if (($tech_lef_file eq "none") || ($user_defined_routing_layer eq "none")) {
  $min_routing_layer = "none";
  $max_routing_layer = "none";
} else {
  $tech_lef_file =~ s/{|}//g;
  $tech_lef_file =~ s/,/ /g;
  my @lef_file_array = split(/\s+/, $tech_lef_file);
  $tech_lef_file = $lef_file_array[0];
  if (-r $tech_lef_file) {
    my @MetalArray = ();
    my $MetalName = "";
    open(LEFFILE, "<$tech_lef_file") or die ("Cannot open $tech_lef_file");
    while (<LEFFILE>) {
      if ($_ =~ /^LAYER\s+(\S+)/i) {
	$MetalName = $1;
	until ($_ =~ /^END/i) {
	  $_ = <LEFFILE>;
	  if ($_ =~ /^\s*TYPE\s+ROUTING/i) {
	    push @MetalArray, $MetalName;
	  }
	}
      }
    }
    close(LEFFILE);
    $min_routing_layer = $MetalArray[0];
    $max_routing_layer = $MetalArray[$user_defined_routing_layer - 1];
  } else {
    $min_routing_layer = "none";
    $max_routing_layer = "none";
  }
}

################################################################################
# overwrite certain variables when using Target_FlowGoal                       #
################################################################################

unless ($sfg eq "None") {
  print "Warning: Target_FlowGoal set to \"$sfg\"; certain CadSetup.file values will be overridden\n";
  foreach (@varMatrix) {
    my $cur_val = $_->[$specifiedValueCol];
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?    "0.5" : (($sfg eq "Balanced") ? $cur_val : (($sfg eq "Fmax_PLE") ? $cur_val : (($sfg eq "Fmax_iSpatial") ? $cur_val : (($sfg eq "RTL_Comp") ? $cur_val : $cur_val)))) if ($_->[$outputNameCol] eq "MAX_DATA_TRANSITION");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?    "0.5" : (($sfg eq "Balanced") ? $cur_val : (($sfg eq "Fmax_PLE") ? $cur_val : (($sfg eq "Fmax_iSpatial") ? $cur_val : (($sfg eq "RTL_Comp") ? $cur_val : $cur_val)))) if ($_->[$outputNameCol] eq "MAX_CLOCK_TRANSITION");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "1" : (($sfg eq "Balanced") ?      "1" : (($sfg eq "Fmax_PLE") ?      "0" : (($sfg eq "Fmax_iSpatial") ?      "0" : (($sfg eq "RTL_Comp") ?      "1" : $cur_val)))) if ($_->[$outputNameCol] eq "LOW_POWER_FLOW");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "5" : (($sfg eq "Balanced") ?      "4" : (($sfg eq "Fmax_PLE") ? $cur_val : (($sfg eq "Fmax_iSpatial") ? $cur_val : (($sfg eq "RTL_Comp") ?      "4" : $cur_val)))) if ($_->[$outputNameCol] eq "LOW_POWER_GOAL");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?    "0.5" : (($sfg eq "Balanced") ?    "0.9" : (($sfg eq "Fmax_PLE") ? $cur_val : (($sfg eq "Fmax_iSpatial") ? $cur_val : (($sfg eq "RTL_Comp") ?    "0.5" : $cur_val)))) if ($_->[$outputNameCol] eq "LOW_POWER_LDR");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "1" : (($sfg eq "Balanced") ?      "1" : (($sfg eq "Fmax_PLE") ?      "0" : (($sfg eq "Fmax_iSpatial") ?      "0" : (($sfg eq "RTL_Comp") ?      "0" : $cur_val)))) if ($_->[$outputNameCol] eq "USE_POWER_LIBRARY");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "1" : (($sfg eq "Balanced") ?      "1" : (($sfg eq "Fmax_PLE") ?      "0" : (($sfg eq "Fmax_iSpatial") ?      "0" : (($sfg eq "RTL_Comp") ?      "0" : $cur_val)))) if ($_->[$outputNameCol] eq "USE_MULTIBIT_CELLS");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "1" : (($sfg eq "Balanced") ?      "1" : (($sfg eq "Fmax_PLE") ?      "1" : (($sfg eq "Fmax_iSpatial") ?      "1" : (($sfg eq "RTL_Comp") ?      "1" : $cur_val)))) if ($_->[$outputNameCol] eq "USE_ADVANCED_FEATURES");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?    "0.0" : (($sfg eq "Balanced") ?    "0.1" : (($sfg eq "Fmax_PLE") ?   "0.15" : (($sfg eq "Fmax_iSpatial") ?   "0.15" : (($sfg eq "RTL_Comp") ?   "0.15" : $cur_val)))) if ($_->[$outputNameCol] eq "GENUS_SYNTH_UNCERTAINTY");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "0" : (($sfg eq "Balanced") ?      "0" : (($sfg eq "Fmax_PLE") ?      "0" : (($sfg eq "Fmax_iSpatial") ?      "1" : (($sfg eq "RTL_Comp") ?      "1" : $cur_val)))) if ($_->[$outputNameCol] eq "GENUS_USE_ISPATIAL");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "1" : (($sfg eq "Balanced") ?      "1" : (($sfg eq "Fmax_PLE") ?      "1" : (($sfg eq "Fmax_iSpatial") ?      "1" : (($sfg eq "RTL_Comp") ?      "1" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_CcoptUsefulSkewEnabled");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "0" : (($sfg eq "Balanced") ?      "1" : (($sfg eq "Fmax_PLE") ?      "1" : (($sfg eq "Fmax_iSpatial") ?      "1" : (($sfg eq "RTL_Comp") ?      "1" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_ClockShieldingEnabled");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?    "0.0" : (($sfg eq "Balanced") ?    "0.1" : (($sfg eq "Fmax_PLE") ?   "0.15" : (($sfg eq "Fmax_iSpatial") ?   "0.15" : (($sfg eq "RTL_Comp") ?   "0.15" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_PreCTSUncertainty");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?   "1.18" : (($sfg eq "Balanced") ?   "1.18" : (($sfg eq "Fmax_PLE") ?   "1.18" : (($sfg eq "Fmax_iSpatial") ?   "1.18" : (($sfg eq "RTL_Comp") ?   "1.18" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_InsertionDelayFactor");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?   "0.12" : (($sfg eq "Balanced") ?   "0.12" : (($sfg eq "Fmax_PLE") ?   "0.12" : (($sfg eq "Fmax_iSpatial") ?   "0.12" : (($sfg eq "RTL_Comp") ?   "0.12" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_MaxAllowedDelay");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ? $cur_val : (($sfg eq "Balanced") ? $cur_val : (($sfg eq "Fmax_PLE") ? $cur_val : (($sfg eq "Fmax_iSpatial") ? $cur_val : (($sfg eq "RTL_Comp") ?      "0" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_WFP");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ? $cur_val : (($sfg eq "Balanced") ? $cur_val : (($sfg eq "Fmax_PLE") ? $cur_val : (($sfg eq "Fmax_iSpatial") ? $cur_val : (($sfg eq "RTL_Comp") ?      "0" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_DerateMethod");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "0" : (($sfg eq "Balanced") ?      "0" : (($sfg eq "Fmax_PLE") ?      "0" : (($sfg eq "Fmax_iSpatial") ?      "0" : (($sfg eq "RTL_Comp") ?      "0" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_UseiSpatialDB");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "0" : (($sfg eq "Balanced") ?      "0" : (($sfg eq "Fmax_PLE") ?      "1" : (($sfg eq "Fmax_iSpatial") ?      "1" : (($sfg eq "RTL_Comp") ?      "0" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_ExtremeFlow");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "1" : (($sfg eq "Balanced") ?      "1" : (($sfg eq "Fmax_PLE") ?      "0" : (($sfg eq "Fmax_iSpatial") ?      "0" : (($sfg eq "RTL_Comp") ?      "0" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_MinAreaFlow");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ?      "0" : (($sfg eq "Balanced") ?      "0" : (($sfg eq "Fmax_PLE") ?      "0" : (($sfg eq "Fmax_iSpatial") ?      "1" : (($sfg eq "RTL_Comp") ?      "1" : $cur_val)))) if ($_->[$outputNameCol] eq "Innovus_EarlyClockFlow");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ? $cur_val : (($sfg eq "Balanced") ? $cur_val : (($sfg eq "Fmax_PLE") ? $cur_val : (($sfg eq "Fmax_iSpatial") ? $cur_val : (($sfg eq "RTL_Comp") ?      "0" : $cur_val)))) if ($_->[$outputNameCol] eq "TEMPUS_WFP");
    $_->[$specifiedValueCol] = ($sfg eq "LowPower") ? $cur_val : (($sfg eq "Balanced") ? $cur_val : (($sfg eq "Fmax_PLE") ? $cur_val : (($sfg eq "Fmax_iSpatial") ? $cur_val : (($sfg eq "RTL_Comp") ?      "0" : $cur_val)))) if ($_->[$outputNameCol] eq "TEMPUS_SI");
  }
}

################################################################################
# write out errTable entries                                                   #
################################################################################
if (scalar(@errTable) > 0) {
  print "================================= $inputFile =================================\n";
  foreach (@{$errTable}) {
    print join ": ", @{$_};
  }
}

if ($low_power_flow && ($specified_ldr > 1)) {
  print "Error: Cannot have Target_LowPowerLDR set above 1; this floating-point number must be between 0 and 1 inclusive.\n";
  exit(1);
}

################################################################################
# generate the output file                                                     #
################################################################################
my @OutputArray = ();
my $format_var = "";
if ($verify_tempus) {
  foreach (@varMatrix) {
    if (($_->[$TOOLNameCol] =~ /_0_/) || ($_->[$TOOLNameCol] =~ /_6_/)) {
      if (! defined ($_->[$specifiedValueCol])) {
        $_->[$specifiedValueCol] = $_->[$defaultValueCol];
        print "Warning: No value specified for $_->[0] variable - setting default value of $_->[$defaultValueCol] instead\n" unless ($_->[$HiddenCol] == 1);
      }
      if (($_->[$specifiedValueCol] =~ /<.*/) || ($_->[$specifiedValueCol] !~ /$_->[$allowedValueCol]/)) {
        print "Error: Specified value for $_->[0] in CadSetup.file is not of correct type (pos int, float, string, etc.) or is not an allowed value (out of range, etc.) - read comments above variable\n";
        $found_error = 1;
      } else {
        &path_check($_->[$CheckCol]);
        $format_var = "set " . $_->[$outputNameCol] . " " . $_->[$specifiedValueCol];
        push @OutputArray, $format_var;
      }
    }
  }
  if ($tso) {
    push @OutputArray, "set TSO_FLOW 1";
  } else {
    push @OutputArray, "set TSO_FLOW 0";
  }
  push @OutputArray, "set INTERNAL_PATH_GROUP 0";
  push @OutputArray, "set USE_SPEF 1";
  push @OutputArray, "set USE_SDF 0";
  push @OutputArray, "set PROPAGATED_CLOCK 1";
  push @OutputArray, "set CLK_PORT @CLK_PORT";
  push @OutputArray, "set CLK_FREQ @CLK_FREQ";
  push @OutputArray, "set RST_PORT @RST_PORT";
  push @OutputArray, "set RST_ACTIVE @RST_ACTIVE";
  if ($JTAG_CLK_PORT ne "") { push @OutputArray, "set JTAG_CLK_PORT $JTAG_CLK_PORT"; } else { push @OutputArray, "set JTAG_CLK_PORT ''"; }
  if ($JTAG_CLK_FREQ ne "") { push @OutputArray, "set JTAG_CLK_FREQ $JTAG_CLK_FREQ"; } else { push @OutputArray, "set JTAG_CLK_FREQ ''"; }
  if ($JTAG_RST_PORT ne "") { push @OutputArray, "set JTAG_RST_PORT $JTAG_RST_PORT"; } else { push @OutputArray, "set JTAG_RST_PORT ''"; }
  if ($TESTMODE ne "") { push @OutputArray, "set TESTMODE $TESTMODE"; } else { push @OutputArray, "set TESTMODE ''"; }
  if ($TESTMODE_OVERRIDE ne "") { push @OutputArray, "set TESTMODE_OVERRIDE $TESTMODE_OVERRIDE"; } else { push @OutputArray, "set TESTMODE_OVERRIDE ''"; }
} elsif ($innovus) {
  foreach (@varMatrix) {
    if (($_->[$TOOLNameCol] =~ /_0_/) || ($_->[$TOOLNameCol]  =~ /_4_/)) {
      if (! defined ($_->[$specifiedValueCol])) {
	$_->[$specifiedValueCol] = $_->[$defaultValueCol];
	print "Warning: No value specified for $_->[0] variable - setting default value of $_->[$defaultValueCol] instead\n" unless ($_->[$HiddenCol] == 1);
      }
      if (($_->[$specifiedValueCol] =~ /<.*/) || ($_->[$specifiedValueCol] !~ /$_->[$allowedValueCol]/)) {
	print "Error: Specified value for $_->[0] in CadSetup.file is not of correct type (pos int, float, string, etc.) or is not an allowed value (out of range, etc.) - read comments above variable\n";
	$found_error = 1;
      } else {
	&path_check($_->[$CheckCol]);
	$format_var = "set " . $_->[$outputNameCol] . " \"" . $_->[$specifiedValueCol] . "\"";
	push @OutputArray, $format_var;
      }
    }
  }
  push @OutputArray, "set CLK_PORT @CLK_PORT";
  push @OutputArray, "set CLK_FREQ @CLK_FREQ";
  push @OutputArray, "set RST_PORT @RST_PORT";
  push @OutputArray, "set RST_ACTIVE @RST_ACTIVE";
  if ($JTAG_CLK_PORT ne "") { push @OutputArray, "set JTAG_CLK_PORT $JTAG_CLK_PORT"; } else { push @OutputArray, "set JTAG_CLK_PORT ''"; }
  if ($JTAG_CLK_FREQ ne "") { push @OutputArray, "set JTAG_CLK_FREQ $JTAG_CLK_FREQ"; } else { push @OutputArray, "set JTAG_CLK_FREQ ''"; }
  if ($JTAG_RST_PORT ne "") { push @OutputArray, "set JTAG_RST_PORT $JTAG_RST_PORT"; } else { push @OutputArray, "set JTAG_RST_PORT ''"; }
  if ($TESTMODE ne "") { push @OutputArray, "set TESTMODE $TESTMODE"; } else { push @OutputArray, "set TESTMODE ''"; }
  if ($TESTMODE_OVERRIDE ne "") { push @OutputArray, "set TESTMODE_OVERRIDE $TESTMODE_OVERRIDE"; } else { push @OutputArray, "set TESTMODE_OVERRIDE ''"; }
} elsif ($extract) {
  my $file_prefix = "";
  $file_prefix = "${core}";
  foreach (@varMatrix) {
    if ($_->[$TOOLNameCol]  =~ /_9_/) {
      if (! defined ($_->[$specifiedValueCol])) {
        $_->[$specifiedValueCol] = $_->[$defaultValueCol];
        print "Warning: No value specified for $_->[0] variable - setting default value of $_->[$defaultValueCol] instead\n" unless ($_->[$HiddenCol] == 1);
      }
      if (($_->[$specifiedValueCol] =~ /<.*/) || ($_->[$specifiedValueCol] !~ /$_->[$allowedValueCol]/)) {
        print "Error: Specified value for $_->[0] in CadSetup.file is not of correct type (pos int, float, string, etc.) or is not an allowed value (out of range, etc.) - read comments above variable\n";
        $found_error = 1;
      } else {

        &path_check($_->[$CheckCol]);
        $format_var = "set " . $_->[$outputNameCol] . " " . $_->[$specifiedValueCol];
        push @OutputArray, $format_var;

        if ($_->[$outputNameCol] eq "QRC_LayerMappingFile") {
            &path_check($_->[$CheckCol]);
          }
	if ($_->[$outputNameCol] eq "QRC_CmdFile") {
	  if ($_->[$specifiedValueCol] eq "default") {
            mkpath ("./extract_qrc") unless -d "./extract_qrc";
          }
          else {
	    &path_check($_->[$CheckCol]);
	    unless ($found_error) {
            mkpath ("./extract_qrc") unless -d "./extract_qrc";
	    system ("cp -fp $_->[$specifiedValueCol] extract_qrc/${file_prefix}_extract.cmd");
	    }
	  }
	}
      }
    }
  }
} else {
  my ($filename,$dirname,$suffix) = fileparse($outputFile);
  my $search_string = "_0_";
  my $pso_check_type = "";
  my $add_extra_vars = 1;
  if ($filename =~ /^Genus_/) {
    $search_string = "_0_|_7_";
    $pso_check_type = "genus";
  } elsif ($filename =~ /^Voltus_/) {
    $search_string = "_0_|_3_";
    $add_extra_vars = 0;
  }
  foreach (@varMatrix) {
    if ($_->[$TOOLNameCol] =~ /$search_string/) {
      if (! defined ($_->[$specifiedValueCol])) {
	$_->[$specifiedValueCol] = $_->[$defaultValueCol];
	print "Warning: No value specified for $_->[0] variable - setting default value of $_->[$defaultValueCol] instead\n" unless ($_->[$HiddenCol] == 1);
      }
      if (($_->[$specifiedValueCol] =~ /<.*/) || ($_->[$specifiedValueCol] !~ /$_->[$allowedValueCol]/)) {
	print "Error: Specified value for $_->[0] in CadSetup.file is not of correct type (pos int, float, string, etc.) or is not an allowed value (out of range, etc.) - read comments above variable\n";
	$found_error = 1;
      } else {
	&path_check($_->[$CheckCol]);
	$format_var = "set " . $_->[$outputNameCol] . " " . $_->[$specifiedValueCol];
	push @OutputArray, $format_var;
      }
    }
  }
  if ($add_extra_vars == 1) {
    push @OutputArray, "set MAX_PLACEMENT_DENSITY $max_density";
    push @OutputArray, "set MAX_ROUTING_LAYER $max_routing_layer";
    push @OutputArray, "set MIN_ROUTING_LAYER $min_routing_layer";
  }
  push @OutputArray, "set CLK_PORT @CLK_PORT";
  push @OutputArray, "set CLK_FREQ @CLK_FREQ";
  push @OutputArray, "set RST_PORT @RST_PORT";
  push @OutputArray, "set RST_ACTIVE @RST_ACTIVE";
  if ($JTAG_CLK_PORT ne "") { push @OutputArray, "set JTAG_CLK_PORT $JTAG_CLK_PORT"; } else { push @OutputArray, "set JTAG_CLK_PORT ''"; }
  if ($JTAG_CLK_FREQ ne "") { push @OutputArray, "set JTAG_CLK_FREQ $JTAG_CLK_FREQ"; } else { push @OutputArray, "set JTAG_CLK_FREQ ''"; }
  if ($JTAG_RST_PORT ne "") { push @OutputArray, "set JTAG_RST_PORT $JTAG_RST_PORT"; } else { push @OutputArray, "set JTAG_RST_PORT ''"; }
  if ($TESTMODE ne "") { push @OutputArray, "set TESTMODE $TESTMODE"; } else { push @OutputArray, "set TESTMODE ''"; }
  if ($TESTMODE_OVERRIDE ne "") { push @OutputArray, "set TESTMODE_OVERRIDE $TESTMODE_OVERRIDE"; } else { push @OutputArray, "set TESTMODE_OVERRIDE ''"; }
}

if ($found_error) {
  print "Error: Please correct above variables before proceeding. The following file will not be generated: $outputFile\n";
  exit(1);
} else {
   {
    my $fout;
    my ($filename,$dirname,$suffix) = fileparse($outputFile);
    mkpath ($dirname) unless -d $dirname;
    $fout = new FileHandle ($outputFile, '>');
    die "$0: $! - Can't open $outputFile" unless defined $fout;
    foreach my $outvar (@OutputArray) {
      print $fout "$outvar\n";
    }
  }
}

################################################################################
# utilities                                                                    #
################################################################################
sub path_check {
  my ($check_type) = @_;
  die "Invalid check type: check column value can only be 0, 1, or 2" unless ($check_type =~ /^[0|1|2]$/);
  return if ($check_type == 0);
  my $temp_value = $_->[$specifiedValueCol];
  $temp_value =~ s/\s*}//g;
  $temp_value =~ s/{\s*//g;
  $temp_value =~ s/,/ /g;
  my @tmp_files = split(/\s+/, $temp_value);
  my $input_variable = $_->[0];
  if ($check_type == 1) {
    if (scalar(@tmp_files) == 0) {
      print "Error: The $input_variable variable cannot be left empty for this implementation step\n";
      $found_error = 1;
    }
  }
  foreach (@tmp_files) {
    if (-e $_) {
      next;
    } else {
      print "Error: The following file/directory doesn't exist: \"$_\". Specify a valid value for ${input_variable}\n";
      $found_error = 1;
    }
  }
}


