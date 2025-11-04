#!/usr/bin/env perl

#############################################################################################
#        Copyright (c) 2006-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

################################################################################
# Filename: Error_Check.pl                                                     #
# Objective: Search for error messages in the tool-generated log file, and     #
#            shows them if it finds any                                        #
# Input: Tool-generated log-file and other flow-related information            #
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
my @allowed_tools = qw(dc genus innovus qrc tempus voltus);

################################################################################
# read in the options                                                          #
################################################################################
my $help = 0;
my $log  = "";
my $flow = "";
my $tool = "";
my $timing = "";
my $string = "Error:";

my $usage = <<USAGE;
  $0 [options]

  This script checks the tool-generated log-file for any harmful error/warning
  messages. If it finds any such messages, it stops the flow.

  -log  <logfile>   Path to the tool-generated log-file.
  -flow <name>      Name of the make flow that generated this logfile.
  -tool <toolname>  Name of the tool that is being run. Supported values:
                    dc, genus (default), innovus, qrc, tempus, voltus
USAGE

my $ret = GetOptions(
  "help"      => \$help,
  "log=s"     => \$log,
  "flow=s"    => \$flow,
  "tool=s"    => \$tool,
  "timing"    => \$timing,
);

checkOptions();
my $err = checkLog($log, $tool);
if (@{$err}) {
  print "ERROR: Your \"make $flow\" run exited with errors.\n";
  print "ERROR: Please check the log file $log and search for \"$string\".\n";
  exit(1);
}

##################################
# Subroutines
##################################
sub checkOptions {
  if ($help || ! $ret) {
    print $usage;
    exit;
  }
  
  if (! -e $log) {
    print "Error: the log file $log doesn't exist.\n";
    print "Error: Please specify a valid log file.\n";
    exit(1);
  }
  unless (grep /$tool/, @allowed_tools) {
    print "Error: \"$tool\" is not a supported value for -tool option.\n";
    print "Error: Please specify one of \n";
    print "Error: \t", join(", ", @allowed_tools), "\n";
    exit(1);
  }
}

sub checkLog {
  my ($file, $tool) = @_;
  my $err = ($tool eq "dc")      ? checkDCLog($file)      :
            ($tool eq "genus")   ? checkGenusLog($file)   : 
            ($tool eq "innovus") ? checkInnovusLog($file) :
            ($tool eq "qrc")     ? checkQRCLog($file)     :
            ($tool eq "tempus")  ? checkInnovusLog($file) :
            ($tool eq "voltus")  ? checkInnovusLog($file) :
                                   checkGenusLog($file);
  return $err;
}

sub checkDCLog {
  my ($file) = @_;
  my @err = ();
  open LOG, "$file" or return \@err;
  while (<LOG>) {
    if (/Error:/) {
      push @err, [$., $_];
    }
  } # <LOG>
  close LOG;
  return \@err;
}

sub checkGenusLog {
  my ($file) = @_;
  my @err = ();
  open LOG, "$file" or return \@err;
  while (<LOG>) {
    if (/Error   :/ || /ERROR:/) {
      unless (/ENCLF-223/ || /IMPLF-223/ || /IMPESI-2005/ || /TA-1014/ || /IMPSP-377/ || /IMPSP-2021/) {
	push @err, [$., $_];
      }
    }
  } # <LOG>
  close LOG;
  $string = "'Error   :' or 'ERROR:'";
  return \@err;
}

sub checkInnovusLog {
  my ($file) = @_;
  my @err = ();
  open LOG, "$file" or return \@err;
  while (<LOG>) {
    if (/ERROR:/) {
      unless (/TA-1014/ || /IMPPTN-1604/ || /IMPSP-2021/) {
        push @err, [$., $_];
      }
    }
  } # <LOG>
  close LOG;
  $string = "ERROR:";
  return \@err;
}

sub checkQRCLog {
  my ($file) = @_;
  my @err = ();
  open LOG, "$file" or return \@err;
  while (<LOG>) {
    if (/EXTGRMP-395/) {
      push @err, [$., $_];
    }
  } # <LOG>
  close LOG;
  $string = "EXTGRMP-395";
  return \@err;
}
