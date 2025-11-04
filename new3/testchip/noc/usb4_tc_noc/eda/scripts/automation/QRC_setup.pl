#!/usr/bin/env perl

################################################################################
# Copyright (c) 2014-2025 by Cadence Design Systems Inc.  ALL RIGHTS RESERVED.              #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to   #
# third parties in any manner, medium, or form, in whole or in part, without   #
# the prior written consent of Cadence Design Systems Inc.                                  #
################################################################################

################################################################################
# Filename: QRC_setup.pl                                                       #
# Objective: Generate corner.defs and modify QRC_define.cmd                    #
#     (Future support of multi-mode multi-corner flow needs QRC_extract.cmd)   #
# Input: QRC_define.cmd and optional QRC_extract.cmd                           #
# Output: QRC_define.cmd and corner.defs                                       #
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

################################################################################
# Global variables                                                             #
################################################################################

################################################################################
# read in the options                                                          #
################################################################################
my $help = 0;
my $in = "";
my $out = "";

my $usage = <<USAGE;
  $0 [options]

  This script generates corner.defs and modifies QRC_define.cmd for QRC extraction
  -help                   --Print the Help Information
  -in    <QRC_define.cmd> --Input file of the QRC_define.cmd
  -out   <./extract_qrc/> --Output files directory
  
USAGE

my $ret = GetOptions(
  "help"      => \$help,
  "in=s"      => \$in,
  "out=s"     => \$out);

# check the input options
check_options();

# read layer map file and update layer mapping to QRC_define.cmd
qrc_define_update($in,$out);

# default mode
corner_defs_gen($in,$out);


##################################
# Subroutines
##################################
sub qrc_define_update
{
my($qrc_define_file,$out_file) = @_;
$out_file = $out_file."QRC_define.cmd";
my $update = 0;
my $layer_map_file;
my $layer_map_info;

open(INFILE,"<$qrc_define_file") or die ("Cannot open $qrc_define_file file");
    while (<INFILE>) 
    {
    if ( $_ =~ /QRC_LayerMappingInfo/ ){ $update = 1; }  
    if ( $_ =~ /QRC_LayerMappingFile\s+(.+)/ ){ $layer_map_file = $1; }  
    }
close(INFILE);

if ($update == 0)
{
    open(INFILE,"<$layer_map_file") or die ("Cannot open $layer_map_file file");
    open(OUTFILE,">>$out_file") or die ("Cannot create QRC_define.cmd file");
    while (<INFILE>) 
    {
        if ( $_ =~ /(.+)/ ){$layer_map_info .= $1." ";}
    }
    print OUTFILE "\nset QRC_LayerMappingInfo \"$layer_map_info\"";
    close(INFILE);
    close(OUTFILE);

}

    
}

sub check_options 
{
  if ($help || ! $ret) 
    {
    print $usage;
    exit;
    }
}

sub corner_defs_gen
{
my($qrc_define_file,$out_file) = @_;
$out_file = $out_file."corner.defs";
open(INFILE,"<$qrc_define_file") or die ("Cannot open $qrc_define_file file");
open(OUTFILE,">$out_file") or die ("Cannot create corner.defs file");
my $maxline;
    while (<INFILE>) 
    {
    if ( $_ =~ /Lib_MaxQrcTechFile.+\{(.+)qrcTechFile/ )
         {print OUTFILE "DEFINE max $1\n";$maxline = $_;}
    if ( $_ =~ /Lib_MinQrcTechFile.+\{(.+)qrcTechFile/ )
         {print OUTFILE "DEFINE min $1\n";}
    if ( $_ =~ /Lib_TypQrcTechFile.+\{(.+)qrcTechFile/ && $_ ne $maxline)
         {print OUTFILE "DEFINE typ $1\n";}
    if ( $_ =~ /LIB_PROCESS_NODE\s+(\d+)/ )
         {print OUTFILE "DEFINE $1 .";}
    }
    close(INFILE);
    close(OUTFILE);
}

