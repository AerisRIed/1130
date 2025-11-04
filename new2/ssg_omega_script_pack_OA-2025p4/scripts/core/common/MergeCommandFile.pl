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

use lib "$RealBin/";
use CoreUtils;

#########################################################
# Setup and documentation				#
#########################################################

my $help = 0;
my $ret;
my ($output_merged_vf_file,$input_vf_file,$anchor_dir) = ("","","");

my $usage = <<USAGE;
$0 [options]

This script is intended to be called via a TCL exec command
within each Omega flow tool that requires recursive merging
and expansion of HDL command file(s). All three options are
required.

-out <file>	Name of the merged command file to be generated.
		No default is set.

-in <file>	Name of the input command file(s) to be parsed.
		If more than one, use quotes to enclose the list.
		No default is set.

-anchor <dir>	Path of the anchor directory to be used for
		first-level relative paths.
		No default is set.
USAGE

$ret = GetOptions(
         "help"     => \$help,
	 "out=s"    => \$output_merged_vf_file,
	 "in=s"     => \$input_vf_file,
	 "anchor=s" => \$anchor_dir);

if ($help || ! $ret) {
  print "$usage";
  exit;
}

die "Error: The \"-out\" option must be specified.\n" if ($output_merged_vf_file eq "");
die "Error: The \"-in\" option must be specified.\n" if ($input_vf_file eq "");
die "Error: The \"-anchor\" option must be specified.\n" if ($anchor_dir eq "");

#########################################################
# Launch subroutine to merge files			#
#########################################################

CoreUtils::CreateMergedAbsPathFilelist($output_merged_vf_file,$input_vf_file,$anchor_dir);
