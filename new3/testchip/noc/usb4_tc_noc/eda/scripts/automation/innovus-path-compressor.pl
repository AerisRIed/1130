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

my $help = 0;
my ($ret, $OutputFile, $TestFile, $TestCondition);
my $AlternateFile = "";
my $core = "";
if (defined $ENV{'DESIGN'}) {
  $core = "$ENV{'DESIGN'}";
} else {
  print "Error: DESIGN is not set in env_design.sh. Specify the top module name.\n";
  exit(1);
}
my $InputFile = "${core}_syn.timing";
my $pwd = cwd();

my $usage = <<USAGE;
  $0 [options]

  This script parses an Innovus timing report and removes
  the redundant paths that result from bit-blasting.

  -input <filename>	Path to timing report. Defaults to $InputFile
  -output <filename>	Compressed output report. Defaults to ${InputFile}.cmpr
USAGE

$ret = GetOptions(
	 "help" => \$help,
         "input=s" => \$InputFile,
	 "output=s" => \$AlternateFile);

if ($help || ! $ret) {
  print "$usage";
  exit;
}

$InputFile = "$pwd/$InputFile" unless (($InputFile =~ /^\//) || ($InputFile =~ /^\.\//));
if (-r $InputFile) {
  print "Timing file to be compressed: $InputFile\n";
} else {
  print "Error: Specified input file is unreadable: $InputFile\n";
  exit;
}

if ($AlternateFile eq "") {
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
my $DoubleLine = 0;
my ($temp0, $temp1, $SearchElement, %MatchHash);
my @StorageArray = ();
my $looking_for_endpoint = 0;
my $looking_for_startpoint = 0;
my $path_to_print = "";
my $line = "";

open(INFILE,"<$InputFile") or die ("Cannot open $InputFile");
open(OUTFILE,">$OutputFile") or die ("Cannot create $OutputFile");

while (<INFILE>) {
  $line = $_;
  if ($line =~ /^#/) {
      print OUTFILE $line;
  }
  if ($line =~ /^Path\s+\d+/) {
    $OriginalPathCount++;
    $looking_for_endpoint = 0;
    $looking_for_startpoint = 0;
    if (($StartPoint ne "") && ($EndPoint ne "")) {
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
      if (not defined $MatchHash{$SearchElement}) {
        $MatchHash{$SearchElement} = 1;
        $CompressedPathCount++;
        print OUTFILE $path_to_print;
      }
    }
    $path_to_print = "";
  } elsif ($line =~ m/^Endpoint:\s+(\S+)\s+\([\^v]\)/) {
    $EndPoint = $1;
    $looking_for_endpoint = 0;
  } elsif ($line =~ m/^Endpoint:\s+(\S+)\s*$/) {
    $EndPoint = $1;
    $looking_for_endpoint = 1;
  } elsif (($looking_for_endpoint==1) && ($line !~ m/\([\^v]\)/)) {
    $EndPoint .= $line;
  } elsif (($looking_for_endpoint==1) && ($line =~ m/(.*?)\s*\([\^v]\)/)) {
    $EndPoint .= $1;
    $looking_for_endpoint = 0;
  } elsif ($line =~ m/^Beginpoint:\s+(\S+)\s+\([\^v]\)/) {
    $StartPoint = $1;
    $looking_for_startpoint = 0;
  } elsif ($line =~ m/^Beginpoint:\s+(\S+)\s*$/) {
    $StartPoint = $1;
    $looking_for_startpoint = 1;
  } elsif (($looking_for_startpoint==1) && ($line !~ m/\([\^v]\)/)) {
    $StartPoint .= $line;
  } elsif (($looking_for_startpoint==1) && ($line =~ m/(.*?)\s*\([\^v]\)/)) {
    $StartPoint .= $1;
    $looking_for_startpoint = 0;
  }
  $path_to_print .= $line;  
} 
if (($StartPoint ne "") && ($EndPoint ne "")) {
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
  if (not defined $MatchHash{$SearchElement}) {
    $MatchHash{$SearchElement} = 1;
    $CompressedPathCount++;
    print OUTFILE $path_to_print;
  }
}

close(INFILE);
close(OUTFILE);

print "Number of paths in original timing report: $OriginalPathCount\n";
print "Number of paths in compressed timing report: $CompressedPathCount\n";
