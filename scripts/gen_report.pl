#!/usr/bin/perl -w

use strict;
use warnings;

use Getopt::Long;   #extract options from command line
use Pod::Usage;
use File::Find;
use Cwd;

my $regression_dir = cwd;
my %jobs ;
my $case_max_l = 50;
my $case;
my $seed;
my $total_time;
my $status_excel_file;
my $dir_line;

if($regression_dir =~ /.*\/out-([0-9\-]*\b).*/) {
    $status_excel_file = "batch_".$1.".csv";
}

open CSV_FILE, ">$status_excel_file" or die "";
printf CSV_FILE "%s, %s, RESULT, MEMORY,CPU_USAGE,CPU_TIME,CONFIGURATION ARGUMETS\n",&fill_string("NAME",$case_max_l),&fill_string("SEED",8);
close CSV_FILE;
opendir DIR_FILE, $regression_dir or die"";
print "$regression_dir\n";
while($dir_line = readdir DIR_FILE) {
    chomp($dir_line);

    next unless $dir_line=~ /^cdn.*_r\d+$/ and -d "$regression_dir/$dir_line";
    
    if(-e "$regression_dir/$dir_line/xrun.log"){
    open RUN_LOG, "$regression_dir/$dir_line/xrun.log";
        while(<RUN_LOG>){
            if($_ =~ /\+SVSEED=(\d+)/){
                $seed = $1;
            }
            if($_ =~ /\+UVM_TESTNAME=(\w+)/){
                $case = $1;
            }
        }
    close RUN_LOG;
    }
    
    $jobs{"name"}   = $case;
    $jobs{"seed"}   = $seed;
    $jobs{"logpath"}= "$regression_dir/$dir_line/xrun.log";
    &chkResult;
    &genReport;
}

!system("gvim $status_excel_file ") or die "";
exit;

sub chkResult{
    my $log           =  "$dir_line/xrun.log";
    $jobs{"result"}   = "";
    $jobs{"reason"}   = "";
    $jobs{"memory"}   = "";
    $jobs{"usage"}    = "";
    $jobs{"time"}     = "";
    my $first_uvm_error = 0;
    if(-e $log) {
        open LOG_FILE , "<$log" or die;
        while(<LOG_FILE>) {
            chomp;
            if(m{^UVM_ERROR\s*:\s*(\d+)}){
                $jobs{"result"}=($1 eq 0)?"passed":"failed";
            }elsif(($first_uvm_error == 0) and m{^UVM_ERROR\s*@\s*(\d+)}xms) {
                $jobs{"reason"}   = $_;
                $first_uvm_error = 1;
            }elsif(m{^UVM_FATAL\s*:\s*(\d+)}) {
                $jobs{"result"}="failed" if (not $1 eq 0);
            }elsif(m{^xmsim:\sCPU\sUsage\.*}xms) {
                my @cpu = split / /,$_;
                if($cpu[12] =~m{^\((.*)\,$}xms) {
                    $jobs{"time"} = $1;
                    my $ct=$1 if($1 =~/(\d+).*/);
                    $total_time+= $1 if($1 =~/(\d+).*/);
                }
                $jobs{"usage"} = $cpu[13];
            }
        }
    }
    else{
        print "Missing log file to check..";
        $jobs{"result"} = "failed";
        $jobs{"reason"} = "can't run";
    }
}

sub fill_string($$){
    my $str=shift;
    my $max_len=shift;
    for(my $cnt=int(length($str));$cnt<$max_len;$cnt++){
        $str.=" ";
    }
    return $str;
}

sub genReport {
    chdir ($regression_dir);
    open CSV_FILE, ">>$status_excel_file" or die "";
    printf CSV_FILE "%s, %s, %s, %s, %s, %s, %s, %s\n", &fill_string($jobs{"name"},$case_max_l), 
                                                    &fill_string($jobs{"seed"},8),
                                                    $jobs{"result"}, 
                                                    &fill_string($jobs{"memory"},7), 
                                                    &fill_string($jobs{"usage"},6), 
                                                    &fill_string($jobs{"time"},8),
                                                    $jobs{"logpath"},
                                                    $jobs{"reason"};
    close CSV_FILE;
}
