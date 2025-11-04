#------------------------------------------------------------------------------
# File	  : Makefile
# Description : Switches Used for Simulation 
#--------------------------------------------------------------------


#--------------------------------------------------------------------
# TARGET : Call xrun with the set of options
#--------------------------------------------------------------------

TEST            = cdn_u4_usb32_test_base
STD_MODE        = USB32
STANDARDS       =
SPEED           =
SERDES_WIDTH    = 40 
PORT_MODE 		=
SVACOMP         = NO
XCELIUM         = 
WAVES 			= YES
DEFINES       	=
LANE_NUM 		=
REF_CLK         = 100
SSC             = NO
FLIP            = NO 
B2B_MODE        = NO
ALT_USB32_TEST  = cdn_u4_usb32_test_base
ALT_DP_TEST     = cdn_u4_dp_test_base

DEFINES += -define MP_PHY_LN00_POP
DEFINES += -define MP_PHY_LN01_POP
DEFINES += -define CDN_UCTLR_SINGLE_PORT_RAM
DEFINES += -define TB_TOP=cdn_phy_tb_top
DEFINES += -define CDN_MPPHY_LANE_UC_INC
DEFINES += -define CDN_TC_UC_SRAM_128KB
#DEFINES += -define CDN_UCTLR_DUAL_PORT_RAM
#DEFINES += -DEFINE CDN_MPPHY_UC_ECC_EN

ifeq ($(STD_MODE), USB4)
   STANDARDS += +STANDARD=USB4 +define+USB4 +define+PD_WIDTH=40
else  ifeq ($(STD_MODE), USB32)
   STANDARDS += +STANDARD=USB32 +define+USB32 +define+PD_WIDTH=32
else ifeq ($(STD_MODE), DP)
   STANDARDS += +STANDARD=DP +define+DP +define+PD_WIDTH=32
else ifeq ($(STD_MODE), PCIE)
   STANDARDS += +STANDARD=PCIE +define+PCIE +define+PD_WIDTH=32
else ifeq ($(STD_MODE), ALT)
   STANDARDS += +STANDARD=ALT +define+ALT_MODE +define+PD_WIDTH=32
   STANDARDS += +USB32_TESTNAME=$(ALT_USB32_TEST)
   STANDARDS += +DP_TESTNAME=$(ALT_DP_TEST)
else
   STD_MODES += +STANDARD=standard_err 
endif

ifneq ($(LANE_NUM), NULL)
   LANE_NUMBER += +LANE_NUM=$(LANE_NUM)
else 
   LANE_NUMBER += +LANE_NUM=2
endif

#================USB32 SPEED SET===============================#
ifeq ($(STD_MODE), USB32)
  ifeq ($(SPEED), GEN1)
     USB32_SPEED += +USB32_SPEED=USB32_GEN1 +define+SERDES_WIDTH=40 
  else  ifeq ($(SPEED), GEN2)
     USB32_SPEED += +USB32_SPEED=USB32_GEN2 +define+SERDES_WIDTH=40 
  endif
endif
#==============================================================#
#================PCIE SPEED SET===============================#
ifeq ($(STD_MODE), PCIE)
  ifeq ($(SPEED), GEN1)
     PCIE_SPEED += +PCIE_SPEED=PCIE_GEN1 +define+SERDES_WIDTH=40 
  else  ifeq ($(SPEED), GEN2)
     PCIE_SPEED += +PCIE_SPEED=PCIE_GEN2 +define+SERDES_WIDTH=40 
  else  ifeq ($(SPEED), GEN3)
     PCIE_SPEED += +PCIE_SPEED=PCIE_GEN3 +define+SERDES_WIDTH=32
  else  ifeq ($(SPEED), GEN4)
     PCIE_SPEED += +PCIE_SPEED=PCIE_GEN4 +define+SERDES_WIDTH=32
  endif
endif
#==============================================================#
#================USB4 SPEED SET===============================#
ifeq ($(STD_MODE), USB4)
  ifeq ($(SPEED), GEN2)
     USB4_SPEED += +USB4_SPEED=USB4_GEN2 +define+SERDES_WIDTH=32 
  else  ifeq ($(SPEED), GEN3)
     USB4_SPEED += +USB4_SPEED=USB4_GEN3 +define+SERDES_WIDTH=32 
  endif
endif
#==============================================================#
#================DP SPEED SET===============================#
ifeq ($(STD_MODE), DP)
  ifeq ($(SPEED), RBR)
     DP_SPEED += +DP_SPEED=RBR +define+SERDES_WIDTH=32 
  else  ifeq ($(SPEED), HBR)
     DP_SPEED += +DP_SPEED=HBR +define+SERDES_WIDTH=32 
  else  ifeq ($(SPEED), HBR2)
     DP_SPEED += +DP_SPEED=HBR2 +define+SERDES_WIDTH=32 
  else  ifeq ($(SPEED), HBR3)
     DP_SPEED += +DP_SPEED=HBR3 +define+SERDES_WIDTH=32 
  else  ifeq ($(SPEED), UHBR10)
     DP_SPEED += +DP_SPEED=UHBR10 +define+SERDES_WIDTH=32 
  else  ifeq ($(SPEED), UHBR13P5)
     DP_SPEED += +DP_SPEED=UHBR13P5 +define+SERDES_WIDTH=32 
  else  ifeq ($(SPEED), UHBR20)
     DP_SPEED += +DP_SPEED=UHBR20 +define+SERDES_WIDTH=32 
  else
     DP_SPEED += +define+SERDES_WIDTH=32 
  endif
endif

#==============================================================#

ifeq ($(PORT_MODE), HOST)
   STANDARDS += +PORT_MODE=HOST
else ifeq ($(PORT_MODE), DEVICE)
   STANDARDS += +PORT_MODE=DEVICE
endif

ifeq ($(REF_CLK), 100)
   STANDARDS += +REFCLK=REF100
else ifeq ($(REF_CLK),19P2 )
   STANDARDS += +REFCLK=REF19P2
else ifeq ($(REF_CLK),24 )
   STANDARDS += +REFCLK=REF24
endif

ifeq ($(SSC), NO)
   STANDARDS += +SSCFLAG=SSCNO
else ifeq ($(SSC),YES)
   STANDARDS += +SSCFLAG=SSCEN
endif

ifeq ($(FLIP), NO)
   STANDARDS += 
else ifeq ($(FLIP),YES)
   STANDARDS += FLIP_MODE
endif

ifeq ($(FW_FRONTDOOR), YES)
   STANDARDS += +FW_FRONTDOOR=YES
else ifeq ($(FW_FRONTDOOR),NO)
   STANDARDS += +FW_FRONTDOOR=NO
endif

ifeq ($(B2B_MODE),YES)
    DEFINES += -define B2B_MODE
endif


VIP_SWITCHS = -cdn_vip_root ${CDN_VIP_ROOT} -define DENALI_UVM -loadvpi ${DENALI}/verilog/libcdnsv.so:cdnsvVIP:export -define CDN_APB_USING_CLOCKING_BLOCK -snprerun notest -snnoauto -define CDN_AUTO_TEST -xmsimargs "-loadrun ${CDN_VIP_LIB_PATH}/libcdnvipcuvm.so" -xmsimargs "-loadrun ${CDN_VIP_LIB_PATH}/libPsif.so" 

IRUN_COMMON_ARGS = \
	$(STANDARDS) \
	$(USB4_SPEED) \
	$(USB32_SPEED) \
	$(PCIE_SPEED) \
    $(DP_SPEED) \
	$(LANE_NUMBER)	\
	$(VIP_SWITCHS)

ifeq ($(SVACOMP),YES)
    SOURCE_ABV_F     += -f $(VUNIT_DIR)/filelist/vunit_filelist.f
    IRUN_COMMON_ARGS += -assert
else 
    SOURCE_ABV_F +=
endif

ifeq ($(XCELIUM),YES)
	WAVE_TCL = $(PHY_SCRIPTS_DIR)/waves_files/probes.tcl
	GUI_DEFINE = -gui
else 
	WAVE_TCL = $(PHY_SCRIPTS_DIR)/waves_files/ida_probe.tcl
	GUI_DEFINE = -debug_opts verisium_interactive +access+rwc
endif


RTL_F =  ${PHY_DESIGN_AREA}/design/filelist/output/timberwolf_phy_hlm_sim.f
SIM_FILES = -f $(RTL_F)


ifeq ($(WAVES),YES)
  ifeq ($(XCELIUM),YES)
	SIM_FILES += -input $(WAVE_TCL)
  else
	SIM_FILES += -debug_opts verisium_pp -access +r -input $(WAVE_TCL)
  endif
endif



run :
	xrun \
	-timescale 1ns/1fs \
	-l test.log \
	+access+rwc \
	-sysv_ext +.v \
	-vlog_ext +.vh \
	-sv \
	-uvm \
	-uvmhome CDNS-1.2 \
	-define UVM_NO_DEPRECATED \
        $(SOURCE_ABV_F) \
	-abvrecordcoverall \
	-nowarn CUVWSP:PDNTMCG:ILIOPT:MACNDF:CUNSVI:MACRDF:RECOME \
	 +UVM_VERBOSITY=UVM_LOW \
	 +UVM_TESTNAME=$(TEST) \
    $(IRUN_COMMON_ARGS) \
	$(SIM_FILES)	\
	-f ${PHY_VERIF_AREA}/top/tb_filelist.f \
	-top cdn_phy_tb_top \
	-assert \
	-notimingchecks \
	-64bit \
	-licqueue \
	-abvfailurelimit 100 \
	-linedebug -fsmdebug \
	$(DEFINES)	


run_i :
	xrun \
	-timescale 1ns/1fs \
	-l test.log \
	+access+rwc \
	-sysv_ext +.v \
	-vlog_ext +.vh \
	-sv \
	-uvm \
	-uvmhome CDNS-1.2 \
	-define UVM_NO_DEPRECATED \
        $(SOURCE_ABV_F) \
	-abvrecordcoverall \
	-nowarn CUVWSP:PDNTMCG:ILIOPT:MACNDF:CUNSVI:MACRDF:RECOME \
	 +UVM_VERBOSITY=UVM_LOW \
	 +UVM_TESTNAME=$(TEST) \
    $(IRUN_COMMON_ARGS) \
	$(SIM_FILES)	\
	-f ${PHY_VERIF_AREA}/top/tb_filelist.f \
	-top cdn_phy_tb_top \
	-assert \
	-notimingchecks \
	-64bit -linedebug -fsmdebug \
	-licqueue \
	-abvfailurelimit 100 \
	$(GUI_DEFINE) \
	$(DEFINES)	

#--------------------------------------------------------------------
# TARGET : clean
#--------------------------------------------------------------------
clean :
	rm -rf INCA_libs*
	rm -rf xcelium.d
	rm -rf indago*
	rm -rf .simvision
	rm -rf *.shm
	rm -rf html
	rm -rf test_lib
	rm -f .ngen_data
	rm -f *.ucd
	rm -f *.html
	rm -f *.history
	rm -f *.ucm
	rm -f *.log
	rm -f *.elog
	rm -f *.err
	rm -f *.key
	rm -f *.ecov
	rm -f logger_verbosity.ecom
	rm -f waves.tcl
	rm -f lib_mfile.txt*
	rm -f *~
	rm -f coverage.tcl
	rm -f toggle_exclude.file
	rm -f simvision*.diag
	rm -f specman*.c
	rm -f *testcases_list.test*
	rm -rf cov_work
	rm -rf rerun_cmd
	rm -rf vmgr_merge_logs
	rm -rf soma_files 
