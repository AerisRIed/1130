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
use FileHandle;
use Getopt::Long;
use Cwd;
use File::Path;
use File::Copy;
use File::Basename;
use FindBin qw($RealBin);

my $help = 0;
my $ret;
my $pwd = cwd();
my $TargetDir = $pwd;

my $usage = <<USAGE;
$0 [options]

This script performs post-processing of the "write_do_lec" template scripts
generated from within the Genus flow to ensure correct functioning of the
Genus --> Conformal-Ultra flow.

-dir <dirname>		The directory in which the Genus run
			was performed. Defaults to $pwd
USAGE

$ret = GetOptions(
         "help" => \$help,
         "dir=s" => \$TargetDir);

if ($help || ! $ret) {
  print "$usage";
  exit;
}

$TargetDir = "$pwd/$TargetDir" unless (($TargetDir =~ /^\//) || ($TargetDir =~ /^\.\//));
die "The directory $TargetDir does not exist\n" unless (-d $TargetDir);
chdir $TargetDir;

my $DefineFile = "Genus_generic_define.tcl";
my $core = "";
if (defined $ENV{'DESIGN'}) {
   $core = "$ENV{'DESIGN'}";
} else {
  print "Error: DESIGN is not set in env_design.sh. Specify the top module name.\n";
  exit(1);
}
my $temp_line;
my @CPFArray = <*.cpf>;
foreach my $in_file (@CPFArray) {
  chomp($in_file);
  open(INFILE,"<$in_file") or die ("Cannot open $in_file");
  open(OUTFILE,">tempfile") or die ("Cannot create tempfile");
  while(<INFILE>) {
    $temp_line = $_;
    $temp_line =~ s/${core}_syn\.\S+\.sdc/${core}_syn.sdc/g;
    print OUTFILE $temp_line;
  }
  close(INFILE);
  close(OUTFILE);
  system("mv -f tempfile $in_file");
}

#########################################################################
# Check for various options used during Genus flow			#
#########################################################################

my ($MBCIUsed,$found_coremem) = (0,0);
if (-r $DefineFile) {
  open(INFILE,"<$DefineFile") or die ("Cannot open $DefineFile");
  while(<INFILE>) {
    if ($_ =~ /^\s*set\s+USE_MULTIBIT_CELLS\s+(\S+)/) {
      $MBCIUsed = $1;
    } elsif ($_ =~ /^\s*set\s+USE_MEMORY_MACROS\s+(\S+)/) {
	$found_coremem = $1;
    } 
  }
  close(INFILE);
}
my $attribute_text = ($MBCIUsed) ? " -revised g2" : "";
my $clp_option = "-LP";

#########################################################################
# Update just the Conformal-LP file					#
#########################################################################

my $CLPFile = <clp_pso_check.do>;
if (-r $CLPFile) {
  open(INFILE,"<$CLPFile") or die ("Cannot open $CLPFile");
  open(OUTFILE,">tempfile") or die ("Cannot create tempfile");
  while(<INFILE>) {
    $temp_line = $_;
    if ($temp_line =~ /^exit/) {
      print OUTFILE "\nreport_rule_check -verbose $clp_option > pso_rule_violations.log\n\n";
    }
    if ($temp_line =~ /native_1801/) {
      print OUTFILE "set_lowpower_option -exclude_single_pwr_and_single_gnd_at_missing_csn_macro\n";
      print OUTFILE "set_lowpower_option -witness_limit 0\n";
    }
    print OUTFILE $temp_line;
  }
  close(INFILE);
  close(OUTFILE);
  system("mv -f tempfile $CLPFile");
}

#########################################################################
# Perform basic modification to all dofiles				#
#########################################################################

my $prior_edit = 0;
my $use_pso = 0;
my $unknown_string = 0;
my $use_genus = 0;
my $found_first_use = 0;
my @FileArray = <*.do>;
foreach my $in_file (@FileArray) {
  chomp($in_file);
  next if ($in_file =~ /clp_pso_check/);
  $prior_edit = `grep "report_summary_show_zero_count" $in_file | wc -l`;
  $use_pso = `grep "commit " $in_file | wc -l`;
  $unknown_string = `grep "No of unknown points =" $in_file | wc -l`;
  $use_genus = `grep "tcl_set_command_name_echo" $in_file | wc -l`;
  $found_first_use = 0;
  open(INFILE,"<$in_file") or die ("Cannot open $in_file");
  open(OUTFILE,">tempfile") or die ("Cannot create tempfile");
  while(<INFILE>) {
    $temp_line = $_;
    $temp_line =~ s/set_dofile_abort exit/set_dofile_abort off/g;
    $temp_line =~ s/^report_black_box$/report_black_box -detail/g;
    $temp_line =~ s/^\s*report_mapped_points$//g;
    $temp_line =~ s/^\s*report_compared_points$//g;
    $temp_line =~ s/^\s*report_compare_data$//g;
    $temp_line =~ s/^\s*report_unmapped_points -extra -unreachable -notmapped$/report_unmapped_points -notmapped/g;
    $temp_line =~ s/genus_fv\/rtl_to_fv_map\.log/rtl_to_int.log/;
    $temp_line =~ s/genus_fv\/hier_rtl_to_fv_map\.do/hier_rtl_to_int.do/;
    $temp_line =~ s/set_undriven_signal 0 -golden/set_undriven_signal 0 -both/ if ($in_file =~ /rtl/);
    if ($prior_edit == 0) {
      if ($temp_line =~ /set_dofile_abort/) {
	print OUTFILE "set_mapping_method -noreport_unreach -report_summary_show_zero_count\n";
      }
      if ($temp_line =~ /report_black_box/) {
	print OUTFILE "set_cpu_limit 72 -hours -walltime\n";
      }
      if ($temp_line =~ /set_compare_options/) {
	print OUTFILE "set_hdl_options -v_to_vd on\n";
      }
      if ($in_file =~ /rtl/) {
	if ($temp_line =~ /read_design/) {
	  $temp_line =~ s/ERROR/Error/g;
	}
	if ($temp_line =~ /nodff_to_dlat_feedback/) {
	  print OUTFILE "set_flatten_model -hier_seq_merge\n";
	}
	if ($temp_line =~ /set_undriven_signal/) {
	  print OUTFILE "set_mapping_method -sensitive\n";
	}
      }
      if (($in_file =~ /rtl/) && ($use_genus != 0)) {
	if ($temp_line =~ /uniquify -all -nolib -golden/) {
	  print OUTFILE "add_renaming_rule ungroup_ren \"/\" \"_\" -both\n";
	  print OUTFILE "uniquify -all -nolib -golden -use_renaming_rules\n";
	  print OUTFILE "delete_renaming_rule ungroup_ren\n";
	  $temp_line =~ s/uniquify -all -nolib -golden//;
	}
      }
    }
    if ($use_pso > 0) {
      $temp_line =~ s/${core}_syn_$core\.cpf/${core}_syn.cpf/g;
    }
    print OUTFILE $temp_line;
    if (($temp_line =~ /No of diff points/) && ($prior_edit == 0) && ($unknown_string == 0)) {
      print OUTFILE "puts \"No of compare points = [get_compare_points -count]\"\n";
      print OUTFILE "puts \"No of abort points   = [get_compare_points -abort -count]\"\n";
      print OUTFILE "puts \"No of unknown points = [get_compare_points -unknown -count]\"\n";
    }
  }
  close(INFILE);
  close(OUTFILE);
  system("mv -f tempfile $in_file");
}

