package Params;
use Exporter ();
@Params::ISA = qw(Exporter);
@Params::EXPORT =
    qw(
        $topMod
        $topRst
        $axi4IeaCnt
        $axi4TeaCnt
        $apbIeaCnt
        $apbTeaCnt
        $ahbIeaCnt
        $ahbTeaCnt
        $perDataRstatus
        $ridW
        $widW
        $ridxW
        $widxW 
        $rreorder
        $wreorder
        $maxRO
        $maxWO
        $AceLitePresent
        @axi4IeaNames
        @axi4TeaNames
        @apbIeaNames
        @apbTeaNames
        @ahbIeaNames
        @ahbTeaNames
        @clkNames
        @rstNames
        $cfg_dir
        @ahbIeaWSTRBNames
        @ahbTeaWSTRBNames
        @ahbIeaResHPROTNames
        @ahbTeaResHPROTNames
        @hDomains
        $pkt_pLenW
	    $pkt_Version
        $useSubTgtID
        %axi4IeaInfo
        %axi4TeaInfo
        %apbIeaInfo
        %apbTeaInfo
        %ahbIeaInfo
        %ahbTeaInfo
        %ieaInfo
        %teaInfo
        $testbench
        $internal
        @vf_files
        $inclDbgReg
        $dbgBase
        $isMesh
    );

%Params::EXPORT_TAGS = ();
use vars
    qw(

        $topMod
        $topRst
        $axi4IeaCnt
        $axi4TeaCnt
        $apbIeaCnt
        $apbTeaCnt
        $ahbIeaCnt
        $ahbTeaCnt
        $perDataRstatus
        $AceLitePresent
        $ridW
        $widW
        $ridxW
        $widxW 
        $rreorder
        $wreorder
        $maxRO
        $maxWO  
        @axi4IeaNames
        @axi4TeaNames
        @apbIeaNames
        @apbTeaNames
        @ahbIeaNames
        @ahbTeaNames
        @clkNames
        @rstNames
        $cfg_dir
        @ahbIeaWSTRBNames
        @ahbTeaWSTRBNames
        @ahbIeaResHPROTNames
        @ahbTeaResHPROTNames
        @hDomains
        $pkt_pLenW
	    $pkt_Version
        $useSubTgtID
        %axi4IeaInfo
        %axi4TeaInfo
        %apbIeaInfo
        %apbTeaInfo
        %ahbIeaInfo
        %ahbTeaInfo
        %ieaInfo
        %teaInfo
        $testbench
        $internal
        @vf_files
        $inclDbgReg
        $dbgBase
        $isMesh
    );

$topMod = "usb4_tc_noc";
$topRst = rst_n;
$cfg_dir = "/project/cust/genapp/NOC-2025.1/build/cdns_dip_usb/prod/usb4_tc_noc/443277/NOC-2025.1-linux/usb4_tc_noc";

$axi4IeaCnt = 0;
$axi4TeaCnt = 0;
$apbIeaCnt = 2;
$apbTeaCnt = 6;
$ahbIeaCnt = 0;
$ahbTeaCnt = 0;
$perDataRstatus = 1;

push(@apbIeaNames, "apb_mstr");
push(@apbIeaNames, "cdb");
push(@apbTeaNames, "cmn_cdb");
push(@apbTeaNames, "tc_reg");
push(@apbTeaNames, "usb_sub_sys");
push(@apbTeaNames, "pam3_sub_sys");
push(@apbTeaNames, "apb_tgt");
push(@apbTeaNames, "xcvr_ln_0");


push(@clkNames, "tap2apb_pclk");
push(@clkNames, "noc_clk");
push(@rstNames, "rst_n");

$AceLitePresent = 0;


$pkt_pLenW = 3;
$pkt_Version = 3;



$apbIeaInfo{apb_mstr} = {bus => APB, dataW => 32, addrW => 32, rw => rw, targets=>["apb_tgt","cmn_cdb","tc_reg","usb_sub_sys","pam3_sub_sys","xcvr_ln_0"], aMap=>[{tgt=>"apb_tgt", baseAddr=>0, mask=>786432, rw=>0},{tgt=>"cmn_cdb", baseAddr=>262144, mask=>1048064, rw=>0},{tgt=>"tc_reg", baseAddr=>327680, mask=>983040, rw=>0},{tgt=>"usb_sub_sys", baseAddr=>393216, mask=>983040, rw=>0},{tgt=>"pam3_sub_sys", baseAddr=>458752, mask=>983040, rw=>0},{tgt=>"xcvr_ln_0", baseAddr=>263168, mask=>1047552, rw=>0}], prot => 0, maxRO => 1, maxWO => 1, userReqW => 0, userDataW => 0, userRespW => 0};
$ieaInfo{apb_mstr} = {bus => APB, dataW => 32, addrW => 32, rw => rw, targets=>["apb_tgt","cmn_cdb","tc_reg","usb_sub_sys","pam3_sub_sys","xcvr_ln_0"], aMap=>[{tgt=>"apb_tgt", baseAddr=>0, mask=>786432, rw=>0},{tgt=>"cmn_cdb", baseAddr=>262144, mask=>1048064, rw=>0},{tgt=>"tc_reg", baseAddr=>327680, mask=>983040, rw=>0},{tgt=>"usb_sub_sys", baseAddr=>393216, mask=>983040, rw=>0},{tgt=>"pam3_sub_sys", baseAddr=>458752, mask=>983040, rw=>0},{tgt=>"xcvr_ln_0", baseAddr=>263168, mask=>1047552, rw=>0}], prot => 0, maxRO => 1, maxWO => 1};
$apbIeaInfo{cdb} = {bus => APB, dataW => 32, addrW => 32, rw => rw, targets=>["apb_tgt","cmn_cdb","tc_reg","usb_sub_sys","pam3_sub_sys","xcvr_ln_0"], aMap=>[{tgt=>"apb_tgt", baseAddr=>0, mask=>786432, rw=>0},{tgt=>"cmn_cdb", baseAddr=>262144, mask=>1048064, rw=>0},{tgt=>"tc_reg", baseAddr=>327680, mask=>983040, rw=>0},{tgt=>"usb_sub_sys", baseAddr=>393216, mask=>983040, rw=>0},{tgt=>"pam3_sub_sys", baseAddr=>458752, mask=>983040, rw=>0},{tgt=>"xcvr_ln_0", baseAddr=>263168, mask=>1047552, rw=>0}], prot => 0, maxRO => 1, maxWO => 1, userReqW => 0, userDataW => 0, userRespW => 0};
$ieaInfo{cdb} = {bus => APB, dataW => 32, addrW => 32, rw => rw, targets=>["apb_tgt","cmn_cdb","tc_reg","usb_sub_sys","pam3_sub_sys","xcvr_ln_0"], aMap=>[{tgt=>"apb_tgt", baseAddr=>0, mask=>786432, rw=>0},{tgt=>"cmn_cdb", baseAddr=>262144, mask=>1048064, rw=>0},{tgt=>"tc_reg", baseAddr=>327680, mask=>983040, rw=>0},{tgt=>"usb_sub_sys", baseAddr=>393216, mask=>983040, rw=>0},{tgt=>"pam3_sub_sys", baseAddr=>458752, mask=>983040, rw=>0},{tgt=>"xcvr_ln_0", baseAddr=>263168, mask=>1047552, rw=>0}], prot => 0, maxRO => 1, maxWO => 1};

$apbTeaInfo{cmn_cdb} = {bus => APB, dataW => 32, addrW => 9, rw => rw, prot => 0, maxRO => 1, maxWO => 1, userReqW => 0, userDataW => 0, userRespW => 0};
$teaInfo{cmn_cdb} = {bus => APB, dataW => 32, addrW => 9, rw => rw, prot => 0, maxRO => 1, maxWO => 1};
$apbTeaInfo{tc_reg} = {bus => APB, dataW => 32, addrW => 16, rw => rw, prot => 0, maxRO => 1, maxWO => 1, userReqW => 0, userDataW => 0, userRespW => 0};
$teaInfo{tc_reg} = {bus => APB, dataW => 32, addrW => 16, rw => rw, prot => 0, maxRO => 1, maxWO => 1};
$apbTeaInfo{usb_sub_sys} = {bus => APB, dataW => 32, addrW => 16, rw => rw, prot => 0, maxRO => 1, maxWO => 1, userReqW => 0, userDataW => 0, userRespW => 0};
$teaInfo{usb_sub_sys} = {bus => APB, dataW => 32, addrW => 16, rw => rw, prot => 0, maxRO => 1, maxWO => 1};
$apbTeaInfo{pam3_sub_sys} = {bus => APB, dataW => 32, addrW => 16, rw => rw, prot => 0, maxRO => 1, maxWO => 1, userReqW => 0, userDataW => 0, userRespW => 0};
$teaInfo{pam3_sub_sys} = {bus => APB, dataW => 32, addrW => 16, rw => rw, prot => 0, maxRO => 1, maxWO => 1};
$apbTeaInfo{apb_tgt} = {bus => APB, dataW => 32, addrW => 18, rw => rw, prot => 0, maxRO => 1, maxWO => 1, userReqW => 0, userDataW => 0, userRespW => 0};
$teaInfo{apb_tgt} = {bus => APB, dataW => 32, addrW => 18, rw => rw, prot => 0, maxRO => 1, maxWO => 1};
$apbTeaInfo{xcvr_ln_0} = {bus => APB, dataW => 32, addrW => 10, rw => rw, prot => 0, maxRO => 1, maxWO => 1, userReqW => 0, userDataW => 0, userRespW => 0};
$teaInfo{xcvr_ln_0} = {bus => APB, dataW => 32, addrW => 10, rw => rw, prot => 0, maxRO => 1, maxWO => 1};



$useSubTgtID = 0;
$testbench = "testbench";
$internal = 0;
$inclDbgReg = 1;
$dbgBase = 524288;
$isMesh = 0;
    
    @hDomains = ();
    push(@hDomains, "main");

1;
