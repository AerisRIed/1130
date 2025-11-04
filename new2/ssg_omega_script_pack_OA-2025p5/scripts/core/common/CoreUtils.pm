#!/usr/bin/env perl
################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

#########################################################
# This package contains the common set of routines	#
# used throughout the Omega flow.			#
#########################################################

package CoreUtils;

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

@CoreUtils::ISA = qw(Exporter);
@CoreUtils::EXPORT = qw(
  RunSystemCommand
  DualPrint
  PathConvert
  VarRel2Abs
  DictRel2Abs
  AbsPathOneFilelist
  CreateMergedAbsPathFilelist
  ValidateLRM
  ImportEnv2Tcl
);
@CoreUtils::EXPORT_OK = ();
@CoreUtils::EXPORT_TAGS = ();

#########################################################
# Subroutine: RunSystemCommand				#
#							#
# Universal system call with return evaluation.		#
#########################################################

sub RunSystemCommand {
  my $SystemCommand = $_[0];
  print "$0: Executing $SystemCommand\n";
  system($SystemCommand);
  if ($? == -1) {
    print "Failed to execute: $!\n";
  } elsif ($? & 127) {
    printf "Child died with signal %d, %s coredump\n", ($? & 127), ($? & 128) ? 'with' : 'without';
  } else {
    printf "Child exited with value %d\n", $? >> 8;
  }
}

#########################################################
# Subroutine: DualPrint					#
#							#
# Similar to IO::Tee function, will multiplex output to	#
# stdout as well as the given file handle.		#
#########################################################

sub DualPrint {
  my ($loc_fp,$print_string) = @_;
  print "${print_string}\n";
  print $loc_fp "${print_string}\n";
}

#########################################################
# Subroutine: PathConvert				#
#							#
# Takes a path to a single file regardless of		#
# specification and turns it into an absolute path	#
# based on the provided root directory.			#
#########################################################

sub PathConvert {
  my ($anchor_dir,$loc_file) = @_;
  my $full_path = "";
  $loc_file =~ s/\$\{?(\w+)\}?/$ENV{$1}/g;
  $loc_file = glob($loc_file) if ($loc_file =~ /^~/);
  if ($loc_file !~ /^\//) {
    $full_path = abs_path("${anchor_dir}/${loc_file}");
  } else {
    $full_path = abs_path($loc_file);
  }
  return $full_path;
}

#########################################################
# Subroutine: VarRel2Abs				#
#							#
# Converts a TCL variable assignment of one or more	#
# files that can potentially be specified with relative	#
# paths and converts them all to absolute paths.	#
# Returns the full set of absolute paths so they can be	#
# used to define HDL search paths in the tool.		#
#########################################################

sub VarRel2Abs {
  my ($var_name,$var_content,$print_statement,$omega_var_root,$out_fp) = @_;
  my ($new_line_content,$loc_path,$rtl_search_path) = ("","","");
  my @file_array = split(/\s+/,$var_content);
  foreach my $fa (@file_array) {
    $fa = PathConvert($omega_var_root,$fa);
    die "Error: cannot read $print_statement ${fa}.\n" unless (-r $fa);
    $new_line_content .= "$fa ";
    $loc_path = dirname($fa);
    $rtl_search_path .= "$loc_path ";
  }
  chop($new_line_content);
  chop($rtl_search_path);
  print $out_fp "set $var_name \"$new_line_content\"\n";
  return $rtl_search_path;
}

#########################################################
# Subroutine: DictRel2Abs				#
#							#
# Converts a TCL two-entry dictionary assignment of one	#
# or more files that can potentially be specified with	#
# relative paths and converts them all to absolute	#
# paths. Returns the full set of absolute paths so they	#
# can be used to define HDL search paths in the tool.	#
#########################################################

sub DictRel2Abs {
  my ($dict_name,$dict_index,$dict_value,$print_statement,$omega_var_root,$out_fp) = @_;
  my ($new_line_content,$loc_path,$rtl_search_path) = ("","","");
  my @file_array = split(/\s+/,$dict_index);
  foreach my $fa (@file_array) {
    $fa = PathConvert($omega_var_root,$fa);
    die "Error: cannot read $print_statement ${fa}.\n" unless (-r $fa);
    $new_line_content .= "$fa ";
    $loc_path = dirname($fa);
    $rtl_search_path .= "$loc_path ";
  }
  chop($new_line_content);
  chop($rtl_search_path);
  print $out_fp "dict set $dict_name \"$new_line_content\" \"${dict_value}\"\n";
  return $rtl_search_path;
}

#########################################################
# Subroutine: AbsPathOneFilelist			#
#							#
# Traverses a filelist and expands all relative paths	#
# to absolute paths. Calls itself recursively to follow	#
# -f/-F file inclusion.					#
#########################################################

sub AbsPathOneFilelist {
  my ($anchor_dir,$filelist,$out_fp) = @_;
  my ($recur_anchor,$recur_flist,$storage,$y_or_v) = ("","","","");
  my $in_fp = new FileHandle ($filelist, '<');
  die "$0: $! - Cannot open ${filelist}.\n" unless defined $in_fp;
  while(<$in_fp>) {
    next if ($_ =~ /^\s*\/\//);
    next if ($_ !~ /\S/);
    if ($_ =~ /^\s*\+define\+/) {
      print $out_fp $_;
    } elsif ($_ =~ /^\s*\+incdir\+\s*(\S+)/) {
      $storage = $1;
      $storage = PathConvert($anchor_dir,$storage);
      print $out_fp "+incdir+$storage\n";
    } elsif ($_ =~ /^\s*-(y|v)\s*(\S+)/) {
      $y_or_v = $1;
      $storage = $2;
      $storage = PathConvert($anchor_dir,$storage);
      print $out_fp "-${y_or_v} $storage\n";
    } elsif ($_ =~ /^\s*-f\s*(\S+)/i) {
      $storage = $1;
      $recur_flist = PathConvert($anchor_dir,$storage);
      $recur_anchor = dirname($recur_flist);
      AbsPathOneFilelist($recur_anchor,$recur_flist,$out_fp);
    } elsif (($_ =~ /^\s*(\S+)\s*$/) && ($_ !~ /^\s*(\+|-)/)) {
      $storage = $1;
      $storage = PathConvert($anchor_dir,$storage);
      print $out_fp "$storage\n";
    } else {
      print $out_fp $_;
    }
  }
  close($in_fp);
}

#########################################################
# Subroutine: CreateMergedAbsPathFilelist		#
#							#
# Takes in a set of HDL command files and combines them	#
# into a single command file. All relative paths are	#
# made absolute, and additional inclusion of command	#
# files via the -f/-F arguments are recursively		#
# expanded.						#
#########################################################

sub CreateMergedAbsPathFilelist {
  my ($merged_file,$input_file_set,$omega_var_root) = @_;
  my $current_vf_anchor_dir = "";
  my @working_file_array = ();
  my $merge_fp = new FileHandle ($merged_file, '>');
  die "$0: $! - Cannot create ${merged_file}.\n" unless defined $merge_fp;
  my @input_file_array = split(/\s+/,$input_file_set);
  print $merge_fp "//" x 50, "\n";
  print $merge_fp "// This file contains the recursively merged and absolute-pathed contents of:\n";
  foreach my $fa (@input_file_array) {
    $fa = PathConvert($omega_var_root,$fa);
    die "Error: cannot read ${fa}.\n" unless (-r $fa);
    push @working_file_array, $fa;
    print $merge_fp "// $fa\n";
  }
  print $merge_fp "//" x 50, "\n";
  foreach my $fa (@working_file_array) {
    $current_vf_anchor_dir = dirname($fa);
    AbsPathOneFilelist($current_vf_anchor_dir,$fa,$merge_fp);
  }
  close($merge_fp);
}

#########################################################
# Subroutine: ValidateLRM				#
#							#
# Takes in the user-specified RTL LRM parsing target	#
# and returns the tool-appropriate value.		#
#########################################################

sub ValidateLRM {
  my ($user_lang,$target_tool) = @_;
  my ($return_lang,$print_fail) = ("",0);
  if ($target_tool eq "litmus1") {
    if ($user_lang =~ /^(v1995|v2001|vhdl|sv|sv05|sva|auto_verilog)$/) {
      $return_lang = $user_lang;
    } elsif ($user_lang =~ /^v2k$/) {
      $return_lang = "v2001";
    } else {
      $print_fail = 1;
    }
  } elsif ($target_tool eq "jasper") {
    if ($user_lang =~ /^(vhdl|vhdl93|vhdl2k|vhdl08|verilog|v2k|v95|vams|sv|sv05|sv09|sv12|sv17)$/) {
      $return_lang = $user_lang;
    } else {
      $print_fail = 1;
    }
  } elsif ($target_tool eq "clp") {
    if ($user_lang =~ /^(verilog|verilog2k|v1995|systemverilog|sva|sv|sv09|sv12|vhdl|vhdl-93|vhdl-87|vhdl-2008)$/) {
      $return_lang = $user_lang;
    } elsif ($user_lang =~ /^v2k$/) {
      $return_lang = "verilog2k";
    } else {
      $print_fail = 1;
    }
  } elsif ($target_tool eq "joules") {
    if ($user_lang =~ /^(v1995|v2001|sv|vhdl)$/) {
      $return_lang = $user_lang;
    } elsif ($user_lang =~ /^v2k$/) {
      $return_lang = "v2001";
    } else {
      $print_fail = 1;
    }
  } else {
    die "Error: unsupported tool specified: ${target_tool}.\n";
  }
  if ($print_fail == 1) {
    die "Error: HDL LRM of \"${user_lang}\" is not a valid choice for ${target_tool}.\n";
  }
  return $return_lang;
}

#########################################################
# Subroutine: ImportEnv2Tcl				#
#							#
# Prints TCL code into the file provided by the input	#
# file pointer. This code will convert all environment	#
# variables into TCL variables of the same name for use	#
# within the tool flow.					#
#########################################################

sub ImportEnv2Tcl {
  my ($out_fp) = @_;
  my $tcl_code = <<TCL_CODE;
foreach env_var [lsort [array names ::env]] {
  puts [format "%s%s%s%s%s" "In" "fo    : creating new global TCL variable " \$env_var " from environment variable of the same name. Value: " \$::env(\$env_var)]
  set \$env_var \$::env(\$env_var)
}

TCL_CODE
  print $out_fp $tcl_code;
}

1;
