#!/usr/bin/perl
# +---------------------------------------------------------------------------+
# |  Copyright (c) 2013-2025 Cadence Design Systems Inc. ALL RIGHTS RESERVED. |
# |                                                                           |
# |   These coded instructions, statements, and computer programs             |
# |   are the copyrighted works and confidential proprietary                  |
# |   information of Tensilica Inc.  They may not be modified,                |
# |   copied, reproduced, distributed, or disclosed to third                  |
# |   parties in any manner, medium, or form, in whole or in part,            |
# |   without the prior written consent of Tensilica Inc.                     m
# +---------------------------------------------------------------------------+

use lib ('./lib');
use Params;
use Cwd; 
use List::Util qw(min max);
use strict;
use warnings;

my $IPG_WKAREA = $ENV{IPG_WKAREA};
my $ip_file = $cfg_dir."/spa_tests.csv";
my $op_file = $cfg_dir."/spa_runs";
open(IP_FILE, '<', $ip_file) or die "File '$ip_file' can't be opened";
open(OP_FILE, '>', $op_file) or die "File '$op_file' can't be opened";
my $run_cmd="";
my $test_name;
my $test_dir_name;
my $suffix;
my $min_tx;
my $max_tx;
my $rd_req_id_low;
my $rd_req_id_high;
my $wr_req_id_low;
my $wr_req_id_high;
my $ini;
my $tgt;
my $ipc_rw;
my $ipc_len;
my $max_rd_ot;
my $max_wr_ot;
my @fields;
while (my $line = <IP_FILE>) {
	chomp($line);
	next if (($line =~ /^#/) || ($line eq "")); #Skip comments and empty lines in csv file
	@fields = split(/,/, $line); #split fields with commas
	trim_whitespaces(\@fields);
	#First field will always be test name. Next arguments are to be processed separately for each test based onr equirement
	$test_name=$fields[0];
	if($test_name eq 'max_bandwidth_test'){ get_max_bw_test_cmds(); }
	elsif ($test_name eq 'ot_sweep_test'){ get_ot_sweep_test_cmds(); }
	elsif ($test_name eq 'min_latency_test'){ get_min_latency_test_cmds(); }#parameters are exactly same as max bw test. But keeping separate entry of each test to keep it easy to add/remove any parameters for individual test
	else { die "Unable to process for test $test_name";  }
}

sub get_max_bw_test_cmds { #processes further lines to generate max bw test cmds. Returns if it finds new test name
	$ini = $fields[1];
	$tgt = $fields[2];
	$ipc_rw = $fields[3];
	$ipc_len = $fields[4];
	if((! defined $fields[5])||($fields[5] eq '')) { $min_tx=50; } else {$min_tx=$fields[5];}
	if((! defined $fields[6])||($fields[6] eq '')) { $max_tx=$min_tx; } else {$max_tx=$fields[6];}
    if((! defined $fields[7])||($fields[7] eq '')) { $rd_req_id_low=''; } else {$rd_req_id_low=$fields[7];}
	if((! defined $fields[8])||($fields[8] eq '')) { $rd_req_id_high=''; } else {$rd_req_id_high=$fields[8];}
    #If ID range for writes isn't provided separately, writes will use same ID range as that of reads
    if((! defined $fields[9])||($fields[9] eq '')) { $wr_req_id_low=''; } else {$wr_req_id_low=$fields[9];}
	if((! defined $fields[10])||($fields[10] eq '')) { $wr_req_id_high=''; } else {$wr_req_id_high=$fields[10];}
	$test_dir_name=$test_name."_".$ini."_".$tgt."_".$ipc_rw."_LENGTH_".$ipc_len;
	$suffix = $test_name."_".$ini."_".$tgt."_".$ipc_rw;
	$test_dir_name = "+SPA_RUN_NAME=".$test_dir_name;
	$ini = '+STG_IPC_INGRESS='.$ini;
	$tgt = '+STG_IPC_EGRESS='.$tgt;
	$ipc_rw = '+STG_IPC_READWRITE='.$ipc_rw;
	$ipc_len = '+STG_IPC_LENGTH='.$ipc_len;
    $rd_req_id_low = '+STG_IPC_AXI_RD_ID_RANGE_LOW='.$rd_req_id_low if ($rd_req_id_low ne '');
    $rd_req_id_high = '+STG_IPC_AXI_RD_ID_RANGE_HIGH='.$rd_req_id_high if ($rd_req_id_high ne '');
    $wr_req_id_low = '+STG_IPC_AXI_WR_ID_RANGE_LOW='.$wr_req_id_low if ($wr_req_id_low ne '');
    $wr_req_id_high = '+STG_IPC_AXI_WR_ID_RANGE_HIGH='.$wr_req_id_high if ($wr_req_id_high ne '');
	$run_cmd = "$cfg_dir/nocrun -test $test_name -suffix $suffix "; #Even if we have +UVM_TESTNAME, we still need '-test' option in commandline. Adding that before modifying $test_name
	$test_name='+UVM_TESTNAME='.$test_name;
	$run_cmd .= "-plus \" $test_name $test_dir_name $ini $tgt $ipc_rw $ipc_len $rd_req_id_low $rd_req_id_high $wr_req_id_low $wr_req_id_high +CDN_STG_MIN_ITEM_COUNT=$min_tx +CDN_STG_MAX_ITEM_COUNT=$max_tx\"\n";
	print OP_FILE $run_cmd;
	$test_dir_name="";
	$ini="";
	$tgt="";
	$ipc_rw="";
	$ipc_len="";
	$run_cmd="";
}
#Parameters and subroutine is same as thhat of max bw test. If multiple tests have same set of params, will club them and restructure for reuse
sub get_min_latency_test_cmds { #processes further lines to generate max bw test cmds. Returns if it finds new test name
	$ini = $fields[1];
	$tgt = $fields[2];
	$ipc_rw = $fields[3];
	$ipc_len = $fields[4];
	if((! defined $fields[5])||($fields[5] eq '')) { $min_tx=50; } else {$min_tx=$fields[5];}
	if((! defined $fields[6])||($fields[6] eq '')) { $max_tx=$min_tx; } else {$max_tx=$fields[6];}
	$test_dir_name=$test_name."_".$ini."_".$tgt."_".$ipc_rw."_LENGTH_".$ipc_len;
	$suffix = $test_name."_".$ini."_".$tgt."_".$ipc_rw;
	$test_dir_name = "+SPA_RUN_NAME=".$test_dir_name;
	$ini = '+STG_IPC_INGRESS='.$ini;
	$tgt = '+STG_IPC_EGRESS='.$tgt;
	$ipc_rw = '+STG_IPC_READWRITE='.$ipc_rw;
	$ipc_len= '+STG_IPC_LENGTH='.$ipc_len;
	$run_cmd = "$cfg_dir/nocrun -test $test_name -suffix $suffix "; #Even if we have +UVM_TESTNAME, we still need '-test' option in commandline. Adding that before modifying $test_name
	$test_name='+UVM_TESTNAME='.$test_name;
	$run_cmd .= " -plus \" $test_name $test_dir_name $ini $tgt $ipc_rw $ipc_len +CDN_STG_MIN_ITEM_COUNT=$min_tx +CDN_STG_MAX_ITEM_COUNT=$max_tx\"\n";
	print OP_FILE $run_cmd;
	$test_dir_name="";
	$ini="";
	$tgt="";
	$ipc_rw="";
	$ipc_len="";
	$run_cmd="";
}

sub get_ot_sweep_test_cmds {
	$ini = $fields[1];
	$tgt = $fields[2];
	$ipc_rw = $fields[3];
	$max_rd_ot = $fields[4];
	$max_wr_ot = $fields[5];
	if((! defined $fields[6]) || ($fields[6] eq '')) { $min_tx=50; } else {$min_tx=$fields[6];}
	if((! defined $fields[7]) || ($fields[7] eq '')) { $max_tx=$min_tx; } else {$max_tx=$fields[7];}
	$test_dir_name=$test_name."_".$ini."_".$tgt."_".$ipc_rw."_max_readot_".$max_rd_ot."_max_writeot".$max_wr_ot;
	$suffix = $test_name."_".$ini."_".$tgt."_".$ipc_rw;
	$test_dir_name = "+SPA_RUN_NAME=".$test_dir_name;
	$ini = '+STG_IPC_INGRESS='.$ini;
	$tgt = '+STG_IPC_EGRESS='.$tgt;
	$ipc_rw = '+STG_IPC_READWRITE='.$ipc_rw;
	$max_rd_ot= '+MaxReadOT='.$max_rd_ot;
	$max_wr_ot= '+MaxWriteOT='.$max_wr_ot;
	$run_cmd = "$cfg_dir/nocrun -test $test_name -suffix $suffix "; #Even if we have +UVM_TESTNAME, we still need '-test' option in commandline. Adding that before modifying $test_name
	$test_name='+UVM_TESTNAME='.$test_name;
	$run_cmd .= " -plus \" $test_name $test_dir_name $ini $tgt $ipc_rw $max_rd_ot $max_wr_ot +CDN_STG_MIN_ITEM_COUNT=$min_tx +CDN_STG_MAX_ITEM_COUNT=$max_tx\"\n";
	print OP_FILE $run_cmd;
	$test_dir_name="";
	$ini="";
	$tgt="";
	$ipc_rw="";
	$max_rd_ot="";
	$max_wr_ot="";
	$run_cmd="";
}

sub trim_whitespaces { #clean up whitespaces at start and end of each element
	my ($ref_fields) = @_;
	foreach my $field (@$ref_fields){
		$field =~ s/^\s+|\s+$//g;
	}
}
