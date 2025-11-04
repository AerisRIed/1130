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
use Data::Dumper;
use File::Find;
use File::Path;
use File::Copy;
use File::Basename;
use File::Spec::Functions qw(:ALL);
use FindBin qw($RealBin);
use lib $RealBin;
use Cwd qw(abs_path);
use CoreUtils;

#########################################################
# Setup and documentation                               #
#########################################################
my $script_options = "@ARGV";
my $help = 0;
my $ret;
my $pwd = cwd();
my $dir = "";
my $design = "";
my $fail_mandatory = 0;
my $fail_optional = 0;
my $datestamp = `date +%m%d%Y_%H%M%S`;
chomp($datestamp);

my $usage = "
$0 [options]

This script will verify if all mandatory collateral exists in the correct folder.

-dir              Specify the root directory for the collaterals.

-design           Specify the design name.
";

$ret = GetOptions(
    "help" => \$help,
    "dir=s" => \$dir,
    "design=s" => \$design);

if ($help || ! $ret) {
  print "$usage";
  exit;
}


print "\nRunning:\n$0 $script_options\n";

if ($dir eq "") {
  print "\nError: -dir is a mandatory parameter and needs to be specified.\n";
  exit;
} else {
  if (! -d $dir) {
    print "\nError: $dir doesn't exist. Please change -dir.\n";
    exit;
  }
}
$dir = abs_path($dir);

if ($design eq "") {
  print "\nError: -design is a mandatory parameter and needs to be specified.\n";
  exit;
}

##"hdl/filelists/$design.f"
my @mandatory = ( 
"hdl/info/rtl.info",
"sdc/$design.func.sdc",
"power_intent/$design*.upf",
"dft/info/dft.info",
"design_info/*.info",
"omega_validation/validation_score/omega_validation_report.txt"
);

my @optional = (
"macro_data",
"stimulus/rtl/$design.*",
"stimulus/info/stim.info",
"safety_intent/$design*.usf"
);

## Search for filelist should be the first thing
&FindFilelist("$dir/hdl",$design);

foreach my $mand (@mandatory) {
  my $append_dir = "$dir";
  my @dirs = split (/\//, $mand);
  foreach my $actual_dir (@dirs) {
    if ($actual_dir !~ /\./) {
      $append_dir = $append_dir."/".$actual_dir;
      my ( $file ) = glob($append_dir);
      if (! defined $file || ! -d $file) {
        print "\nError: Didn't find mandatory directory $append_dir\n";
        last;
      }
    } else {
      my ( $file ) = glob("$append_dir/$actual_dir");
      if (! defined $file || ! -f $file) {
        print "\nError: Didn't find mandatory file $append_dir/$actual_dir\n";
        last;
      }
    }
  }
}


foreach my $opt (@optional) {
  my $append_dir = "$dir";
  my @dirs = split (/\//, $opt);
  foreach my $actual_dir (@dirs) {
    if ($actual_dir !~ /\./) {
      $append_dir = $append_dir."/".$actual_dir;
      my ( $file ) = glob($append_dir);
      if (! defined $file || ! -d $file) {
        print "\nInfo: Didn't find optional directory $append_dir\n";
        last;
      }
    } else {
      my ( $file ) = glob("$append_dir/$actual_dir");
      if (! defined $file || ! -f $file) {
        print "\nInfo: Didn't find optional file $append_dir/$actual_dir\n";
        last;
      }
    }
  }
}

&CheckOmegaValidation($dir);

our @files;
sub FindFilelist {
  my ($dir,$design) = @_;
  my @dirpath = ($dir);
  find(\&findstuff, @dirpath);
  if (!@files) {
    print "\nError: Didn't find any filelist (.vf/.f) under $dir/hdl/ directory.\n";
    return;
  }

  my @foundf = (grep /$design\.[v]{0,1}f$/, @files);
  if (!@foundf) {
    print "\nError: Didn't find any filename with the pattern $design.[v]f\n";
  } else {
    if (!(grep /hdl\/filelists\/$design\.[v]{0,1}f$/, @files)) {
      print "\nWarning: Found a filelist named $design.[v]f, but it is not placed in hdl/filelists/.\n";
    }
  }
}

sub findstuff {
  my $file = $File::Find::name;
  return unless -f "$file";
  if (grep {/\.(f|vf)$/} "$file") {
    push @files, $file;
  }
}

sub CheckOmegaValidation {
  my ($dir) = @_;
  $dir = "$dir/omega_validation/";
  my @omega_val = ("litmus1_run*", "jasper_cdc_run*", "jasper_mcp_run*", "jasper_superlint_run*", "clp_lint_run*", "joules_run*Flow_3");
  if (-d "$dir") {
    foreach my $actual_dir (@omega_val) {
      my $append_dir = $dir.$actual_dir;
      my ( $file ) = glob($append_dir);
      if (! defined $file || ! -d $file) {
        print "\nError: Didn't find mandatory directory $append_dir\n";
      }
    }
  }
}

