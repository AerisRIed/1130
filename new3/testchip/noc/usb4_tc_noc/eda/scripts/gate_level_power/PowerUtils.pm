#!/usr/bin/env perl

#
#  +---------------------------------------------------------------------------------------------+
#  |          Copyright (c) 2009-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        |
#  |   These coded instructions, statements, and computer programs are the                       |
#  |   copyrighted works and confidential proprietary information of Cadence Design Systems Inc. |
#  |   They may not be modified, copied, reproduced, distributed, or disclosed to                |
#  |   third parties in any manner, medium, or form, in whole or in part, without                |
#  |   the prior written consent of Cadence Design Systems Inc.                                  |
#  +---------------------------------------------------------------------------------------------+
#   

use File::Spec;
use Getopt::Long;

sub parseOptions {
    my ($options) = (@_);
    @command_line = @ARGV;
    #%option = ();              # clear out previous value (if any)
    GetOptions(\%option, @$options);
}

#---------------------------------------------------------------------------
#            --- Utility Functions for Option Checking ---
#---------------------------------------------------------------------------
sub optionDisabled {
    my ($name) = @_;
    (defined $option{$name} && !$option{$name}) ? 1 : 0;
}
sub optionEnabled {
    my ($name) = @_;
    (defined $option{$name} && $option{$name}) ? 1 : 0;
}
sub optionOn {
    my ($name) = @_;
    (defined $option{$name}) ? 1 : 0;
}
sub optionOff {
    my ($name) = @_;
    (!defined $option{$name}) ? 1 : 0;
}
sub optionZero {
    my ($name) = @_;
    (defined $option{$name} && $option{$name} == 0) ? 1 : 0;
}
sub optionEmpty {
    my ($name) = @_;
    (defined $option{$name} && !$option{$name}) ? 1 : 0;
}
sub setOption {
    my ($name, $value) = @_;
    $option{$name} = $value;
}
sub getOption {
    $option{$_[0]};
}

sub commandLine {
    @command_line;
}

sub parseTestList {
  my($test_list) = @_;

  $test_list = rel2abs($test_list);
  open (TESTLIST, $test_list) ||
    die ("Can not open file $test_list\n");
  my @list;
  while(<TESTLIST>) {
    chomp;
    $_ =~ s/\#.*$//;
    $_ =~ s/^[\s]+//;
    $_ =~ s/[\s]+$//;
    next if ($_ =~ /^\s*$/);
    my ($test_name, $norun) = split(/\!/, $_);
    $test_name =~ s/[\s]+$//;
    push(@list, $test_name) unless $norun;
  }
  close TESTLIST;
  return @list;
}

sub expandTestList {
  my $resultsDir = shift @_;
  my @l = ();
  foreach (@_) {
    push(@l, expandTest($resultsDir, $_));
  }
  @l;
}

sub expandTest {
  # test can specify only part of the hierarchy in which case we
  # need to find all diags in the sub-tree
  my ($resultsDir, $test_name) = @_;
  my @l;
  my($leaf, @subdirs) = findDiag($test_name, $resultsDir);
  if ($leaf) {
    # add diag to list
    push(@l,$test_name);
  } else {
    # Run recursively
    foreach my $dir (sort @subdirs) {
      my $x = catdir($resultsDir, $test_name, $dir);
      if (-d $x && !-l $x) {
        push(@l, expandTest($resultsDir, "$test_name/$dir"));
      }
    }
  }
  @l;
}

sub findDiag {
  my ($test_name, $resultsDir) = @_;
  my $ret = 0;
  my @files;
  my $dir = catdir($resultsDir, $test_name);
  unless (-d $dir) {
    print "Error: Diag directory not found, skipping power analysis/optimization for any diags below the following: $dir\n";
    return;
  }
  $ret = 1 if (-r "$dir/*.run");
  if ( !opendir DIAGDIR, $dir) {
    die("cannot open directory $dir: $!\n");
    return(-1);
  }
  while ( $_ = readdir DIAGDIR ) {
    next if /^$/ ;
    next if /^\./ ;
    next if /^sim$/ ;
    next if /^include$/ ;
    next if /^results$/ ;
    next if /^Makefile$/ ;
    push(@files, $_);
  }
  closedir DIAGDIR;
  ($ret, @files);
}

sub tclSetload {
  my ($inLoad,$outLoad,$use_dc) = @_;
  open INLOAD,"<$inLoad" or die "Can't open input setload file $inLoad : $!\n";
  open OUTLOAD,">$outLoad" or die "Can't create output setload file $outLoad : $!\n";
  my $line = 0;
  while (<INLOAD>) {
    if ($_ =~ /^set_load\s+-su\s+(\S+)\s+all_connected\(find\((\S+),\s+"(\S+)"/) {
      print OUTLOAD "set_load $1 [all_connected [find $2 \"${3}\"]]\n";
      $line++;
    } elsif ($_ =~ /^set_load\s+(\S+)\s+find\((\S+),\s+"(\S+)"/) {
      print OUTLOAD "set_load $1 [find $2 \"${3}\"]\n";
      $line++;
    } elsif ($_ =~ /^set_load\s+(\S+)\s+"(\S+)"/) {
      print OUTLOAD "set_load $1 \"${2}\"\n";
      $line++;
    } elsif ($_ =~ /^(\S+)\s+([\d\.]+)\s*$/) {
      if ($use_dc) {
	print OUTLOAD "set_load $2 [find net \"$1\"]\n";
      } else {
        my $net = $1;
        my $load = $2;
        if ($net =~ /\//) {
          print OUTLOAD "set_load $load [get_nets \"$net\"]\n";
        } else {
          print OUTLOAD "set_load $2 /designs/\$TOP_DESIGN/nets/$1\n";
        }
      }
      $line++;
    } elsif ($_ =~ /^set_load\s+(\S+)\s+\[get_nets\s+["{]*([\w\.\/\[\]]+)["}]*\s*\]/) {
      if ($use_dc) {
        print OUTLOAD $_;
      } else {
        my $net = $2;
        my $load = $1;
        if ($net =~ /\//) {
          print OUTLOAD $_;
        } else {
          print OUTLOAD "set_load $load /designs/\$TOP_DESIGN/nets/$net\n";
        }
      }
      $line++;
    } elsif (($_ =~ /^set_load 0.0 \[/) && ($use_dc == 0)) {
      $line++;
    }
  }
  close INLOAD;
  close OUTLOAD;
  return $line;
}

sub MPtclSetload {
  my ($inLoad,$outLoad) = @_;
  open INLOAD,"<$inLoad" or die "Can't open input setload file $inLoad : $!\n";
  open OUTLOAD,">$outLoad" or die "Can't create output setload file $outLoad : $!\n";
  my $line = 0;
  while (<INLOAD>) {
    $_ =~ s/get_nets/get_nets -hier/;
    print OUTLOAD $_;
    $line++;
  }
  close INLOAD;
  close OUTLOAD;
  return $line;
}

sub convertPowerUnit {
  my ($unit,$value) = @_;
  for (my $i=0;$i<=$#$unit;$i++) {
    SWITCH : {
      if ($unit->[$i] eq  "W") {$value->[$i] = sprintf("%${main::tot_digit}.${main::sig_digit}f",($value->[$i] * 1000));           last SWITCH;}
      if ($unit->[$i] eq "mW") {$value->[$i] = sprintf("%${main::tot_digit}.${main::sig_digit}f",($value->[$i] * 1));              last SWITCH;}
      if ($unit->[$i] eq "uW") {$value->[$i] = sprintf("%${main::tot_digit}.${main::sig_digit}f",($value->[$i] * 0.001));          last SWITCH;}
      if ($unit->[$i] eq "nW") {$value->[$i] = sprintf("%${main::tot_digit}.${main::sig_digit}f",($value->[$i] * 0.000001));       last SWITCH;}
      if ($unit->[$i] eq "pW") {$value->[$i] = sprintf("%${main::tot_digit}.${main::sig_digit}f",($value->[$i] * 0.000000001));    last SWITCH;}
      if ($unit->[$i] eq "fW") {$value->[$i] = sprintf("%${main::tot_digit}.${main::sig_digit}f",($value->[$i] * 0.000000000001)); last SWITCH;}
    }
  }
}

sub convertTimeUnit {
  my ($value,$unit) = @_;
  SWITCH: {
     if ($unit eq "ms") {$value *= 1000000; last SWITCH;}
     if ($unit eq "us") {$value *= 1000; last SWITCH;}
     if ($unit eq "ns") {$value *= 1; last SWITCH;}
     if ($unit eq "ps") {$value *= 0.001; last SWITCH;}
     if ($unit eq "fs") {$value *= 0.000001; last SWITCH;}
  }
  return $value;
}

sub printCopyright {
  my $year = 2025;
  my $copyRight = <<EOT;
#
#  +---------------------------------------------------------------------------------------------+
#  |          Copyright (c) $year by Cadence Design Systems Inc. ALL RIGHTS RESERVED.            |
#  |   These coded instructions, statements, and computer programs are the                       |
#  |   copyrighted works and confidential proprietary information of Cadence Design Systems Inc. |
#  |   They may not be modified, copied, reproduced, distributed, or disclosed to                |
#  |   third parties in any manner, medium, or form, in whole or in part, without                |
#  |   the prior written consent of Cadence Design Systems Inc.                                  |
#  +---------------------------------------------------------------------------------------------+
#
EOT
  return $copyRight;
}

sub readConcatFileFromGenus {
  my ($concat,$diag_hash) = @_;
  open(CONCAT,"<$concat") or die ("Cannot open concat file $concat : $!\n");
  my $diag_count = 0;
  my $pso_present = 0;
  my $power = {};
  $power->{"tool"} = "genus";
  my $local_tcf_name = ($main::UseVCD) ? "verilog.vcd" : "saif_gate_toggle_file";
  my ($netUnits,$cellUnits,$leakUnits,$totUnits);
  my ($netPower,$cellPower,$leakPower,$totPower);
  while (<CONCAT>) {
    if ($_ =~ /\+\+\+\+\+\+\+\+\+\+\+\+\+\+/) {
      $_ = <CONCAT>;
      chomp(my $diag_name = $_);
      $diag_name =~ s/\//_/g;
      $diag_name =~ s/\s+//g;
      $diag_name =~ s/${main::modified_resultsdir}_//;
      $diag_name =~ s/_${local_tcf_name}//;
      if (defined $diag_hash->{$diag_name}) {
        $_ = <CONCAT>;
        $diag_count++;
        my $outFile = $diag_name . ".power_report";
        open(POWEROUT,">$outFile") or die ("Cannot create power_report file $outFile : $!\n");
        until ($_ =~ /^\s*${main::design}/) {
	  if ($_ =~ /^\s+Instance\s+Domain\s+Cells\s+Power\((\S+)\)\s+Power\((\S+)\)\s+Power\((\S+)\)\s+Power\((\S+)\)\s+Power\((\S+)\)/) {
	    $leakUnits = $1;
	    $cellUnits = $2;
	    $netUnits = $3;
	    $totUnits = $5;
	    $pso_present = 1;
	  } elsif ($_ =~ /^\s+Instance\s+Cells\s+Power\((\S+)\)\s+Power\((\S+)\)\s+Power\((\S+)\)\s+Power\((\S+)\)\s+Power\((\S+)\)/) {
	    $leakUnits = $1;
	    $cellUnits = $2;
	    $netUnits = $3;
	    $totUnits = $5;
	    $pso_present = 0;
	  }
          print POWEROUT $_;
          $_ = <CONCAT>;
        }
	my @a = split /\s+/;
	if ($pso_present) {
	  $leakPower = $a[3];
	  $cellPower = $a[4];
	  $netPower  = $a[5];
	  $totPower  = $a[7];
	} else {
	  $leakPower = $a[2];
	  $cellPower = $a[3];
	  $netPower  = $a[4];
	  $totPower  = $a[6];
	}
        my @unitArray  = ($netUnits,$cellUnits,$leakUnits,$totUnits);
        my @valueArray = ($netPower,$cellPower,$leakPower,$totPower);
        convertPowerUnit(\@unitArray,\@valueArray);
        push @{$power->{"diags"}}, $diag_name;
        $power->{$diag_name}{net}   = $valueArray[0];
        $power->{$diag_name}{cell}  = $valueArray[1];
        $power->{$diag_name}{leak}  = $valueArray[2];
        $power->{$diag_name}{total} = $valueArray[3];
        $power->{$diag_name}{freq}  = $diag_hash->{$diag_name}{freq};
        until ($_ =~ /\+\+\+\+\+\+\+\+\+\+\+\+\+\+/) {
          print POWEROUT $_;
          $_ = <CONCAT>;
        }
        close(POWEROUT);
      }
    }
  }
  close(CONCAT);
  return $power;
}

sub readConcatFileFromVoltus {
  my ($diag_hash,$power) = @_;
  my @FileArray = <*.power_report>;
  my $diag_name = "";
  $power->{"tool"} = "voltus";
  my $PowerUnits;
  my $boundary_leakage = 0;
  my ($netPower,$cellPower,$leakPower,$boundaryPower,$totPower);
  foreach my $fn (sort @FileArray) {
    $fn =~ /(\S+)\.power_report$/;
    $diag_name = $1;
    if (defined $diag_hash->{$diag_name}) {
      open(INFILE,"<$fn") or die ("Cannot open power report file $fn : $!\n");
      while (<INFILE>) {
	if ($_ =~ /Boundary_Gate_Leakage/) {
	  $boundary_leakage = 1 ;
	  last;
	}
      }
      close(INFILE);
      $power->{"boundary_leakage"} = $boundary_leakage;

      open(INFILE,"<$fn") or die ("Cannot open power report file $fn : $!\n");
      while (<INFILE>) {
	until ($_ =~ /^Instance/) {
	  if ($_ =~ /\s+Power\s+Units\s+=\s+[0-9]+\s*(\S+)/) {
	    $leakUnits = $cellUnits = $netUnits = $totUnits = $1;
	  }
          if ($boundary_leakage == 1) {
            if (($_ =~ /^Total\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+\S+\s*$/) && ($_ !~ /excluding\s+duplicates/)) {
              $cellPower = $1;
              $netPower = $2;
              $leakPower = $3;
              $boundaryPower = $4;
              $totPower = $5;
            }
          } else {
	    if (($_ =~ /^Total\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+\S+\s*$/) && ($_ !~ /excluding\s+duplicates/)) {
	      $cellPower = $1;
	      $netPower = $2;
	      $leakPower = $3;
	      $totPower = $4;
	    }
	  }
	  $_ = <INFILE>;
	}
	last;
      }
      close(INFILE);
      if ($boundary_leakage == 1) {
        my @unitArray = ($netUnits,$cellUnits,$leakUnits,$boundaryUnits,$totUnits);
        my @valueArray = ($netPower,$cellPower,$leakPower,$boundaryPower,$totPower);
        convertPowerUnit(\@unitArray,\@valueArray);
        push @{$power->{"diags"}}, $diag_name;
        $power->{$diag_name}{net}   = $valueArray[0];
        $power->{$diag_name}{cell}  = $valueArray[1];
        $power->{$diag_name}{leak}  = $valueArray[2];
        $power->{$diag_name}{boundary_leak}  = $valueArray[3];
        $power->{$diag_name}{total} = $valueArray[4];
        $power->{$diag_name}{freq}  = $diag_hash->{$diag_name}{freq};
      } else {
        my @unitArray = ($netUnits,$cellUnits,$leakUnits,$totUnits);
        my @valueArray = ($netPower,$cellPower,$leakPower,$totPower);
        convertPowerUnit(\@unitArray,\@valueArray);
        push @{$power->{"diags"}}, $diag_name;
        $power->{$diag_name}{net}   = $valueArray[0];
        $power->{$diag_name}{cell}  = $valueArray[1];
        $power->{$diag_name}{leak}  = $valueArray[2];
        $power->{$diag_name}{total} = $valueArray[3];
        $power->{$diag_name}{freq}  = $diag_hash->{$diag_name}{freq};
      }
    }
    if ($main::hierarchical) {
      my $diag_power = getVoltusPowerReport($fn);
      my $hier_report_file = "$fn.hier";
      generateHierarchicalPowerReport($diag_power, $hier_report_file);
    }
  }
  return $power;
}

sub readConcatFileFromJoules {
  my ($diag_hash) = @_; 
  my @FileArray = <*.report_power.rpt>;
  my $diag_name = ""; 
  my $power = {}; 
  $power->{"tool"} = "Joules";
  my $PowerUnits;
  my ($netPower,$cellPower,$leakPower,$totPower);
  foreach my $fn (sort @FileArray) {
    $fn =~ /(\S+)\.report_power.rpt$/;
    $diag_name = $1; 
    if (defined $diag_hash->{$diag_name}) {
      open(INFILE,"<$fn") or die ("Cannot open power report file $fn : $!\n");
      while (<INFILE>) {
        if ($_ =~ /^Power Unit:\s+(\S+)/) {
          $leakUnits = $cellUnits = $netUnits = $totUnits = $1; 
        }   
        if ($_ =~ /^\s+Subtotal\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+\S+/) {
          $cellPower = $2; 
          $netPower = $3; 
          $leakPower = $1; 
          $totPower = $4; 
        }   
      }   
      close(INFILE);
      my @unitArray = ($netUnits,$cellUnits,$leakUnits,$totUnits);
      my @valueArray = ($netPower,$cellPower,$leakPower,$totPower);
      convertPowerUnit(\@unitArray,\@valueArray);
      push @{$power->{"diags"}}, $diag_name;
      $power->{$diag_name}{net}   = $valueArray[0];
      $power->{$diag_name}{cell}  = $valueArray[1];
      $power->{$diag_name}{leak}  = $valueArray[2];
      $power->{$diag_name}{total} = $valueArray[3];
      $power->{$diag_name}{freq}  = $diag_hash->{$diag_name}{freq};
    }   
  }
  return $power;
}

sub printPowerSummary {
  my ($summaryFile,$power) = @_;
  printPowerSummaryForCadence($summaryFile,$power);
}

sub printPowerSummaryForCadence {
  my ($summaryFile,$power) = @_;
  my $ToolName ;
  if ($power->{"tool"} eq "genus") {
    $ToolName = "Genus";
  } elsif ($power->{"tool"} eq "Joules") {
    $ToolName = "Joules";
  } else {
    $ToolName =  "Voltus";
  }
  if ($power->{"boundary_leakage"} == 1) {
    open(SUMMARY,">$summaryFile") or die ("Cannot create summary report $summaryFile : $!\n");
    print SUMMARY "                              Power Analysis Summary Report Using $ToolName\n\n";
    print SUMMARY "                                Note: all power numbers are in mW\n\n";
    printf SUMMARY "%-30s %-12s%-15s%-15s%-18s%-27s%-15s\n","Diag","Frequency","Net Power","Cell Power","Leakage Power","Boundary Leakage Power","Total Power";
    print SUMMARY "---------------------------------------------------------------------------------------------------------------------------------\n";
    my $diagCount = 0;
    my $totPower = 0;
    foreach my $diag (@{$power->{"diags"}}) {
      my $q = $power->{$diag};
      printf SUMMARY "%-30s %-12s%-15s%-15s%-18s%-27s%-15s\n",$diag,"$q->{freq} MHz",$q->{net},$q->{cell},$q->{leak},$q->{boundary_leak},$q->{total};
      $diagCount++;
      $totPower += $q->{total};
    }
    my $avePower = ($diagCount != 0) ? sprintf("%${main::tot_digit}.${main::sig_digit}f",$totPower/$diagCount) : 0;
    print SUMMARY "\n\nAverage Total Power = $avePower\n";
    close(SUMMARY);
  } else {
    open(SUMMARY,">$summaryFile") or die ("Cannot create summary report $summaryFile : $!\n");
    print SUMMARY "                              Power Analysis Summary Report Using $ToolName\n\n";
    print SUMMARY "                                Note: all power numbers are in mW\n\n";
    printf SUMMARY "%-30s %-12s%-15s%-15s%-18s%-15s\n","Diag","Frequency","Net Power","Cell Power","Leakage Power","Total Power";
    print SUMMARY "-----------------------------------------------------------------------------------------------------\n";
    my $diagCount = 0;
    my $totPower = 0;
    foreach my $diag (@{$power->{"diags"}}) {
      my $q = $power->{$diag};
      printf SUMMARY "%-30s %-12s%-15s%-15s%-18s%-15s\n",$diag,"$q->{freq} MHz",$q->{net},$q->{cell},$q->{leak},$q->{total};
      $diagCount++;
      $totPower += $q->{total};
    }
    my $avePower = ($diagCount != 0) ? sprintf("%${main::tot_digit}.${main::sig_digit}f",$totPower/$diagCount) : 0;
    print SUMMARY "\n\nAverage Total Power = $avePower\n";
    close(SUMMARY);
  }
}

sub readPowerTable {
  my ($file) = @_;
  my $power = {};
  my $powerUnits;
  my $boundary_leakage = 0;
  my $diag;
  my ($netUnits,$cellUnits,$leakUnits,$boundaryUnits,$totUnits);
  my ($netPower,$cellPower,$leakPower,$boundaryPower,$totPower);
  my $freq = 0;
  open(PWR, "<", "$file");
  while(<PWR>){
    if($_ =~ /Note:\s+all\s+power\s+numbers\s+are\s+in\s+(\S+)/){
      $powerUnits = $1;
    }
    elsif($_ =~ /Diag.*Frequency\s+Net\s+Power\s+Cell\s+Power\s+Leakage\s+Power\s+Boundary\s+Leakage\s+Power\s+Total\s+Power/){ $boundary_leakage = 1; }
    elsif($_ =~ /Diag.*Frequency\s+Net\s+Power\s+Cell\s+Power\s+Leakage\s+Power\s+Total\s+Power/){ $boundary_leakage = 0; }
    elsif($boundary_leakage == 1 && ($_ =~ /(\S+)\s+(\S+)\s+\S+\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/)){
      $netUnits = $cellUnits = $leakUnits = $boundaryUnits = $totUnits = $powerUnits;
      $diag = $1; $freq = $2;
      $netPower = $3;
      $cellPower = $4;
      $leakPower = $5;
      $boundaryPower = $6;
      $totPower = $7;
      my @unitArray = ($netUnits,$cellUnits,$leakUnits,$boundaryUnits,$totUnits);
      my @valueArray = ($netPower,$cellPower,$leakPower,$boundaryPower,$totPower);
      convertPowerUnit(\@unitArray,\@valueArray);
      push @{$power->{"diags"}}, $diag;
      $power->{$diag}{net}   = $valueArray[0];
      $power->{$diag}{cell}  = $valueArray[1];
      $power->{$diag}{leak}  = $valueArray[2];
      $power->{$diag}{boundary_leak}  = $valueArray[3];
      $power->{$diag}{total} = $valueArray[4];
      $power->{$diag}{freq}  = $freq;
    }
    elsif($boundary_leakage == 0 && ($_ =~ /(\S+)\s+(\S+)\s+\S+\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/)){
      $netUnits = $cellUnits = $leakUnits = $totUnits = $powerUnits;
      $diag = $1; $freq = $2;
      $netPower = $3;
      $cellPower = $4;
      $leakPower = $5;
      $totPower = $6;
      my @unitArray = ($netUnits,$cellUnits,$leakUnits,$totUnits);
      my @valueArray = ($netPower,$cellPower,$leakPower,$totPower);
      convertPowerUnit(\@unitArray,\@valueArray);
      push @{$power->{"diags"}}, $diag;
      $power->{$diag}{net}   = $valueArray[0];
      $power->{$diag}{cell}  = $valueArray[1];
      $power->{$diag}{leak}  = $valueArray[2];
      $power->{$diag}{total} = $valueArray[3];
      $power->{$diag}{freq}  = $freq;
    }
    elsif($_ =~ /Average Total Power/){ last; }
  }
  close(PWR);
  return $power;
}

sub getVoltusPowerReport {
  my ($report) = @_;
  my %power = ();
  open REPORT, "$report" or return \%power;
  while (<REPORT>) {
    if (/^Instance/) {
      $_ = <REPORT>;
      $_ = <REPORT>;
      last;
    }
  }
  my $count = 0;
  while (<REPORT>) {
    if (($count != 0) && ($count % 1E6) == 0) {
      print "Read $count lines ...\n";
    }
    $count++;
    last if (/-----/);
    my @a = split /\s+/;
    my $inst = $a[0];
    my @a = split /\s+/;
    $power{$inst} = {
      "internal" => $a[3],
      "net"      => $a[4],
      "dyn"      => $a[3] + $a[4],
      "leak"     => $a[5],
    };
  }
  close REPORT;
  return \%power;
}

sub generateHierarchicalPowerReport {
  my ($diag_power, $output_file) = @_;
  my %total_power = ();
  my %hier = ();
  my $length = 0;
  foreach my $inst (keys %{$diag_power}) {
    my @a = split /\//, $inst;
    my $top_parent_module = $a[0];
    my @parent_modules = ($#a >= 1) ? @a[0..$#a-1] : qw(top);
    my $hier_module = ($#a >= 1) ? join "/", @parent_modules : $inst;
    foreach my $i (0..$#parent_modules) {
      my $hier_module_path = (@parent_modules) ? join "/", @parent_modules[0..$i] : "top";
      $hier{$hier_module_path}{internal} += $diag_power->{$inst}{internal};
      $hier{$hier_module_path}{net}      += $diag_power->{$inst}{net};
      $hier{$hier_module_path}{dyn}      += $diag_power->{$inst}{dyn};
      $hier{$hier_module_path}{leak}     += $diag_power->{$inst}{leak};
      $length = length($hier_module_path) if ((length($hier_module_path) >= $length) && ($hier_module_path !~ /(genus_inserted_cg|rtl_arch_cg|data_gate)/));
    }
    $total_power{internal}        += $diag_power->{$inst}{internal};
    $total_power{net}             += $diag_power->{$inst}{net};
    $total_power{dyn}             += $diag_power->{$inst}{dyn};
    $total_power{leak}            += $diag_power->{$inst}{leak};
  } # foreach $inst 
  my @all_modules = keys %hier;

  $length += 10;
  my $total_length = $length + 65;
  open OUT, ">$output_file" or return;
  printf OUT "%-${length}s %10s %10s %10s (%7s) %10s (%7s)\n", " Design", "Internal", "Switching", "Dynamic", "%", "Leak", "%";
  print  OUT "-" x $total_length, "\n";
  my $percent_dyn  = ($total_power{dyn}  != 0) ? sprintf("%.2f%%", $total_power{dyn} /$total_power{dyn}*100)  : "N/A";
  my $percent_leak = ($total_power{leak} != 0) ? sprintf("%.2f%%", $total_power{leak}/$total_power{leak}*100) : "N/A";
  printf OUT "%-${length}s %10.5f %10.5f %10.5f (%7s) %10.5f (%7s)\n", " ${main::design}", $total_power{internal}, $total_power{net}, $total_power{dyn}, $percent_dyn, $total_power{leak}, $percent_leak;

  foreach my $hier_module (sort keys %hier) {
    next if (($hier_module eq "top") || ($hier_module =~ /(genus_inserted_cg|rtl_arch_cg|data_gate)/));
    my @a = split /\//, $hier_module;
    my $spaces = join "", map("  ", 0..$#a);
    $percent_dyn  = ($total_power{dyn}  != 0) ? sprintf("%.2f%%", $hier{$hier_module}{dyn} /$total_power{dyn}*100)  : "N/A";
    $percent_leak = ($total_power{leak} != 0) ? sprintf("%.2f%%", $hier{$hier_module}{leak}/$total_power{leak}*100) : "N/A";
    printf OUT "%-${length}s %10.5f %10.5f %10.5f (%7s) %10.5f (%7s)\n", "${spaces}$a[$#a]", $hier{$hier_module}{internal}, $hier{$hier_module}{net}, $hier{$hier_module}{dyn}, $percent_dyn, $hier{$hier_module}{leak}, $percent_leak;
  }
  close OUT; 
}

1;
