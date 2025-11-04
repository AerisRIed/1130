#!/usr/bin/env perl

####################################################################################
#          Copyright (c) 2006-2025 by Cadence Design Systems Inc.  ALL RIGHTS RESERVED.         # 
#   These coded instructions, statements, and computer programs are the            #
#   copyrighted works and confidential proprietary information of Cadence Design Systems Inc.   #
#   They may not be modified, copied, reproduced, distributed, or disclosed to     #
#   third parties in any manner, medium, or form, in whole or in part, without     #
#   the prior written consent of Cadence Design Systems Inc.                                    #
####################################################################################

use FileHandle;
use File::Basename;
use File::Path;
use File::Copy;
use Getopt::Long;  
use Cwd;
use strict 'vars';

########################################################################################################
# read in options
########################################################################################################

my $core = "";
if (defined $ENV{'DESIGN'}) {
   $core = "$ENV{'DESIGN'}";
} else {
  print "Error: DESIGN is not set in env_design.sh. Specify the top module name.\n";
  exit(1);
}
my $help = 0;
my ($ret, $OutputFile, $TestFile, $TestCondition);
my $AlternateFile = "";
my $InputFile = "${core}_syn.timing";
my $pwd = cwd();
my $genus = 0;
my $tempus = 0;

my $usage = <<USAGE;
  $0 [options]

  This script parses a tool-specific timing report and removes
  the less-critical redundant paths, such that each path represents a unique
  startpoint/endpoint pair.

  -input <filename>	Path to timing report. Defaults to $InputFile

  -output <filename>	Compressed output report. Defaults to ${InputFile}.cmpr

  -genus		Use if input file is from Cadence Genus.

  -tempus		Use if input file is from Cadence Tempus.
USAGE

$ret = GetOptions(
	 "help" => \$help,
	 "genus" => \$genus,
	 "tempus" => \$tempus,
         "input=s" => \$InputFile,
	 "output=s" => \$AlternateFile);

if ($help || ! $ret) {
  print "$usage";
  exit;
}

die ("Cannot specify more than one of the following: \"-genus\" or \"-tempus\"") if ($genus + $tempus > 1);
$InputFile = "$pwd/$InputFile" unless (($InputFile =~ /^\//) || ($InputFile =~ /^\.\//));
$TestFile = dirname($InputFile);
$TestFile .= "/${core}_syn.timing";
$TestCondition = 0;
if (-r $InputFile) {
  print "Timing file to be compressed: $InputFile\n";
} elsif (-r $TestFile) {
  print "Cannot locate timing file: $InputFile\nTiming file to be compressed instead: $TestFile\n";
  $InputFile = $TestFile;
  $TestCondition = 1;
} else {
  print "Error: Specified input file is unreadable: $InputFile\n";
  exit;
}

if (($AlternateFile eq "") || ($TestCondition == 1)) {
   $OutputFile = $InputFile . ".cmpr";
} else {
   $OutputFile = $AlternateFile;
   $OutputFile = "$pwd/$OutputFile" unless (($OutputFile =~ /^\//) || ($OutputFile =~ /^\.\//));
}

########################################################################################################
# compress the report file
########################################################################################################

my $OriginalPathCount = 0;
my $CompressedPathCount = 0;
my @MatchArray = ();
my $StartPoint = "";
my $EndPoint = "";
my $AllowPrinting = 1;
my $DoubleLine = 0;
my ($temp0, $temp1, $SearchElement, %MatchHash);
my @StorageArray = ();

open(INFILE,"<$InputFile") or die ("Cannot open $InputFile");
open(OUTFILE,">$OutputFile") or die ("Cannot create $OutputFile");

if ($genus) {
  while(<INFILE>) {
    push @StorageArray, $_;
    if ($_ =~ /^\s*Start-point\s+:\s+(\S+)/) {
      $StartPoint = $1;
      $OriginalPathCount++;
      $_ = <INFILE>;
      push @StorageArray, $_;
      if ($_ =~ /^\s*End-point\s+:\s+(\S+)/) {
	$EndPoint = $1;
      }
      $StartPoint =~ s/\[[0-9]+\]//g;
      $StartPoint =~ s/\//________/g;
      $EndPoint =~ s/\[[0-9]+\]//g;
      $EndPoint =~ s/\//________/g;
      $SearchElement = $StartPoint . $EndPoint;
      unless (defined $MatchHash{$SearchElement}) {
	$MatchHash{$SearchElement} = 1;
	$CompressedPathCount++;
	foreach my $element (@StorageArray) {
	  print OUTFILE $element;
	}
      }
      @StorageArray = ();
    }
  }
} elsif ($tempus) {
  while (<INFILE>) {
    if ($_ =~ /^Path\s+\d+/) {
      $AllowPrinting = 1;
      $OriginalPathCount++;
      my $line1 = $_;
      my $line2 = <INFILE>;
      my $line3 = <INFILE>;
      if ($line2 =~ /^\s*Endpoint\s*:\s*(\S+)/) {
        $EndPoint = $1;
      }
      if ($line3 =~ /^\s*Beginpoint\s*:\s*(\S+)/) {
        $StartPoint = $1;
      }
      if ($StartPoint =~ /\//) {
        my @a = split /\//, $StartPoint;
        $StartPoint = join "/", @a[0..$#a-1];
      }
      if ($EndPoint =~ /\//) {
        my @a = split /\//, $EndPoint;
        $EndPoint = join "/", @a[0..$#a-1];
      }
      $StartPoint =~ s/\[[0-9]+\]//g;
      $StartPoint =~ s/_[0-9]+_$//g;
      $StartPoint =~ s/\//________/g;
      $EndPoint =~ s/\[[0-9]+\]//g;
      $EndPoint =~ s/_[0-9]+_$//g;
      $EndPoint =~ s/\//________/g;
      $SearchElement = $StartPoint . $EndPoint;
      if (defined $MatchHash{$SearchElement}) {
        $AllowPrinting = 0;
      } else {
        $MatchHash{$SearchElement} = $line1;
        $CompressedPathCount++;
        print OUTFILE $line1;
        print OUTFILE $line2;
        print OUTFILE $line3;
      }
    } else { # if /^Path
      if ($AllowPrinting) {
        print OUTFILE $_;
      }
    }
  } # while <INFILE>
} else {
  while(<INFILE>) {
    if ($_ =~ /^\s*Startpoint:\s+(\S+)/) {
      $OriginalPathCount++;
      $DoubleLine = 0;
      $StartPoint = $1;
      $StartPoint =~ s/\[[0-9]+\]$//g;
      $StartPoint =~ s/_[0-9]+_$//g;
      $StartPoint =~ s/\//________/g;
      $temp0 = $_;
      $temp1 = $_ = <INFILE>;
      unless ($_ =~ /^\s*Endpoint:/) {
	$_ = <INFILE>;
	$DoubleLine = 1;
      }
      if ($_ =~ /^\s*Endpoint:\s+(\S+)/) {
	$EndPoint = $1;
	$EndPoint =~ s/\[[0-9]+\]$//g;
	$EndPoint =~ s/_[0-9]+_$//g;
	$EndPoint =~ s/\//________/g;
      }
      $SearchElement = $StartPoint . $EndPoint;
      $AllowPrinting = 1;
      foreach my $element (@MatchArray) {
	if ($element eq $SearchElement) {
	  $AllowPrinting = 0;
	}
      }
      if ($AllowPrinting) {
	push @MatchArray, $SearchElement;
	print OUTFILE $temp0;
	if ($DoubleLine) {
	  print OUTFILE $temp1;
	}
      }
    }
    if ($AllowPrinting) {
      print OUTFILE $_;
    }
  }
  $CompressedPathCount = scalar(@MatchArray);
}

close(INFILE);
close(OUTFILE);

print "Number of paths in original timing report: $OriginalPathCount\n";
print "Number of paths in compressed timing report: $CompressedPathCount\n";
