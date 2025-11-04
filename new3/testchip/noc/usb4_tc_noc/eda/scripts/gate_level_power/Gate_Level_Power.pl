#!/usr/bin/env perl

# +---------------------------------------------------------------------------------------------+
# |          Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        |
# |   These coded instructions, statements, and computer programs are the                       |
# |   copyrighted works and confidential proprietary information of Cadence Design Systems Inc. |
# |   They may not be modified, copied, reproduced, distributed, or disclosed to                |
# |   third parties in any manner, medium, or form, in whole or in part, without                |
# |   the prior written consent of Cadence Design Systems Inc.                                  |
# +---------------------------------------------------------------------------------------------+

###############################################################################################
## Disclaimer : This EDA Flow is going through internal review process and subject to change  #
###############################################################################################

use File::Spec::Functions qw(:ALL);
use FileHandle;
use Getopt::Long;
use File::Path;
use File::Copy;
use File::Basename;
use List::MoreUtils qw(uniq);
use List::Util qw(max);
use FindBin qw($RealBin);
use Cwd;
use Env qw(CDN_VOLTUS_ROOT);
require "$RealBin/PowerUtils.pm";

#################################################################################
# parse command line options and generate diag test list			#
#################################################################################

my $core = "";
if (defined $ENV{'DESIGN'}) {
   $core = "$ENV{'DESIGN'}";
} else {
  print "Error: DESIGN is not set in env_design.sh. Specify the top module name.\n";
  exit(1);
}
$help = 0;
$ret;
my $curDir = cwd();
$ScriptDir = "$RealBin";
$AutoDir = "$RealBin/../automation";
$TopDir = "$curDir";
$DefaultNetlist = "$RealBin/../../layout_innovus/${core}_routed.v";
$MemMacroDefaultNetlist = "$RealBin/../../layout_innovus/${core}_routed.v";
$ConcatenatedOutputFile = "PowAnaOut.concat";
$PowerTable = "PowerTable.txt";
my $mp_core_count = 1;

parseCommandLine();
my $use_xtream = optionOn('use_xtream');
my $joules_rtl = 0;
my $use_joules = 0;
my $use_voltus;
if (($use_joules  + $joules_rtl ) > 0) {
  $use_voltus = 0;
} else {
  $use_voltus = 1;
}
if($use_xtream == 0 && $joules_rtl == 0 ) {
  my $default_results_dir = "sim_results_gate";
  my $default_opcond = "typical";
  my $default_sig_digits = 5;

  $hierarchical = optionOn('hierarchical');

  my $CadSetupFile = optionOn('csf') ? rel2abs(getOption('csf')) : "$RealBin/../../CadSetup.file";
  die ("$CadSetupFile is not readable\n") unless (-r $CadSetupFile);
  my $resultsDir = optionOn('rundir') ? rel2abs(getOption('rundir')) : catdir($curDir, $default_results_dir);
  die ("$resultsDir does not exist\n") unless ((-e $resultsDir) || optionOn('statistical'));
  my $opcond = optionOn('opcond') ? getOption('opcond') : $default_opcond;
  unless (($opcond eq "typical") || ($opcond eq "slow") || ($opcond eq "fast")) {
    die "Error: -opcond value can only be either \"typical\" or \"slow\" or \"fast\".\n";
  }

  $sig_digit = optionOn('significant_digits') ? getOption('significant_digits') : $default_sig_digits;
  $tot_digit = $sig_digit + 1;
  if ($sig_digit < 0) {
    die "Error: -significant_digits cannot have a negative value.\n";
  } elsif ($sig_digit > 15) {
    die "Error: please specify a value of -significant_digits between 0 and 15.\n";
  }
  
  my ($ProgFile, $ProgName);
  if (optionOn('prog')) {
    $ProgFile = rel2abs(getOption('prog'));
    die ("$ProgFile does not exist\n") unless (-e $ProgFile);
    $ProgName = "prog/" . basename($ProgFile);
  }

  my @test_list;
  unless (optionOn('statistical')) {
    @test_list = $ProgName if (optionOn('prog'));
    @test_list = (getOption('test')) if (optionOn('test'));
    @test_list = map(parseTestList($_), @{getOption('testlist')}) if (optionOn('testlist'));
    #@test_list = expandTestList($resultsDir, @test_list);
  }
  
  my $scope = "$core";
  $scope = getOption('scope');
  #################################################################################
  # parse CadSetup.file and perform flow option error checking			#
  #################################################################################
  
  my $use_memory_macros = 0;
  my $target_freq = 1000.0;
  my $csf_pso = 0;
  my $wc_lib_list = "_none_";
  my $typical_lib_list = "_none_";
  my $fast_lib_list = "_none_";
  my $slow_opcond = "_none_";
  my $typical_opcond = "_none_";
  my $fast_opcond = "_none_";
  my $thread_count = 1;
  open(CADFILE,"<$CadSetupFile") or die ("Cannot open $CadSetupFile");
  while(<CADFILE>) {
    if ($_ =~ /^\s*Syn_UseMemoryMacros\s+(\S+)/) {
      $use_memory_macros = $1;
    } elsif ($_ =~ /^\s*Syn_ImplementPSO\s+(\S+)/) {
      $csf_pso = $1;
    } elsif ($_ =~ /^\s*Lib_CadenceLIB\s+(.*)$/) {
      $wc_lib_list = $1;
    } elsif ($_ =~ /^\s*Lib_CadenceTypLIB\s+(.*)$/) {
      $typical_lib_list = $1;
    } elsif ($_ =~ /^\s*Lib_CadenceMinLIB\s+(.*)$/) {
      $fast_lib_list = $1;
    } elsif ($_ =~ /^\s*Lib_OperatingCondition\s+(\S+)/) {
      $slow_opcond = $1;
    } elsif ($_ =~ /^\s*Lib_TypOperatingCondition\s+(\S+)/) {
      $typical_opcond = $1;
    } elsif ($_ =~ /^\s*Lib_MinOperatingCondition\s+(\S+)/) {
      $fast_opcond = $1;
    } elsif ($_ =~ /^\s*Syn_SuperthreadCount\s+(\S+)/) {
      $thread_count = $1;
    } 
  }
  close(CADFILE);

  my @freq;
  if (defined $ENV{'CLK_FREQ'}) {
    my $CLK_FREQ = "$ENV{'CLK_FREQ'}";
    $CLK_FREQ =~ s/{//;
    $CLK_FREQ =~ s/ }//;
    my @CLK_FREQ_ar = split(' ', $CLK_FREQ);
    foreach $x (@CLK_FREQ_ar) {
      push(@freq, int($x));
    }
  }
  $target_freq = max @freq;

  $design = "${core}";

  if (optionOn('statistical') && (optionOn('prog') || optionOn('test') || optionOn('testlist') || optionOn('rundir'))) {
    print "Error: Can either run statistical or simulation based analysis, but not both.\n";
    exit;
  } elsif ((optionOn('test') + optionOn('testlist') + optionOn('prog')) > 1) {
    print "Error: Only one of \"-test\", \"-testlist\", or \"-prog\" can be specified.\n";
    exit;
  } elsif (optionOn('setload') && optionOn('spef')) {
    print "Error: Only one of \"-setload\" or \"-spef\" can be specified.\n";
    exit;
  } elsif (($use_voltus == 1) && optionOn('setload')) {
    print "Error: Voltus cannot take in a set_load file; use a SPEF file instead.\n";
    exit;
  } elsif (($use_voltus == 1) && optionOff('spef')) {
    print "Error: Voltus requires a SPEF file for accurate power analysis.\n";
    exit;
  } elsif (($use_voltus == 1) && optionOn('statistical')) {
    print "Error: This Voltus flow does not support statistical power analysis; specify a diag/prog instead.\n";
    exit;
  } elsif (($use_voltus == 1) && optionOff('vcd') && (! -e "$CDN_VOLTUS_ROOT/bin/voltus")) {
    print "Error: When using Voltus with SAIF input, the Voltus installation path must be specified with the\n";
    print "Error: \$CDN_VOLTUS_ROOT environment variable in your shell prior to running this script.\n";
    exit;
  } elsif (($use_voltus != 1) && ($opcond eq "fast")) {
    print "Error: When using fast corner power analysis is only supported with Voltus\n";
    exit;
  } 
  if ((optionOn('statistical') + optionOn('test') + optionOn('testlist') + optionOn('prog')) == 0) {
    print "Warning: No diag, program, or statistical options were selected - running all diags in default diag.list file\n";
  }
  if (optionOff('setload') && optionOff('spef')) {
    print "Warning: Neither \"-setload\" nor \"-spef\" is specified - using WLM to annotate net capacitances.\n";
  }
  if (optionOn('power_format') && ($csf_pso == 0)) {
    print "Warning: The \"-power_format\" option has been specified, which implies that power-aware gate simulations have been performed.\n";
    print "Warning: However, the Syn_ImplementPSO variable in CadSetup.file is set to 0, implying that PSO capability was not inserted\n";
    print "Warning: into the netlist. Power analysis will continue, but make sure this is the intended behavior.\n";
  }
  if (optionOff('power_format') && ($csf_pso == 1)) {
    print "Warning: The Syn_ImplementPSO variable in CadSetup.file is set to 1, implying that PSO capability was inserted into the netlist.\n";
    print "Warning: However, the \"-power_format\" option has not be specified, which implies that the gate simulations are not power-aware.\n";
    print "Warning: Power analysis will continue, but make sure this is the intended behavior.\n";
  }

  chdir $TopDir;

  $ResultsDir = "$TopDir/gate_power_analysis";
  $ResultsDir = (getOption('resultsdir')) if (optionOn('resultsdir'));

  if (!(-d $ResultsDir)) {
    mkpath $ResultsDir;
  }

  chdir $ResultsDir;

  #################################################################################
  # generate constraint files, modify power format files if typical PVT corner	#
  # specified, check toggle files, pass environment variables to target tool	#
  #################################################################################
  
  if ($use_voltus == 1) {
    $tool = "voltus -no_gui -no_logv -overwrite -exitOnError -init";
    $AnalysisScript = "$ScriptDir/Voltus_gate_power_ana.tcl";
    system("$AutoDir/Core_define.pl -i $CadSetupFile -o Genus_generic_define.tcl") == 0 or die ("Cannot create Genus_generic_define.tcl");
  } elsif ($use_joules == 1) {
    $tool = "joules -file";
    $AnalysisScript = "$ScriptDir/Joules_gate_power_ana.tcl";
    system("$AutoDir/Core_define.pl -i $CadSetupFile -o Genus_generic_define.tcl") == 0 or die ("Cannot create Genus_generic_define.tcl");
  }

  my (@DiagStartTime,@DiagEndTime);
  my ($sim_monitor_time,$vcd_start_time,$vcd_end_time) = (0,0,10000000);
  $modified_resultsdir = $resultsDir;
  $modified_resultsdir =~ s/\//_/g;
  $SaifFileList = "";
  $OutputFileList = "";
  %ValidDiagHash = ();
  $DiagCounter = 0;
  $SimPeriod = "N/A";
  $SimFreq = "N/A";
  $ScaleMultiplier = 1;
  $Timescale = "ns";
  $SimLogfile = "irun_rtl.log";
  if (optionOn('statistical')) {
    $OutputFileList = $SaifFileList = "{statistical_analysis}";
    $ValidDiagHash{statistical_analysis} = 1;
    $ValidDiagHash{statistical_analysis}{freq} = sprintf("%.0f",(1.0 * $target_freq));
    $DiagCounter = 1;
    push @DiagStartTime, "statistical_analysis";
    push @DiagEndTime, "statistical_analysis";
  } else {
    foreach $diag (@test_list) {
      $saif_count =1;
      $TempDiagName =~ s/\//_/g;
      opendir(DIR, "$resultsDir/$diag");
      @toggle_file_paths = (($use_voltus == 1) && optionOn('vcd')) ? grep(/verilog\.vcd/,readdir(DIR)) : grep (/saif_gate_toggle_file/, readdir(DIR));
      closedir(DIR);
      foreach my $toggle_file_name (sort @toggle_file_paths) {
        if ($#toggle_file_paths > 0) { $TempDiagName = "${diag}_frame${saif_count}" ; $saif_count++;} else { $TempDiagName = "$diag" ;}
        $TempDiagName =~ s/\//_/g;
        $toggle_file_path = "$resultsDir/$diag/$toggle_file_name";
        if (-e "$toggle_file_path") {
          $SaifFileList = $SaifFileList . "," . "$toggle_file_path";
          $ValidDiagHash{$TempDiagName} = 1;
          $OutputFileList = $OutputFileList . "," . $TempDiagName;
          $DiagCounter++;
          if (-e "$resultsDir/$diag/irun.log") {
            $SimLogfile = "irun.log";
          } elsif (-e "$resultsDir/$diag/irun_rtl.log") {
            $SimLogfile = "irun_rtl.log";
          } elsif (-e "$resultsDir/$diag/mtiverilog.log") {
            $SimLogfile = "mtiverilog.log";
          } elsif (-e "$resultsDir/$diag/xrun.log") {
            $SimLogfile = "xrun.log";
          }
          $sim_monitor_time = "N/A";
          $vcd_start_time = "N/A";
          $vcd_end_time = "N/A";
          $SimPeriod = "N/A";
          $SimFreq = "N/A";
          $ScaleMultiplier = 1;
          $Timescale = "ns";
          if (-e "$resultsDir/$diag/$SimLogfile") {
            open(SIMFILE,"<$resultsDir/$diag/$SimLogfile") or die ("Cannot open $resultsDir/$diag/$SimLogfile");
              while(<SIMFILE>) {
                if ($_ =~ /Using\s+CLK\s+period\s+(\S+)/) {
       	          $SimPeriod = $1;
                } elsif ($_ =~ /\+clkPeriod=(\S+)/) {
                  $SimPeriod = $1;
       	        } elsif (($_ =~ /Time\s+scale\s+of\s+\S+\s+is\s+([0-9]+)(\S+)/) || ($_ =~ /^TimeScale\s+of\s+\S+\s+is\s+([0-9]+)\s+(\S+)/)) {
                  $ScaleMultiplier = $1;
       	          $Timescale = $2;
       	        } elsif ($_ =~ /Starting\s+VCD\s+dump\s+at\s+cycle\s+(\S+)/) {
       	          $vcd_start_time = $1;
       	        } elsif ($_ =~ /Stopping\s+VCD\s+dump\s+at\s+cycle\s+(\S+)/) {
       	          $vcd_end_time = $1;
       	        } elsif ($_ =~ /finish\s+called\s+at\s+cycle:\s+(\S+)/) {
       	          $sim_monitor_time = $1;
       	        } elsif ($_ =~ /Simulation\s+complete\s+via.*at\s+time\s+(\S+)/) {
       	          $sim_monitor_time = $1;
       	          $sim_monitor_time = sprintf("%.0f",($sim_monitor_time / $SimPeriod)) unless ($SimPeriod eq "N/A");
       	        } elsif ($_ =~ /finish\s+at\s+simulation\s+time\s+(\S+)/) {
       	          $sim_monitor_time = $1;
       	          $sim_monitor_time = sprintf("%.0f",($sim_monitor_time / ($SimPeriod * 1000))) unless ($SimPeriod eq "N/A");
       	        }
       	      }
       	      close(SIMFILE);
            }
            $vcd_start_time = 0 if ($vcd_start_time eq "N/A");
            $vcd_end_time = $sim_monitor_time if ($vcd_end_time eq "N/A");
            $vcd_end_time = 10000000 if ($sim_monitor_time eq "N/A");
            unless ($SimPeriod eq "N/A") {
      	      $ScaleMultiplier = convertTimeUnit($ScaleMultiplier,$Timescale);
      	      $SimFreq = 1000.0 / ($ScaleMultiplier * $SimPeriod);
      	      $SimFreq = ($SimFreq < 1) ? sprintf("%.3f",$SimFreq) : sprintf("%.0f",$SimFreq);
      	      $vcd_start_time = sprintf("%.0f",($vcd_start_time * $ScaleMultiplier * $SimPeriod));
      	      $vcd_end_time = sprintf("%.0f",($vcd_end_time * $ScaleMultiplier * $SimPeriod));
            }
            if (optionOn('power_start')) {
              $vcd_start_time = getOption('power_start'); print "vcd_start_time = $vcd_start_time ns\n";
            }
            if (optionOn('power_stop')) {
              $vcd_end_time = getOption('power_stop'); print "vcd_stop_time = $vcd_end_time ns\n";
            }
            push @DiagStartTime, $vcd_start_time;
            push @DiagEndTime, $vcd_end_time;
            $ValidDiagHash{$TempDiagName}{freq} = $SimFreq;
          } else {
            print "Cannot find $toggle_file_path - power simulation must be run first - skipping power analysis for this diag.\n";
          }
        }
      }
      $SaifFileList =~ s/^\s*,//;
      $SaifFileList = "{" . $SaifFileList . "}";
      if ($DiagCounter == 0) {
        print "Error: either no toggle files have been found or no diags were specified. Use -statistical flag if no simulation data is available.\n";
      exit;
    }
  }
  $SaifFileList =~ s/\s+//g;
  $SaifFileList =~ s/{|}//g;
  $SaifFileList =~ s/,/ /g;
  $OutputFileList =~ s/\s+//g;
  $OutputFileList =~ s/,/ /g;
  $OutputFileList =~ s/^\s+//;
  my $start_time_list = join (" ", map($_, @DiagStartTime));
  my $end_time_list = join (" ", map($_, @DiagEndTime));
  
  chdir $TopDir;
  $Netlist = optionOn('netlist') ? rel2abs(getOption('netlist')) : (($use_memory_macros == 1) ? $MemMacroDefaultNetlist : $DefaultNetlist);
  unless (-r $Netlist) {
    print "Error: $Netlist is not readable. Check to make sure that this is the correct name and path to your target netlist.\n";
    exit;
  }
  my $netlist_dir = dirname($Netlist);
  my $MacroList = "${netlist_dir}/${core}_syn.memory_macro_list";
  my $power_def;
  my @DEFArray = <$netlist_dir/${core}*.def>;
  foreach my $def (@DEFArray) {
    $power_def = $def unless (-l $def);
  }
  my ($slow_mp_block_sdc,$typ_mp_block_sdc,$mp_block_sdc,$mp_block_netlist) = ("_none_","_none_","_none_","_none_");
  my ($slow_mp_block_setload,$typ_mp_block_setload,$mp_block_setload,$mp_block_converted_setload) = ("_none_","_none_","_none_","_none_");
  my ($slow_mp_block_spef,$typ_mp_block_spef,$mp_block_spef) = ("_none_","_none_","_none_");
  if ( ($use_memory_macros == 1) && !(-r $MacroList)) {
    print "Error: $MacroList is not readable. This file should exist in the same directory as your specified netlist, since the CadSetup.file\n";
    print "Error: indicates that some form of synthesis with memory hard macros was performed.\n";
    exit;
  }
  my ($slow_SDCFile) = <${netlist_dir}/${core}*.sdc>;
  my ($typ_SDCFile) = <${netlist_dir}/${core}*.typ_sdc>;
  my $SDCFile = ($opcond eq "typical") ? ((-r $typ_SDCFile) ? $typ_SDCFile : $slow_SDCFile) : $slow_SDCFile;
  if ($use_voltus == 1) {
    if (-r $SDCFile) {
      system("cp -f $SDCFile $ResultsDir/design.sdc");
    } else {
      print "Error: The Voltus flow requires an SDC file to be present in the same directory as the specified netlist.\n";
      exit;
    }
  }
  $LoadFile = optionOn('setload') ? rel2abs(getOption('setload')) : "{}";
  if (($LoadFile ne "{}") && !(-r $LoadFile)) {
    print "Error: $LoadFile is not readable. Check to make sure that this is the correct name and path to your target set_load file.\n";
    exit;
  }
  $SPEFfile = optionOn('spef') ? rel2abs(getOption('spef')) : "{}";
  if (($SPEFfile ne "{}") && !(-r $SPEFfile)) {
    print "Error: $SPEFfile is not readable. Check to make sure that this is the correct name and path to your target SPEF file.\n";
    exit;
  }

my $using_upf_standard = 0;
my $pf_suffix = "cpf";
$PFfile = optionOn('power_format') ? rel2abs(getOption('power_format')) : "{}";
if ($PFfile ne "{}") {
  if (!(-r $PFfile)) {
    print "Error: $PFfile is not readable. Check to make sure that this is the correct name and path to your target CPF/UPF file.\n";
    exit;
  } else {
    open(INFILE,"<$PFfile") or die ("Cannot open $PFfile");
    while(<INFILE>) {
      if ($_ =~ /add_port_state/) {
	$using_upf_standard = 1;
	$pf_suffix = "upf";
	last;
      }
    }
    close(INFILE);
    system("cp -f $netlist_dir/*.sdc $ResultsDir/.");
  }
}
$wc_lib_list =~ s/{|}//g;
$wc_lib_list =~ s/,/ /g;
$typical_lib_list =~ s/{|}//g;
$typical_lib_list =~ s/,/ /g;
$fast_lib_list =~ s/{|}//g;
$fast_lib_list =~ s/,/ /g;
my @wc_lib_array = split(/\s+/,$wc_lib_list);
my @typ_lib_array = split(/\s+/,$typical_lib_list);
my @fast_lib_array = split(/\s+/,$fast_lib_list);
my $found_opcond = 0;
my $typ_voltage = 0;
my $typ_temperature = 0;
if (($PFfile ne "{}") && ($opcond eq "typical")) {
  foreach my $tl (@typ_lib_array) {
    my $loc_tl = rel2abs($tl);
    next unless (-r $loc_tl);
    if ($found_opcond == 0) {
      open(LIBFILE,"<$loc_tl") or die ("Cannot open $loc_tl");
      LIBLOOP: while(<LIBFILE>) {
	if (($_ =~ /^\s*operating_conditions/) && ($_ =~ /${typical_opcond}/)) {
	  until (($_ =~ /}/) || (eof)) {
	    $_ = <LIBFILE>;
	    if ($_ =~ /^\s*temperature\s*\:\s*(\S+)\s*;/) {
	      $typ_temperature = $1;
	    } elsif ($_ =~ /^\s*voltage\s*\:\s*(\S+)\s*;/) {
	      $typ_voltage = $1;
	    }
	  }
	  $found_opcond = 1;
	  last LIBLOOP;
	}
      }
      close(LIBFILE);
    }
  }
  open(INFILE,"<$PFfile") or die ("Cannot open $PFfile");
  open(OUTFILE,">$ResultsDir/modified_for_typical.${pf_suffix}") or die ("Cannot create $ResultsDir/modified_for_typical.${pf_suffix}");
  while(<INFILE>) {
    my $loc_line = $_;
    chomp($loc_line);
    if (($loc_line =~ /add_port_state/) && ($loc_line !~ /off/) && ($loc_line !~ /VSS_TOP/)) {
      $loc_line =~ s/state1\s+(\S+)\s*\}/state1 ${typ_voltage}\}/;
    }
    $loc_line =~ s/include\s+tech\.cpf$/include local_tech.cpf/;
    $loc_line =~ s/-temperature\s+-?[0-9]+/-temperature ${typ_temperature}/;
    if (($loc_line =~ /-voltage/) && ($loc_line !~ /-voltage\s+\{?\s*0\s*\}?\s*$/) && ($loc_line !~ /-voltage\s+\{?\s*0\s*\}?\s+\\/) && ($loc_line !~ /-voltage\s+0\.000/) && ($loc_line !~ /voltage\s+0\s+\-state\s+off/)) {
      $loc_line =~ s/-voltage\s+(-?[0-9]*\.?[0-9]+|-?[0-9]+\.?[0-9]*)/-voltage ${typ_voltage}/;
      $loc_line =~ s/-voltage\s+\{\s*\S+\s*\}/-voltage \{ ${typ_voltage} \}/;
    }
    $loc_line =~ s/-libraries\s+\{\s+.*\s+\}/-libraries \{ ${typical_lib_list} \}/;
    print OUTFILE "${loc_line}\n";
  }
  close(INFILE);
  close(OUTFILE);
  $PFfile = rel2abs("$ResultsDir/modified_for_typical.${pf_suffix}");
}
if (($PFfile ne "{}") && ($using_upf_standard == 1)) {
  my $dvl_file = "$RealBin/../../domain_voltage_list.tcl";
  die ("Cannot locate the necessary file $dvl_file to run UPF-based power analysis") unless (-r $dvl_file);
  if ($opcond eq "typical") {
    open(INFILE,"<$dvl_file") or die ("Cannot open $dvl_file");
    open(OUTFILE,">$ResultsDir/local_dvl.tcl") or die ("Cannot create $ResultsDir/local_dvl.tcl");
    while(<INFILE>) {
      my $loc_line = $_;
      chomp($loc_line);
      if ($loc_line !~ /VSS_TOP/) {
	$loc_line =~ s/set_voltage\s+\S+\s+/set_voltage ${typ_voltage} /;
      }
      print OUTFILE "${loc_line}\n";
    }
    close(INFILE);
    close(OUTFILE);
  } else {
   system("cp -f $dvl_file $ResultsDir/local_dvl.tcl");
  }
}
if (($PFfile ne "{}") && ($using_upf_standard == 0) && ($opcond eq "typical")) {
  my $tech_cpf = rel2abs("$RealBin/../../tech.cpf");
  die ("Cannot locate the necessary file $tech_cpf to run CPF-based power analysis") unless (-r $tech_cpf);
  open(INFILE,"<$tech_cpf") or die ("Cannot open $tech_cpf");
  open(OUTFILE,">$ResultsDir/local_tech.cpf") or die ("Cannot create $ResultsDir/local_tech.cpf");
  while(<INFILE>) {
    my $loc_line = $_;
    chomp($loc_line);
    $loc_line =~ s/-libraries\s+\{\s*.*\s*\}/-libraries \{ ${typical_lib_list} \}/;
    $loc_line =~ s/-voltage\s+\S+/-voltage ${typ_voltage}/;
    $loc_line =~ s/-temperature\s+\S+/-temperature ${typ_temperature}/;
    print OUTFILE "${loc_line}\n";
  }
  close(INFILE);
  close(OUTFILE);
}

chdir $ResultsDir;
my (@sdc_array) = <*sdc>;
my $sdc_count = scalar(@sdc_array);
if (($opcond eq "typical") && ($sdc_count > 0) && ($use_voltus == 1)) {
  if (scalar(@wc_lib_array) != scalar(@typ_lib_array)) {
    print "Error: To perform power analysis using Voltus at the typical operating corner, all Liberty libraries\n";
    print "Error: must be listed for both Lib_CadenceLIB and Lib_CadenceTypLIB in CadSetup.file. In addition,\n";
    print "Error: they must be listed in the same order for both variables.\n";
    exit;
  }
  my @wc_lib_names,@tc_lib_names;
  foreach my $wl (@wc_lib_array) {
    open(INFILE,"<$wl") or die ("Cannot open $wl");
    while(<INFILE>) {
      if ($_ =~ /^\s*library\s*\(\s*(\S+)\s*\)\s*\{\s*$/) {
	push @wc_lib_names, $1;
	last;
      }
    }
    close(INFILE);
  }
  foreach my $tl (@typ_lib_array) {
    open(INFILE,"<$tl") or die ("Cannot open $tl");
    while(<INFILE>) {
      if ($_ =~ /^\s*library\s*\(\s*(\S+)\s*\)\s*\{\s*$/) {
	push @tc_lib_names, $1;
	last;
      }
    }
    close(INFILE);
  }
  foreach my $sdc_file (@sdc_array) {
    my $typ_sdc = "typ_" . $sdc_file;
    open(INFILE,"<$sdc_file") or die ("Cannot open $sdc_file");
    open(OUTFILE,">$typ_sdc") or die ("Cannot create $typ_sdc");
    while(<INFILE>) {
      my $loc_line = $_;
      chomp($loc_line);
      for (my $index = 0; $index <= $#wc_lib_names; $index++) {
	$loc_line =~ s/$wc_lib_names[$index]/$tc_lib_names[$index]/g;
      }
      $loc_line =~ s/${slow_opcond}/${typical_opcond}/g;
      next if ($loc_line =~ /set_operating_conditions/);
      next if ($loc_line =~ /set_max_dynamic_power/);
      next if ($loc_line =~ /set_max_delay/);
      next if ($loc_line =~ /set_units/);
      print OUTFILE "${loc_line}\n";
    }
    close(INFILE);
    close(OUTFILE);
    system("mv -f $typ_sdc $sdc_file");
  }
}

if (($opcond eq "fast") && ($sdc_count > 0) && ($use_voltus == 1)) {
  if (scalar(@wc_lib_array) != scalar(@fast_lib_array)) {
    print "Error: To perform power analysis using Voltus at the fast operating corner, all Liberty libraries\n";
    print "Error: must be listed for both Lib_CadenceLIB and Lib_CadenceMinLIB in CadSetup.file. In addition,\n";
    print "Error: they must be listed in the same order for both variables.\n";
    exit;
  }
  my @wc_lib_names,@fast_lib_names;
  foreach my $wl (@wc_lib_array) {
    open(INFILE,"<$wl") or die ("Cannot open $wl");
    while(<INFILE>) {
      if ($_ =~ /^\s*library\s*\(\s*(\S+)\s*\)\s*\{\s*$/) {
	push @wc_lib_names, $1;
	last;
      }
    }
    close(INFILE);
  }
  foreach my $tl (@fast_lib_array) {
    open(INFILE,"<$tl") or die ("Cannot open $tl");
    while(<INFILE>) {
      if ($_ =~ /^\s*library\s*\(\s*(\S+)\s*\)\s*\{\s*$/) {
	push @fast_lib_names, $1;
	last;
      }
    }
    close(INFILE);
  }
  foreach my $sdc_file (@sdc_array) {
    my $fast_sdc = "fast_" . $sdc_file;
    open(INFILE,"<$sdc_file") or die ("Cannot open $sdc_file");
    open(OUTFILE,">$fast_sdc") or die ("Cannot create $fast_sdc");
    while(<INFILE>) {
      my $loc_line = $_;
      chomp($loc_line);
      for (my $index = 0; $index <= $#wc_lib_names; $index++) {
	$loc_line =~ s/$wc_lib_names[$index]/$fast_lib_names[$index]/g;
      }
      $loc_line =~ s/${slow_opcond}/${fast_opcond}/g;
      next if ($loc_line =~ /set_operating_conditions/);
      next if ($loc_line =~ /set_max_dynamic_power/);
      next if ($loc_line =~ /set_max_delay/);
      next if ($loc_line =~ /set_units/);
      print OUTFILE "${loc_line}\n";
    }
    close(INFILE);
    close(OUTFILE);
    system("mv -f $fast_sdc $sdc_file");
  }
}

$DoStatistical = optionOn('statistical');
$UseVCD = optionOn('vcd');
$PrintDetailedReports = optionOn('detailed');

if ($LoadFile eq "{}") {
  $ENV{POWER_SETLOAD} = "$LoadFile";
  $outLoadFile = $LoadFile;
} else {
  if (($opcond eq "typical") && (basename($LoadFile) !~ /typ/)) {
    print "\n\nWarning: This setload file does not contain the word \"typ\" in the filename, suggesting this is not a loadfile that\n";
    print "Warning: was generated with a typical-corner QRC techfile. For the selected library, it is suggested that you\n";
    print "Warning: report power using only a TC corner setload file.\n\n\n";
  }
  $outLoadFile = "setload_tcl_version";
  my $line = tclSetload($LoadFile,$outLoadFile,0);
  if ($line == 0) {
    $outLoadFile = $LoadFile;
  }
  $ENV{POWER_SETLOAD} = "$outLoadFile";
}
if (($opcond eq "typical") && ($SPEFfile ne "{}") && (basename($SPEFfile) !~ /typ/)) {
  print "\n\nWarning: This SPEF file does not contain the word \"typ\" in the filename, suggesting this is not a SPEF that\n";
  print "Warning: was generated with a typical-corner QRC techfile. For the selected library, it is suggested that you\n";
  print "Warning: report power using only a TC corner SPEF file.\n\n\n";
}
if (($opcond eq "fast") && ($SPEFfile ne "{}") && (basename($SPEFfile) !~ /min/)) {
  print "\n\nWarning: This SPEF file does not contain the word \"min\" in the filename, suggesting this is not a SPEF that\n";
  print "Warning: was generated with a min-corner QRC techfile. For the selected library, it is suggested that you\n";
  print "Warning: report power using only a TC corner SPEF file.\n\n\n";
}
$ENV{POWER_SPEF} = "$SPEFfile";
$ENV{POWER_NETLIST} = "$Netlist";
$ENV{POWER_DEF} = "$power_def";
$ENV{POWER_MACROS} = "$MacroList";
$ENV{ABSOLUTE_DIAG_PATHS} = "$SaifFileList";
$ENV{DIAG_START_TIMES} = "$start_time_list";
$ENV{DIAG_END_TIMES} = "$end_time_list";
$ENV{POWER_OUTPUT_FILE} =  "$ConcatenatedOutputFile";
$ENV{DO_STATISTICAL} = $DoStatistical;
$ENV{USE_TYPICAL_CORNER} = ($opcond eq "slow") ?  0 : (($opcond eq "fast") ? 2 : 1);
$ENV{FOR_HYBRID_FLOW} = 0;
$ENV{VCD_FLOW} = $UseVCD;
$ENV{UPF_GATE} = "$PFfile";
$ENV{GATE_SIM_PERIOD} = $SimPeriod;
$ENV{SCRIPT_DIR} = "$RealBin";
$ENV{CDNS_MULTITHREAD_COUNT} = $thread_count;

  my $DefineFile = "Genus_power_define.tcl";
  open(GENUSVARS,">$DefineFile") or die ("Cannot create $DefineFile");
  print GENUSVARS "set POWER_SETLOAD $outLoadFile\n";
  print GENUSVARS "set POWER_SPEF $SPEFfile\n";
  print GENUSVARS "set POWER_NETLIST $Netlist\n";
  if (-e $power_def) {
    print GENUSVARS "set POWER_DEF $power_def\n";
  }
  print GENUSVARS "set POWER_SDC design.sdc\n";
  print GENUSVARS "set POWER_MACROS $MacroList\n";
  print GENUSVARS "set ABSOLUTE_DIAG_PATHS {$SaifFileList}\n";
  print GENUSVARS "set DIAG_NAMES {$OutputFileList}\n";
  print GENUSVARS "set DIAG_START_TIMES {$start_time_list}\n";
  print GENUSVARS "set DIAG_END_TIMES {$end_time_list}\n";
  print GENUSVARS "set POWER_OUTPUT_FILE $ConcatenatedOutputFile\n";
  print GENUSVARS "set DO_STATISTICAL $DoStatistical\n";
  print GENUSVARS "set USE_VCD $UseVCD\n";

  print GENUSVARS "set SCOPE $scope\n";
  print GENUSVARS "set GATE_CPF_FILE $PFfile\n";
  print GENUSVARS "set SCRIPT_DIR $RealBin\n";
  print GENUSVARS "set DETAILED_REPORTS $PrintDetailedReports\n";
  print GENUSVARS "set RUN_ETM_FLOW 0\n";
  if( $use_voltus == 1) {
    if ($opcond eq "slow") {
      print GENUSVARS "set USE_CORNER \"SLOW\"\n";
    } elsif ($opcond eq "fast") {
      print GENUSVARS "set USE_CORNER \"FAST\"\n";
    } else {
      print GENUSVARS "set USE_CORNER \"TYPICAL\"\n";
    }
  } else {
    if ($opcond eq "slow") {
      print GENUSVARS "set USE_TYPICAL_CORNER 0\n";
    } else {
      print GENUSVARS "set USE_TYPICAL_CORNER 1\n";
    }
  }
  close(GENUSVARS);

#################################################################################
# launch off target tool to perform analysis, then clean up output files	#
#################################################################################

system("$tool $AnalysisScript");
system("rm -fr workdir default.svf *.log *.tcl *.sdc mw_design_lib alib-* *_port_map* *setload_tcl_version udul_default_fin* genus_fv genus.cmd *.aocv *.memory_macro_list modified_for_typical.${pf_suffix} local_dvl.txt local_tech.cpf libscore_work _default_* mp_data *stats_db voltus.cmd *.ptiavg *.ptifiles power.rpt *missing_net* *incomplete_res*");
}
if($use_xtream) {
  my $CadSetupFile = optionOn('csf') ? rel2abs(getOption('csf')) : "$RealBin/../../CadSetup.file";
  my @toggleFileList ;
  my @toggleFileDir ;
  
  $tool = "joules -file";
  $ResultsDir = "joules_results";
  $resultsDir = $TopDir."/Palladium/";
  $ResultsDir = (getOption('resultsdir')) if (optionOn('resultsdir'));
  $resultsDir = rel2abs(getOption('rundir')) if (optionOn('rundir'));
  $AnalysisScript = "$ScriptDir/../xtream/Joules_compile.tcl";
  $PalladiumSetup = "$resultsDir/PalladiumSetup.file";
  if(-e $PalladiumSetup)
  {
    open(PALLADIUM_SETUP,"$PalladiumSetup");
    $joules_tuning_factor = 1;
    $dump_cell_power = 0;
    $report_ideal_power = 0;
    $find_opt = 0;
    $path_to_dut = "N/A";
    while(<PALLADIUM_SETUP>)
    {
      if(/^joules_lvt_percentage\s*=\s*(\S+)/i)
      {
        $joules_lvt = $1;
        $joules_lvt =~ s/%//g;
	    $joules_svt = 100 - $joules_lvt;
      }
      if(/^tuning_factor\s*=\s*(\S+)/i)
      {
        $joules_tuning_factor = $1;
      }
      if(/^dump_cell_power\s*=\s*(\S+)/i)
      {
        $dump_cell_power = $1;
      }
      if(/^report_ideal_power\s*=\s*(\S+)/i)
      {
        $report_ideal_power = $1;
      }
      if(/^\s*CLKFREQ\s*=\s*(\S+)/)
      {
        $freq = $1/1000;
      }
      if(/^find_optimization_opportunity\s*=\s*(\S+)/i)
      {
        $find_opt = $1;
      }
      if(/^path_to_dut\s*=\s*(\S+)/i)
      {
        $path_to_dut = $1;
      }
    }
    close(PALLADIUM_SETUP);
  }
  else
  {
    print "Error: PalladiumSetup.file does not exist. Please specify directory consisting of PalladiumSetup.file with -rundir switch\n";
  }
  $xedebug = `which xeDebug`;
  chomp($xedebug);
  if($xedebug =~ /\S+/)
  {
    print "$xedebug xeDebug license found\n";
  }
  else
  {
    die "xeDebug license does not exist\n";
  }
  @pall_files = ("cellList","dbFiles","PDB","QTDB","xc_work",".design","trace1.phy");
  if (optionOn('testlist')) {
    @test_list = map(parseTestList($_), @{getOption('testlist')}) if (optionOn('testlist'));
    foreach $test (@test_list) {
      foreach $pall_file (@pall_files)
      {
	my $file = $resultsDir."/".$test."/$pall_file";
	if(-e $file) 
        {
	  $check_pall{$test}++;
        }
        else
        {
           $check_pall{$test} = 0;
        }
      }
    }
 } elsif (optionOn('test')) {
    @test_path =  getOption('test');
    foreach $test (@test_path) {
      foreach $pall_file (@pall_files)
      {
	my $file = $resultsDir."/".$test."/$pall_file";
	if(-e $file) 
        {
	  $check_pall{$test}++;
        }
        else
        {
           $check_pall{$test} = 0;
        }
      }
    }
 }
    foreach $test (keys %check_pall)
    {
      if($check_pall{$test} == 7)
      {
        $valid_tests++;
        $test =~ s/\/$|^\///g;
        opendir(DIR, "$resultsDir/$test");
        @toggle_file_paths = (grep (/phy/, readdir(DIR)));
        closedir(DIR);
	if ($#toggle_file_paths > 0) { # support for multiframe
	my $frame = 1;
        foreach my $toggle (@toggle_file_paths) {
          my $testTmp = "$test\_frame$frame";
          push (@valid_test,$testTmp);
          push (@toggleFileList, "$resultsDir/$test/$toggle");
          push (@toggleFileDir, "$resultsDir/$test");
          $frame ++;
	}
        }else { #single frame 
	  push (@valid_test,$test); 
          push (@toggleFileList, "$resultsDir/$test/@toggle_file_paths");
          push (@toggleFileDir, "$resultsDir/$test");
        }
      }
      else
      {
        print "Error: Input files are not found for $test at $resultsDir.\nPlease make sure $test has cellList,dbFiles,PDB,QTDB,xc_work,.design,trace.phy files.\nProceeding with other tests...\n";
      }
    }
  if($valid_tests < 1)
  {
    print "Note: No valid tests found. This flow will generate Joules DB only. Please provide valid test paths with trace.phy files if you need power information\n";
  }
  system("mkdir -p $ResultsDir");
  chdir $ResultsDir;
    open(JOULESVARS,">Joules_power_define.tcl");
    print JOULESVARS "set RUN_PALLADIUM 1\n";
    print JOULESVARS "set DIAGLIST { @valid_test }\n";
    print JOULESVARS "set TOGGLEFILE { @toggleFileList }\n";
    print JOULESVARS "set TOGGLEFILEDIR { @toggleFileDir }\n";
    print JOULESVARS "set TUNING_FACTOR $joules_tuning_factor\n";
    print JOULESVARS "set DUMP_CELL_POWER $dump_cell_power\n";
    print JOULESVARS "set REPORT_IDEAL_POWER $report_ideal_power\n";
    print JOULESVARS "set FIND_OPT  $find_opt\n";
    print JOULESVARS "set PATH_TO_DUT  $path_to_dut\n";
    if(defined($joules_lvt))
    {
      print JOULESVARS "set JOULES_LVT $joules_lvt\n";
      print JOULESVARS "set JOULES_SVT $joules_svt\n";
    }
  $superthreadcount = 1;
  $superthreadcount = `$AutoDir/Core_define.pl -i $CadSetupFile -show SUPERTHREAD_COUNT`;
  $ENV{CDNS_MULTITHREAD_COUNT} = $superthreadcount;
  system("$AutoDir/Core_define.pl -i $CadSetupFile -o Genus_generic_define.tcl");
  system("$tool $AnalysisScript > Joules_compile.log");
  $test_freq = $valid_test[0];
  foreach $test ( @valid_test ) {
    $test =~ s/\//_/g;
    my $power = "./$test.rpt";
    open(POWER,"$power");
    while(<POWER>) {
      if(/Category\s+Internal\s+Switching\s+/) { $check = 1; }
      elsif($check and /-----------/) { $start = 1; $check = 0;}
      elsif($start and /-----------/) { $start = 0;}
      elsif($start and /^\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
         my $category = $1;
         my $internal = $2;
         my $switching = $3;
         my $leakage = $4;
         $leakage{$test} += $4;
         $dyn{$test} += $2+$3;
         $powernum{$test}{$category}{i} = $internal;
         $powernum{$test}{$category}{s} = $switching;
         $powernum{$test}{$category}{l} = $leakage;
      }
    }
    close(POWER);
  }
  $SimFreq = "N/A";
  if (-e "$resultsDir/$test_freq/xe.msg") {
          open(SIMFILE,"<$resultsDir/$test_freq/xe.msg") or die ("Cannot open $resultsDir/$test_freq/xe.msg");
          while(<SIMFILE>) {
            if ($_ =~ /\s+\{\{(.*)?CLK\}\s+(\S+)/) {
              $SimFreq = $2;
            }
  	}
          close(SIMFILE);
        }
#  open(POWERSUM,">PowerTable.txt");
#  print POWERSUM "\t\t\tPower Analysis Summary Report Using Joules Tensilica Energy Analysis Flow\n";
#  print POWERSUM "\n";
#  print POWERSUM "\t\t\tNote: all power numbers are in mW\n";
#  print POWERSUM "\n";
#  print POWERSUM "Diag                           Frequency   Dyn Power     Leakage Power     Total Power\n";
#  print POWERSUM '-' x 120;
#  print POWERSUM "\n";
#  foreach $test (keys %leakage) {
#    $total = $dyn{$test}+$leakage{$test};
#    print POWERSUM "$test           $freq GHz   $dyn{$test}      $leakage{$test}    $total\n";
#  }
#  close(POWERSUM);
  chdir $TopDir;
}
if ($joules_rtl) {
  my $CadSetupFile = optionOn('csf') ? rel2abs(getOption('csf')) : "$RealBin/../../CadSetup.file";
  my @toggleFileList ;
  my @toggleFileDir ;
  
  $tool = "joules -file";
  $ResultsDir = "joules_results";
  $resultsDir = $TopDir."/sim_results/";
  $ResultsDir = (getOption('resultsdir')) if (optionOn('resultsdir'));
  $resultsDir = rel2abs(getOption('rundir')) if (optionOn('rundir'));
  $AnalysisScript = "$ScriptDir/../xtream/Joules_compile.tcl";
  $PalladiumSetup = "Palladium/PalladiumSetup.file";
  if(-e $PalladiumSetup)
  {
    open(PALLADIUM_SETUP,"$PalladiumSetup");
    $joules_tuning_factor = 1;
    $dump_cell_power = 0;
    $report_ideal_power = 0;
    $find_opt = 0;
    $path_to_dut = "N/A";
    while(<PALLADIUM_SETUP>)
    {
      if(/^joules_lvt_percentage\s*=\s*(\S+)/i)
      {
        $joules_lvt = $1;
        $joules_lvt =~ s/%//g;
	    $joules_svt = 100 - $joules_lvt;
      }
      if(/^tuning_factor\s*=\s*(\S+)/i)
      {
        $joules_tuning_factor = $1;
      }
      if(/^dump_cell_power\s*=\s*(\S+)/i)
      {
        $dump_cell_power = $1;
      }
      if(/^report_ideal_power\s*=\s*(\S+)/i)
      {
        $report_ideal_power = $1;
      }
      if(/^find_optimization_opportunity\s*=\s*(\S+)/i)
      {
        $find_opt = $1;
      }
      if(/^path_to_dut\s*=\s*(\S+)/i)
      {
        $path_to_dut = $1;
      }
    }
    close(PALLADIUM_SETUP);
  }
  else
  {
    print "Warning: PalladiumSetup.file does not exist. Joules tuningfactor will be default 1\n";
  }
  @sim_files = ("saif_toggle_file");
  if (optionOn('testlist')) {
    @test_list = map(parseTestList($_), @{getOption('testlist')}) if (optionOn('testlist'));
    foreach $test (@test_list) {
      foreach $sim_file (@sim_files)
      {
	my $file = $resultsDir."/".$test."/$sim_file";
	if(-e $file) 
        {
	  $check_sim{$test}++;
        }
        else
        {
           $check_sim{$test} = 0;
        }
      }
    }
 } elsif (optionOn('test')) {
    @test_path =  getOption('test');
    foreach $test (@test_path) {
      foreach $sim_file (@sim_files)
      {
	my $file = $resultsDir."/".$test."/$sim_file";
	if(-e $file) 
        {
	  $check_sim{$test}++;
        }
        else
        {
           $check_sim{$test} = 0;
        }
      }
    }
 }
    foreach $test (keys %check_sim)
    {
      if($check_sim{$test} == 1 )
      {
        $valid_tests++;
        $test =~ s/\/$|^\///g;
        opendir(DIR, "$resultsDir/$test");
        @toggle_file_paths = (grep (/saif_toggle_file/, readdir(DIR)));
        closedir(DIR);
	if ($#toggle_file_paths > 0) { # support for multiframe
	my $frame = 1;
        foreach my $toggle (@toggle_file_paths) {
          my $testTmp = "$test\_frame$frame";
          push (@valid_test,$testTmp);
          push (@toggleFileList, "$resultsDir/$test/$toggle");
          push (@toggleFileDir, "$resultsDir/$test");
          $frame ++;
	}
        }else { #single frame 
	  push (@valid_test,$test); 
          push (@toggleFileList, "$resultsDir/$test/@toggle_file_paths");
          push (@toggleFileDir, "$resultsDir/$test");
        }
      }
      else
      {
        print "Error: Input files are not found for $test at $resultsDir.\nPlease make sure $test has saif_toggle_file files.\nProceeding with other tests...\n";
      }
    }
  if($valid_tests < 1)
  {
    print "Note: No valid tests found. This flow will generate Joules DB only. Please provide valid test paths with saif_toggle_file files if you need power information\n";
  }
  system("mkdir -p $ResultsDir");
  chdir $ResultsDir;
    open(JOULESVARS,">Joules_power_define.tcl");
    print JOULESVARS "set RUN_PALLADIUM 0\n";
    print JOULESVARS "set DIAGLIST { @valid_test }\n";
    print JOULESVARS "set TOGGLEFILE { @toggleFileList }\n";
    print JOULESVARS "set TOGGLEFILEDIR { @toggleFileDir }\n";
    print JOULESVARS "set TUNING_FACTOR $joules_tuning_factor\n";
    print JOULESVARS "set DUMP_CELL_POWER $dump_cell_power\n";
    print JOULESVARS "set REPORT_IDEAL_POWER $report_ideal_power\n";
    print JOULESVARS "set FIND_OPT  $find_opt\n";
    print JOULESVARS "set PATH_TO_DUT  $path_to_dut\n";
    if(defined($joules_lvt))
    {
      print JOULESVARS "set JOULES_LVT $joules_lvt\n";
      print JOULESVARS "set JOULES_SVT $joules_svt\n";
    }
  $superthreadcount = 1;
  $superthreadcount = `$AutoDir/Core_define.pl -i $CadSetupFile -show SUPERTHREAD_COUNT`;
  $ENV{CDNS_MULTITHREAD_COUNT} = $superthreadcount;
  system("$AutoDir/Core_define.pl -i $CadSetupFile -o Genus_generic_define.tcl");
  system("$tool $AnalysisScript > Joules_compile.log");
  foreach $test ( @valid_test ) {
    $test =~ s/\//_/g;
    my $power = "./$test.rpt";
    open(POWER,"$power");
    while(<POWER>) {
      if(/Category\s+Internal\s+Switching\s+/) { $check = 1; }
      elsif($check and /-----------/) { $start = 1; $check = 0;}
      elsif($start and /-----------/) { $start = 0;}
      elsif($start and /^\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
	 my $category = $1;
	 my $internal = $2;
	 my $switching = $3;
	 my $leakage = $4;
	 $leakage{$test} += $4;
	 $dyn{$test} += $2+$3;
	 $powernum{$test}{$category}{i} = $internal;
	 $powernum{$test}{$category}{s} = $switching;
	 $powernum{$test}{$category}{l} = $leakage;
      }
    }
    close(POWER);
  }
$SimFreq = "N/A";
$SimLogfile = "irun.log";
$ScaleMultiplier = 1;
$Timescale = "ns";
foreach $diag (@test_list) {
      if (-e "$resultsDir/$diag/irun.log") {
        $SimLogfile = "irun.log";
      } elsif (-e "$resultsDir/$diag/irun_rtl.log") {
	$SimLogfile = "irun_rtl.log";
      } elsif (-e "$resultsDir/$diag/xrun.log") {
	$SimLogfile = "xrun.log";
      }
if (-e "$resultsDir/$diag/$SimLogfile") {
	open(SIMFILE,"<$resultsDir/$diag/$SimLogfile") or die ("Cannot open $resultsDir/$diag/$SimLogfile");
	while(<SIMFILE>) {
	  if ($_ =~ /Using\s+CLK\s+period\s+(\S+)/) {
	    $SimPeriod = $1;
          } elsif ($_ =~ /\+clkPeriod=(\S+)/) {
            $SimPeriod = $1;
	  } elsif (($_ =~ /Time\s+scale\s+of\s+\S+\s+is\s+([0-9]+)(\S+)/) || ($_ =~ /^TimeScale\s+of\s+\S+\s+is\s+([0-9]+)\s+(\S+)/)) {
	    $ScaleMultiplier = $1;
	    $Timescale = $2;
	  }
	}
	close(SIMFILE);
      }
 unless ($SimPeriod eq "N/A") {
	$ScaleMultiplier = convertTimeUnit($ScaleMultiplier,$Timescale);
	$SimFreq = 1000.0 / ($ScaleMultiplier * $SimPeriod);
	$SimFreq = ($SimFreq < 1) ? sprintf("%.3f",$SimFreq) : sprintf("%.0f",$SimFreq);
      }
}
#  open(POWERSUM,">PowerTable.txt");
#  print POWERSUM "\t\t\tPower Analysis Summary Report Using Joules Tensilica Energy Analysis Flow\n";
#  print POWERSUM "\n";
#  print POWERSUM "\t\t\tNote: all power numbers are in mW\n";
#  print POWERSUM "\n";
#  print POWERSUM "Diag                           Frequency   Dyn Power     Leakage Power     Total Power\n";
#  print POWERSUM '-' x 120;
#  print POWERSUM "\n";
#  foreach $test (keys %leakage) {
#    $total = $dyn{$test}+$leakage{$test};
#    print POWERSUM "$test           $SimFreq MHz   $dyn{$test}      $leakage{$test}    $total\n";
#  }
#  close(POWERSUM);
  chdir $TopDir;
}
#################################################################################
# post-processing: generate final summary tables for power analysis, and parse	#
# out individual power reports for each given diag				#
#################################################################################

my $power = {};
if ($use_voltus == 1) {
  if(-e "PowerTable.txt"){ 
    $power = readPowerTable("PowerTable.txt");
  }
  $power = readConcatFileFromVoltus(\%ValidDiagHash,$power);
  @{$power->{"diags"}} = uniq @{$power->{"diags"}};
  printPowerSummary($PowerTable,$power);
} elsif ($use_joules == 1) {
  $power = readConcatFileFromJoules(\%ValidDiagHash);
  printPowerSummary($PowerTable,$power);
} elsif (-e $ConcatenatedOutputFile) {
  printPowerSummary($PowerTable,$power);
  unlink $ConcatenatedOutputFile;
} elsif(!$use_xtream) {
  print "Warning: File $ConcatenatedOutputFile is not available to generate summary power data; skipping summary table generation.\n";
}

#################################################################################
# subroutines									#
#################################################################################

sub parseCommandLine {
    my @options = qw(
                     help
		     prog=s
                     test=s
                     testlist=s@
                     rundir=s
		     resultsdir=s
		     csf=s
		     opcond=s
		     significant_digits=i
	             netlist=s
		     setload=s
		     spef=s
		     vcd
		     power_format=s
		     statistical
		     hierarchical
		     detailed
		     use_xtream
		     power_start=i
		     power_stop=i
		     scope=s
		     period=i
		     ts=s
                    );

    # Parse command line options
    my $ret = parseOptions(\@options);

    # Print usage summary
    &printUsage() if (!$ret || optionOn('help'));
}

sub printUsage
{
print <<END_OF_MESSAGE;
$0 [options]

-test <path>            Name of power diag that was run through simulation tool
			to generate the toggle file information. This is
			relative to the directory specified with the -rundir option.
			No default is set.

-testlist <file>        Read this file for a list of diags to run. Useful when
			specifying multiple diags. Entries should follow the
			same rules outlined for the -test argument above.

-rundir <dir>      	The location of the results directory generated by
			simulation tool (where the diag simulation output is stored).
			The default is ./sim_results_gate.

-resultsdir <dir>  	The results of power analysis will be placed in this
			directory. The default is ./gate_power_analysis. If any
			pre-existing directory has the same name as this output
			directory, it will be overwritten.

-csf <file>	   	Location of CadSetup.file.

-opcond <slow|typical|fast> 
                        Specifies the operating condition on which the power
			analysis will be done. Allowed values are "typical",
			"slow" or fast. Defaults to "typical".
			fast is only supported with voltus only

-significant_digits <i> Specifies the number of significant digits of the
			reported power numbers in the PowerTable.txt file.
			The supported integer range is between 0 and 15.
		   	Default is set to 5.

-netlist <file>	   	Run using this netlist. Required for all flows. Default
			depends on the implemented level of hierarchy as chosen
			in the CadSetup.file: 
			If Syn_UseMemoryMacros is 1:
			$MemMacroDefaultNetlist
			Otherwise default is:
			$DefaultNetlist

-spef <file>		Run using this Standard Parasitic Exchange Format (SPEF)
			capacitance file. This detailed extraction information
			allows for more accurate power analysis. This file is
			generated by Genus, Innovus, and QRC flows, and should
			be used in place of a wire-load model or set_load file
			if available. Only one of -setload or -spef may be used.
			If using Genus, a Genus_Physical_Opt license is needed
			to load a SPEF file; if unavailable, use a set_load
			file instead. A SPEF file must be provided if using
			Voltus for power analysis. No default is set.
			If attempting power analysis for the typical operating
			condition, it is recommended to use a SPEF file
			generated for the typical extraction corner.

-vcd			Use a Value Change Dump (VCD) file to provide switching
			activity. Indicates that the tool should search for
			VCD files in the output of simulation tool as specified by the
			-rundir directory. If not speficied, the tool searches
			for SAIF files instead.


This script performs gate-level power analysis on the given netlist. This
script assumes that simulation has already been run in power mode to
generate toggle information for the given diags
(See the power simulation section in the Hardware User's Guide for how to 
run gate level simulations for power analysis).

Given a list of diags and their location, Voltus power analysis can
be performed on the given netlist. Power analysis can be performed on any
number of diags.

Power analysis reports for each diag will be produced and placed in the
./gate_power_analysis (or user specified) directory, as well as an overall
summary table of the results in the file PowerTable.txt. 
END_OF_MESSAGE
exit(1);
}
