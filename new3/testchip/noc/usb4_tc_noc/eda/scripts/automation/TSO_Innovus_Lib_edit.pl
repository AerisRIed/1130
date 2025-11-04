#!/usr/bin/env perl

################################################################################
# Copyright (c) 2006-2025 by Cadence Design Systems Inc.  ALL RIGHTS RESERVED.              #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to   #
# third parties in any manner, medium, or form, in whole or in part, without   #
# the prior written consent of Cadence Design Systems Inc.                                  #
################################################################################

################################################################################
# Filename: TSO_Innovus_Lib_edit.pl                                            #
# Goal: To add the TSO LVT/HVT lef/lib information to tempus_tso Innovus_Lib   #
#            We can also edit the frequency in sdc if needed                   #
# Input: final.enc.dat/viewDefinition.tcl		               #
#	 final.enc.dat/*.globals		                       #
#	 final.enc.dat/mmmc/modes/functional/functional.sdc        #
#	 CadSetup.File TSO Lib/Lef variables				       #
################################################################################
use strict;
use FileHandle;
use Getopt::Long;
use Cwd;
use File::Path;
use File::Copy;
use File::Basename;
use FindBin qw($RealBin);

my $pwd = cwd();

my $tsomaxlib;
my $tsotyplib;
my $tsominlib;
my $tsolef;
my $vialef;
my $minsbocv;
my $maxsbocv;

read_cad_setup_file();
edit_innovuslib_view_def();
edit_innovuslib_globals();

sub edit_innovuslib_globals() {

my $filename = <$pwd/final.enc.dat/*.globals>;
open VDF, "$filename" or die "Could not open $filename\n";
open TMP, ">$filename.temp" or die "Cannot open $filename.temp\n";
  while (<VDF>)
  {
    if (/init_lef_file/) { 

    print TMP "setUserDataValue init_lef_file {$tsolef $vialef}\n";
    next;
    }

  print TMP $_;
  }
  system "mv $filename.temp $filename";
}

sub edit_innovuslib_view_def() {

my $filename = "$pwd/final.enc.dat/viewDefinition.tcl";
open VDF, "$filename" or die "Could not open $filename\n";
open TMP, ">$filename.temp" or die "Cannot open $filename.temp\n";
my $minlibflag=0;
my $maxlibflag=0;
my $typlibflag=0;
my $max_budget_minlibflag=0;
my $max_budget_maxlibflag=0;
  while (<VDF>)
  {

    if (/min_lib_set/) { $minlibflag=1;}
    if (/max_lib_set/) { $maxlibflag=1;}
    if (/typ_lib_set/) { $typlibflag=1;}
    if (/max_lib_set_budgeting_min/) { $maxlibflag=0;$max_budget_minlibflag=1;}
    if (/max_lib_set_budgeting_max/) { $maxlibflag=0;$max_budget_maxlibflag=1;}

    if (/list/ && /\.lib/ && $minlibflag == 1) {
    print TMP " [list $tsominlib]";
    $minlibflag = 2;
    next;
    }
    elsif ($_ !~ /create/ && $minlibflag == 2) { if (/-aocv/) { print TMP " -aocv [list $minsbocv]";next; } else { next;} } 
    elsif ($minlibflag == 2) {print TMP "\n"; $minlibflag =0;}

    if (/list/ && /\.lib/ && $typlibflag == 1) {
    print TMP " [list $tsotyplib]";
    $typlibflag = 2;
    next;
    }
    elsif ($_ !~ /create/ && $typlibflag == 2) {if (/-aocv/) { print TMP " -aocv [list $maxsbocv]"; next;} else { next;} }
    elsif ($typlibflag == 2) {print TMP "\n"; $typlibflag =0;}

    if (/list/ && /\.lib/ && $maxlibflag == 1) {
    print TMP " [list $tsomaxlib]";
    $maxlibflag = 2;
    next;
    }
    elsif ($_ !~ /create/ && $maxlibflag == 2) {if (/-aocv/) { print TMP " -aocv [list $maxsbocv]"; next;} else { next;} } 
    elsif ($maxlibflag == 2) {print TMP "\n"; $maxlibflag =0;}

    if (/list/ && /\.lib/ && $max_budget_minlibflag == 1) {
    print TMP " [list $tsomaxlib]";
    $max_budget_minlibflag = 2;
    next;
    }
    elsif ($_ !~ /create/ && $max_budget_minlibflag == 2) {if (/-aocv/) { print TMP " -aocv [list $maxsbocv]"; next;} else { next;} } 
    elsif ($max_budget_minlibflag == 2) {print TMP "\n"; $max_budget_minlibflag =0;}

    if (/list/ && /\.lib/ && $max_budget_maxlibflag == 1) {
    print TMP " [list $tsomaxlib]";
    $max_budget_maxlibflag = 2;
    next;
    }
    elsif ($_ !~ /create/ && $max_budget_maxlibflag == 2) {if (/-aocv/) { print TMP " -aocv [list $maxsbocv]"; next;} else { next;} } 
    elsif ($max_budget_maxlibflag == 2) {print TMP "\n"; $max_budget_maxlibflag =0;}
  print TMP $_;
  }
  system "mv $filename.temp $filename";
}

sub read_cad_setup_file {

my $filename = "$pwd/../CadSetup.file";

open CSF, "$filename" or die "Could not open $filename\n";

        while (<CSF>)
        {
                if (/^Lib_CadenceLIB\s*{(.*)}/){$tsomaxlib = $1;}
                if (/^Lib_CadenceMinLIB\s*{(.*)}/){$tsominlib = $1;}
                if (/^Lib_CadencePhysicalLibrary\s*{(.*)}/){$tsolef = $1;}
                if (/^Lib_MaxSBOCV\s*{(.*)}/){$maxsbocv = $1;}
                if (/^Lib_MinSBOCV\s*{(.*)}/){$minsbocv = $1;}
                if (/^Lib_CadenceTypLIB\s*{(.*)}/){$tsotyplib = $1;}
                if (/^Lib_ViaPillar_LEF\s*{(.*)}/){
                  if ($1 =~/_none_/) {
                   $vialef = "";
                  } else {
                   $vialef = $1;
                  }
                }
        }

}
