#  +---------------------------------------------------------------------------------------------+
#  |          Copyright (c) 2008-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        |
#  |   These coded instructions, statements, and computer programs are the                       |
#  |   copyrighted works and confidential proprietary information of Cadence Design Systems Inc. |
#  |   They may not be modified, copied, reproduced, distributed, or disclosed to                |
#  |   third parties in any manner, medium, or form, in whole or in part, without                |
#  |   the prior written consent of Cadence Design Systems Inc.                                  |
#  +---------------------------------------------------------------------------------------------+

###############################################################################################
## Disclaimer : This EDA Flow is going through internal review process and subject to change  #
###############################################################################################

# Options for the SYN variable are:
#	"syn_genus"           - Cadence Genus synthesis
SYN =  syn_genus


# Options for the LAYOUT variable are:
#       "layout_innovus"      - Cadence Innovus Digital Implementation place and route flow
LAYOUT =  layout_innovus


# Options for the EXTRACT variable are:
#	"extract_qrc"         - Cadence post-route extraction flow
EXTRACT = extract_qrc


# Options for the VERIFY variable are:
# 	"verify_tempus"       - Cadence Tempus Timing Signoff Solution engine for post-extraction analysis
VERIFY = verify_tempus

PWD               := $(shell pwd)
CADSETUP          := $(PWD)/CadSetup.file
export SCRIPTS    := $(PWD)/scripts
export PATH       := $(SCRIPTS)/automation:$(PATH)
CORE_DEFINE	  := $(SCRIPTS)/automation/Core_define.pl

###############################################################################
# Flow control variables from CadSetup.file                                   #
###############################################################################

INNOVUS_FP_USE                := $(shell $(CORE_DEFINE) -show Innovus_FP_USE)
INSERT_SCAN                   := $(shell $(CORE_DEFINE) -show INSERT_SCAN)
FPLAN_FILE                    := $(shell $(CORE_DEFINE) -show FPLAN_FILE)
export USE_MEMORY_MACROS      := $(shell $(CORE_DEFINE) -show USE_MEMORY_MACROS)
GENUS_USE_ISPATIAL            := $(shell $(CORE_DEFINE) -show GENUS_USE_ISPATIAL)
INNOVUS_MIXEDPLACER           := $(shell $(CORE_DEFINE) -show Innovus_MixedPlacer)
USE_MBCI                      := $(shell $(CORE_DEFINE) -show USE_MULTIBIT_CELLS)
TSO_OPT			      := $(shell $(CORE_DEFINE) -show TEMPUS_TSO_OPT)
TSO_OPT2 		      := $(shell $(CORE_DEFINE) -show TEMPUS_TSO_OPT_PASS2)
export CDNS_MULTITHREAD_COUNT := $(shell $(CORE_DEFINE) -show SUPERTHREAD_COUNT)

###############################################################################
# Global variables and targets                                                #
###############################################################################

export CORE_PREFIX = $(DESIGN)

###############################################################################
# Flow steps                                                                  #
###############################################################################

# ----------------------------------------------------------------------------------
# syn
# ----------------------------------------------------------------------------------

CDNSSYNDIR = syn_genus
LAYOUTDIR = layout_innovus
EXTDIR = extract_qrc
TEMPUSDIR = verify_tempus

syn: $(SYN)

SYNDIR = $(CDNSSYNDIR)

syn_genus: syn_genus_setup
ifeq ($(GENUS_USE_ISPATIAL),1)
	@($(MAKE) -s genus_fp_check)
	@echo "Synthesizing with floorplan using Genus-iSpatial ............"
else
	@echo "Synthesizing without floorplan using Genus-PLE .............."
endif
	@(cd $(CDNSSYNDIR); genus -f Genus_compile.tcl > Genus_compile.log; cd ../)
	@(cd $(CDNSSYNDIR); genus-qor -i Genus_compile.log -genus > Genus_compile.summary; cd ../)
	@($(MAKE) -s TOOL=genus FLOW=syn_genus DIR=$(CDNSSYNDIR) LOG=Genus_compile.log CHECK_TIMING=1 TIMING_FILE="$(DESIGN)*.timing" check_error)
	@(cd $(CDNSSYNDIR); genus-path-compressor.pl -i $(CORE_PREFIX)_syn.timing -o $(CORE_PREFIX)_syn.timing.cmpr -genus; cd ../)
	@(cd $(CDNSSYNDIR); rm -fr genus.log genus.cmd *.aocv lib_script_ref_* .clp $(CORE_PREFIX)_syn_*.sdc timingReports et_work_dir *Partition_* Un* qrc_* modus* libscore_work _default_* mp_data *stats_db scheduling_file* placementReports *syn.db.xdata Un*.log *_0.log; cd ../)
	@(cd $(CDNSSYNDIR); if [ -e $(CORE_PREFIX)_syn_*.cpf ]; then mv -f $(CORE_PREFIX)_syn_*.cpf $(CORE_PREFIX)_syn.cpf; fi; cd ../)
	@(cd $(CDNSSYNDIR); genus_conformal_adjust.pl; cd ../)

tempus_genus_sdf:
	@if [ ! -d $(CDNSSYNDIR) ]; then \
		echo "ERROR : $(CDNSSYNDIR) directory doesn't exist;"; \
		echo "ERROR : you need to run \"make $(CDNSSYNDIR)\" before running \"make tempus_genus_sdf\"."; \
		exit 1; \
	fi
	@echo "Running Tempus Timing Signoff Solution to make valid post-Genus .sdf file ........................"
	@echo "For proper operation, make sure all input libraries have unique names ...."
	@cp -fp $(SCRIPTS)/tempus/Tempus_gensdf.tcl $(CDNSSYNDIR)/
	@(cd $(CDNSSYNDIR); if [ ! -e Genus_generic_define.tcl ]; then Core_define.pl -i .debug/CadSetup.file -o Genus_generic_define.tcl; fi; cd ../)
	@(cd $(CDNSSYNDIR); Core_define.pl -verify_tempus -i .debug/CadSetup.file -o Tempus_define.tcl; cd ../)
	@(cd $(CDNSSYNDIR); tempus -nowin -init Tempus_gensdf.tcl > Core_tempus_gensdf_for_genus.log; cd ../)
	@($(MAKE) -s TOOL=tempus FLOW=tempus_genus_sdf DIR=$(CDNSSYNDIR) LOG=Core_tempus_gensdf_for_genus.log check_error)
	@(cd $(CDNSSYNDIR); rm -f tempus.cmd* tempus.log*; cd ../)

syn_setup: $(SYN)_setup

syn_genus_setup:
	@echo "Data setup for synthesis using Cadence Genus ......................"
	@($(MAKE) -s SYNDIR=$(CDNSSYNDIR) syn_gatesim_debug)
	Core_define.pl -i CadSetup.file -o ./$(CDNSSYNDIR)/Genus_generic_define.tcl
	@echo "Copying top-level compilation script to $(CDNSSYNDIR) directory"
	@cp -fp $(SCRIPTS)/genus/Genus_compile.tcl $(CDNSSYNDIR)

syn_gatesim_debug:
	@(if [ ! -d $(SYNDIR)/.debug ]; then \
		(if [ ! -d $(SYNDIR) ]; then \
			mkdir $(SYNDIR); \
		fi); \
		cd $(SYNDIR); \
		mkdir .debug; \
		cd ../; \
	fi) 
	@cp -fp CadSetup.file $(SYNDIR)/.debug/.

syn_topo_check:
	@echo "Running DC_Core_check.tcl ................"
	@(if [ ! -d syn_topo ]; then mkdir -p syn_topo ; fi)
	@cp -fp $(SCRIPTS)/dc/DC_Core_check.tcl syn_topo/.
	@(cd syn_topo; rm -fr mw_design_lib; cd ../)
	@(cd syn_topo; dc_shell-xg-t -f DC_Core_check.tcl > DC_check.log; cd ../)
	@($(MAKE) -s TOOL=dc FLOW=syn_topo_check DIR=syn_topo LOG=DC_check.log check_error)
	@(cd syn_topo; rm -fr mw_design_lib workdir default.svf command.log udul_default_fin*; cd ../)

syn_genus_check:
	@echo "Running Genus_check.tcl ..........."
	@($(MAKE) -s SYNDIR=$(CDNSSYNDIR) syn_gatesim_debug)
	Core_define.pl -i CadSetup.file -o ./$(CDNSSYNDIR)/Genus_generic_define.tcl -no_check
	@cp -fp $(SCRIPTS)/genus/Genus_check.tcl $(CDNSSYNDIR)/.
	@(cd $(CDNSSYNDIR); genus -f Genus_check.tcl > Core_check.log; cd ../)
	@($(MAKE) -s TOOL=genus FLOW=syn_genus_check DIR=$(CDNSSYNDIR) LOG=Core_check.log check_error)
	@(cd $(CDNSSYNDIR); rm -fr fv genus.log genus.cmd *.aocv lib_script_ref_* Genus_cons_io.tcl libscore_work _default_* mp_data *stats_db scheduling_file* placementReports; cd ../)

conformal_check:
	@echo "Running Conformal_check.do ..............."
	@(if [ ! -d conformal_check ]; then \
		mkdir -p conformal_check ; \
	fi)
	@cp -fp $(SCRIPTS)/formal/Conformal_check.do conformal_check/
	@(cd conformal_check ; lec -xl -nogui -dofile Conformal_check.do > run.log; cd ../)
	@(cd conformal_check ; rm -f run.log ; cd ../)

pso_flow_check:
	@(if [ -e $(SYNDIR)/$(CORE_PREFIX)_syn.pso_lib_check ]; then \
		echo "ERROR : Synthesis was performed with the Power Shut Off (PSO) flow."; \
		echo "ERROR : Post-synthesis backend flows such as the one just selected"; \
		echo "ERROR : are not supported for netlists with PSO-inserted cells. To"; \
		echo "ERROR : run this flow, re-run synthesis without PSO."; \
		exit 1; \
	fi)

genus_fp_check:
ifeq ($(GENUS_USE_ISPATIAL),1)
	@(if [ ! -e $(FPLAN_FILE) ]; then \
	  echo "ERROR: Floorplan file $(FPLAN_FILE) does not exist. This file is needed for"; \
	  echo "ERROR: Genus iSpatial synthesis (Genus_iSpatialEnable set to 1 in CadSetup.file)"; \
	  exit 1; \
	fi)
	@(if [ ! -d $(SYNDIR)/.debug ]; then \
		(if [ ! -d $(SYNDIR) ]; then \
			mkdir $(SYNDIR); \
		fi); \
		cd $(SYNDIR); \
		mkdir .debug; \
		cd ../; \
	fi)
	@cp -fp $(FPLAN_FILE) $(SYNDIR)/.debug/
endif

# -------------------------------------------------------------------------------
# layout
# -------------------------------------------------------------------------------

layout: $(LAYOUT)

CHK_TIMING = 1
ifeq ($(INNOVUS_FP_USE),1)
CHK_TIMING = 0
endif
ifdef INNOVUS_EXIT_AFTER_STEP
CHK_TIMING = 0
endif




layout_innovus: pso_flow_check layout_innovus_setup
	@echo "Running Place and Route using Innovus .............................."
	@(cd $(LAYOUTDIR); innovus -replay Innovus_flow.cmd -nowin -nologv -log Innovus_flow.log; mv Innovus_flow.log1 Innovus_flow.log; cd ..)
ifdef INNOVUS_EXIT_AFTER_STEP
	@(cd $(LAYOUTDIR); innovus-path-compressor.pl -i preCtsOpt.timing -o preCtsOpt.timing.cmpr; cd ../)
	@(cd $(LAYOUTDIR); mv Innovus_Lib my_Innovus_Lib; cd ..)
endif
	@(cd $(LAYOUTDIR); rm -fr *qrc* *.res restore.enc* celtic checkDesign CTS_RP_MOVE.txt checknetlist.rpt Innovus_Lib extLogDir _* placementReports reports io_cons_updated.cmd timingReports temp.def Xm_*rpt* ./-1; cd ../)
	@($(MAKE) -s TOOL=innovus FLOW=layout_innovus DIR=$(LAYOUTDIR) LOG=Innovus_flow.log CHECK_TIMING=$(CHK_TIMING) TIMING_FILE="$(DESIGN)_routed.timing" check_error)
ifeq ($(CHK_TIMING),1)
	@(cd $(LAYOUTDIR); innovus-path-compressor.pl -i $(CORE_PREFIX)_routed.timing -o $(CORE_PREFIX)_routed.timing.cmpr; cd ../)
endif

layout_innovus_rerun:
	@echo "Rerunning Place and Route using Innovus .............................."
	@(cd $(LAYOUTDIR); innovus -replay Innovus_flow.cmd -nowin -nologv -log Innovus_flow.log; cd ..)
	@($(MAKE) -s TOOL=innovus FLOW=layout_innovus DIR=$(LAYOUTDIR) LOG=Innovus_flow.log1 CHECK_TIMING=1 TIMING_FILE="$(DESIGN)_routed.timing" check_error)
ifeq ($(CHK_TIMING),1)
	@(cd $(LAYOUTDIR); innovus-path-compressor.pl -i $(CORE_PREFIX)_routed.timing -o $(CORE_PREFIX)_routed.timing.cmpr; cd ../)
endif
	@(cd $(LAYOUTDIR); rm -fr *qrc* *.res restore.enc* celtic checkDesign CTS_RP_MOVE.txt checknetlist.rpt Innovus_Lib extLogDir _* placementReports reports io_cons_updated.cmd timingReports temp.def Xm_*rpt* ./-1; cd ../)

layout_innovus_setup: override LAYOUT = layout_innovus

layout_innovus_setup: layout_data_check
	@echo "Data setup for layout using Innovus"
	@echo "> create working dir: $(LAYOUTDIR)"
	@($(MAKE) -s LAYOUT=$(LAYOUTDIR) layout_gatesim_debug)
	@echo "> Create softlinks to netlist and synthesis constraints"
	@(cd $(LAYOUTDIR); rm -fr $(CORE_PREFIX)*_netlist.v *.scandef $(CORE_PREFIX)*_cons.sdc Innovus_flow.log* Innovus_flow.log*.* Innovus_Lib reports *.timing *.area *.ref ; cd ..)
	@($(MAKE) -s FLOW=layout_innovus SRC_DIR=$(SYNDIR) SRC_FILE=$(CORE_PREFIX)_syn.v TARG_DIR=$(LAYOUTDIR) TARG_FILE=$(CORE_PREFIX)_netlist.v check_n_symlink)
	@($(MAKE) -s FLOW=layout_innovus SRC_DIR=$(SYNDIR) SRC_FILE=$(CORE_PREFIX)_syn.sdc TARG_DIR=$(LAYOUTDIR) TARG_FILE=$(CORE_PREFIX)_cons.sdc check_n_symlink)
	@(if [ -e $(SYNDIR)/$(CORE_PREFIX)_syn.scandef ]; then cd $(LAYOUTDIR); ln -s ../$(SYNDIR)/$(CORE_PREFIX)_syn.scandef $(CORE_PREFIX)_syn.scandef; cd ../; fi)
	@(if [ -e $(SYNDIR)/$(CORE_PREFIX)_syn.upf ]; then cd $(LAYOUTDIR); ln -s ../$(SYNDIR)/$(CORE_PREFIX)_syn.upf $(CORE_PREFIX)_syn.upf; cd ../; fi)
	@(if [ -e $(SYNDIR)/$(CORE_PREFIX)_syn.def ]; then cd $(LAYOUTDIR); ln -s ../$(SYNDIR)/$(CORE_PREFIX)_syn.def $(CORE_PREFIX)_database.def; cd ../; fi)
ifeq ($(USE_MEMORY_MACROS),1)
	@($(MAKE) -s FLOW=layout_innovus SRC_DIR=$(SYNDIR) SRC_FILE=$(CORE_PREFIX)_syn.memory_macro_list TARG_DIR=$(LAYOUTDIR) TARG_FILE=$(CORE_PREFIX)_syn.memory_macro_list check_n_symlink)
	@(touch ./$(LAYOUTDIR)/$(CORE_PREFIX)_routed.timing;)
endif
	@echo "> generate Innovus Scripts"
	@echo "> Copying top-level command file to $(LAYOUTDIR) directory"
	@cp -fp $(SCRIPTS)/innovus/Innovus_flow.cmd $(LAYOUTDIR)
	@echo "> Running Innovus."
	@cp -fp $(SCRIPTS)/innovus/Innovus_corner_define.cmd $(LAYOUTDIR)
	@cp -fp $(SCRIPTS)/innovus/Innovus_corner_define_disable_powerLIB.cmd $(LAYOUTDIR)
	@echo "> Create variable definitions from CadSetup.file"
	Core_define.pl -innovus -o ./$(LAYOUTDIR)/Innovus_define.cmd

layout_gatesim_debug:
	@(if [ ! -d $(LAYOUTDIR)/.debug ]; then \
		(if [ ! -d $(LAYOUTDIR) ]; then \
			mkdir $(LAYOUTDIR); \
		fi); \
		cd $(LAYOUTDIR); \
		mkdir .debug; \
		cd ../; \
	fi)
	@cp -fp CadSetup.file $(LAYOUTDIR)/.debug/.

layout_setup: $(LAYOUT)_setup

layout_data_check:
	@echo "INFO: performing layout data sufficiency check"
ifeq ($(INNOVUS_FP_USE),2)
	@(if [ ! -e $(FPLAN_FILE) ]; then \
	  echo "ERROR: Floorplan DEF file $(FPLAN_FILE) does not exist. This file is needed for"; \
	  echo "ERROR: P&R. (Innovus_FP_Use = 2 in CadSetup.file)"; \
	  exit 1; \
	fi)
	@(if [ ! -d $(LAYOUTDIR)/.debug ]; then \
		(if [ ! -d $(LAYOUTDIR) ]; then \
			mkdir $(LAYOUTDIR); \
		fi); \
		cd $(LAYOUTDIR); \
		mkdir .debug; \
		cd ../; \
	fi)
	@cp -fp $(FPLAN_FILE) $(LAYOUTDIR)/.debug/
endif

# -------------------------------------------------------------------------------
# extract
# -------------------------------------------------------------------------------

extract: $(EXTRACT)

extract_qrc: pso_flow_check extract_qrc_setup
	@echo "Running extraction using QRC ............................................."
	@(cd $(EXTDIR); if [ ! -e $(CORE_PREFIX)_extract.cmd ]; then \
		cp -f ../scripts/qrc/QRC_extract.cmd $(CORE_PREFIX)_extract.cmd; \
		fi; QRC_setup.pl -in QRC_define.cmd; cd ../)
	@(cd $(EXTDIR); qrc -cmd $(CORE_PREFIX)_extract.cmd $(CORE_PREFIX)_extract.def; cd ../)
	@(cd $(EXTDIR); if [ -e qrc.log ]; then mv -f qrc.log $(CORE_PREFIX)_extract.log; fi; cd ../)
	@(cd $(EXTDIR); if [ -e $(CORE_PREFIX)_extract_max_*.spef ]; then mv -f $(CORE_PREFIX)_extract_max_*.spef $(CORE_PREFIX)_extract_max.spef; fi; cd ../)
	@(cd $(EXTDIR); if [ -e $(CORE_PREFIX)_extract_min_*.spef ]; then mv -f $(CORE_PREFIX)_extract_min_*.spef $(CORE_PREFIX)_extract_min.spef; fi; cd ../)
	@(cd $(EXTDIR); if [ -e $(CORE_PREFIX)_extract_typ_*.spef ]; then mv -f $(CORE_PREFIX)_extract_typ_*.spef $(CORE_PREFIX)_extract_typ.spef; fi; cd ../)
	@(cd $(EXTDIR); if [ ! -e $(CORE_PREFIX)_extract_typ.spef ]; then ln -s $(CORE_PREFIX)_extract_max.spef $(CORE_PREFIX)_extract_typ.spef; fi; cd ../)
	@(cd $(EXTDIR); rm -f __*; cd ../)
	@($(MAKE) -s TOOL=qrc FLOW=extract_qrc DIR=$(EXTDIR) LOG=$(CORE_PREFIX)_extract.log check_error)

extract_qrc_setup:
	@echo "Data setup for extraction using QRC ......................................"
	Core_define.pl -extract -o ./$(EXTDIR)/QRC_define.cmd
	@echo "> create softlinks to routed def file"
	@(cd $(EXTDIR); \
		if [ -d ../$(LAYOUTDIR) ]; then \
			rm -f $(CORE_PREFIX)_extract.def; \
		fi; \
	cd ..;)
	@($(MAKE) -s FLOW=extract SRC_DIR=$(LAYOUTDIR) SRC_FILE=$(CORE_PREFIX)_routed.def TARG_DIR=$(EXTDIR) TARG_FILE=$(CORE_PREFIX)_extract.def check_n_symlink)

extract_setup: extract_qrc_setup

# -------------------------------------------------------------------------------
# verify
# -------------------------------------------------------------------------------

verify: $(VERIFY)


verify_tempus: pso_flow_check verify_tempus_setup
	@echo "Running final verification using Tempus Timing Signoff Solution ......................"
	@(cd $(TEMPUSDIR); ln -s ../$(LAYOUTDIR)/final.enc.dat final.enc.dat; cd ..)
	@(cd $(TEMPUSDIR); \
		tempus -nowin -init Tempus_verify.tcl > Tempus_verify.log; )
	@($(MAKE) -s TOOL=tempus FLOW=verify_tempus DIR=$(TEMPUSDIR) LOG=Tempus_verify.log CHECK_TIMING=1 TIMING_FILE="$(DESIGN)_verify.timing" check_error)
	@($(MAKE) -s TOOL=tempus FLOW=verify_tempus DIR=$(TEMPUSDIR) LOG=Tempus_verify.log CHECK_TIMING=1 TIMING_FILE="$(DESIGN)_verify.min.timing" check_error)
	@(cd $(TEMPUSDIR); \
		genus-path-compressor.pl -tempus -i $(CORE_PREFIX)_verify.timing -o $(CORE_PREFIX)_verify.timing.cmpr; \
		genus-path-compressor.pl -tempus -i $(CORE_PREFIX)_verify.min.timing -o $(CORE_PREFIX)_verify.min.timing.cmpr; \
		if [ -e $(CORE_PREFIX)_verify.recalc_timing ]; then \
		genus-path-compressor.pl -tempus -i $(CORE_PREFIX)_verify.recalc_timing -o $(CORE_PREFIX)_verify.recalc_timing.cmpr; \
		fi; \
		if [ -e $(CORE_PREFIX)_verify.min.recalc_timing ]; then \
		genus-path-compressor.pl -tempus -i $(CORE_PREFIX)_verify.min.recalc_timing -o $(CORE_PREFIX)_verify.min.recalc_timing.cmpr; \
		fi; \
		rm -f tempus.cmd* tempus.log*; \
		cd ..;)

verify_tempus_setup: 
	@echo "Data setup for final verification using Tempus Timing Signoff Solution .............."
	Core_define.pl -verify_tempus -o ./$(TEMPUSDIR)/Tempus_define.tcl
	@echo "> create softlinks to netlist, extracted spefs"
	@(cd $(TEMPUSDIR); rm -f $(CORE_PREFIX)_netlist.v $(CORE_PREFIX)_verify_max.spef $(CORE_PREFIX)_verify_min.spef $(CORE_PREFIX)_verify_typ.spef; cd ..)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(LAYOUTDIR) SRC_FILE=$(CORE_PREFIX)_routed.v TARG_DIR=$(TEMPUSDIR) TARG_FILE=$(CORE_PREFIX)_netlist.v check_n_symlink)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(EXTDIR) SRC_FILE=$(CORE_PREFIX)_extract_max.spef TARG_DIR=$(TEMPUSDIR) TARG_FILE=$(CORE_PREFIX)_verify_max.spef check_n_symlink)
	@(if [ -e $(EXTDIR)/$(CORE_PREFIX)_extract_min.spef ]; then \
		$(MAKE) -s FLOW=verify SRC_DIR=$(EXTDIR) SRC_FILE=$(CORE_PREFIX)_extract_min.spef TARG_DIR=$(TEMPUSDIR) TARG_FILE=$(CORE_PREFIX)_verify_min.spef check_n_symlink; \
	else \
		$(MAKE) -s FLOW=verify SRC_DIR=$(EXTDIR) SRC_FILE=$(CORE_PREFIX)_extract_max.spef TARG_DIR=$(TEMPUSDIR) TARG_FILE=$(CORE_PREFIX)_verify_min.spef check_n_symlink; \
	fi)
	@(if [ -e $(EXTDIR)/$(CORE_PREFIX)_extract_typ.spef ]; then \
		$(MAKE) -s FLOW=verify SRC_DIR=$(EXTDIR) SRC_FILE=$(CORE_PREFIX)_extract_typ.spef TARG_DIR=$(TEMPUSDIR) TARG_FILE=$(CORE_PREFIX)_verify_typ.spef check_n_symlink; \
	else \
		$(MAKE) -s FLOW=verify SRC_DIR=$(EXTDIR) SRC_FILE=$(CORE_PREFIX)_extract_max.spef TARG_DIR=$(TEMPUSDIR) TARG_FILE=$(CORE_PREFIX)_verify_typ.spef check_n_symlink; \
	fi)
	@cp -fp $(SCRIPTS)/tempus/Tempus_verify.tcl $(TEMPUSDIR)

ifeq ($(TSO_OPT2),0)
TSO_INNOVUSDIR = $(LAYOUTDIR)
TSO_QRCDIR = $(EXTDIR)
TSO_IRDIR = $(IRDROPDIR)
TSO_OUTDIR = tempus_tso
else 
TSO_INNOVUSDIR = tempus_tso
TSO_QRCDIR = tempus_tso
TSO_IRDIR = $(IRDROPDIR)_tso
TSO_OUTDIR = tempus_tso_pass2
endif

tso_opt: 
	@($(MAKE) -s tempus_tso)
	@($(MAKE) -s innovus_eco)
	@($(MAKE) -s qrc_eco)
	@($(MAKE) -s tempus_validate)

tempus_validate: 
	@echo "Data setup for tso validate using Tempus Timing Signoff Solution .............."
	Core_define.pl -verify_tempus -o ./$(TSO_OUTDIR)/Tempus_define.tcl
	@(cd $(TSO_OUTDIR); cp -rf ../CadSetup.file .debug/CadSetup.file_validate; cd ..)
	@(cd $(TSO_OUTDIR); rm -f $(CORE_PREFIX)_netlist.v $(CORE_PREFIX)_verify_max.spef $(CORE_PREFIX)_verify_min.spef $(CORE_PREFIX)_verify_typ.spef; cd ..)
	@echo "> create softlinks to eco netlist, extracted spefs"
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_OUTDIR) SRC_FILE=$(CORE_PREFIX)_routed_eco.v TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_netlist.v check_n_symlink)
ifeq ($(USE_MEMORY_MACROS),1)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(CDNSSYNDIR) SRC_FILE=$(CORE_PREFIX)_syn.memory_macro_list TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_syn.memory_macro_list check_n_symlink)
endif
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_OUTDIR) SRC_FILE=$(CORE_PREFIX)_extract_max.spef TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_verify_max.spef check_n_symlink)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_OUTDIR) SRC_FILE=$(CORE_PREFIX)_extract_min.spef TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_verify_min.spef check_n_symlink)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_OUTDIR) SRC_FILE=$(CORE_PREFIX)_extract_typ.spef TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_verify_typ.spef check_n_symlink)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_OUTDIR)/final.enc.dat/mmmc/modes/setup_view_functional SRC_FILE=setup_view_functional.sdc TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_cons.sdc check_n_symlink)

	@(cd $(TSO_OUTDIR); \
		tempus -nowin -init Tempus_verify.tcl > Tempus_verify.log; )
	@(cd $(TSO_OUTDIR); \
		genus-path-compressor.pl -tempus -i $(CORE_PREFIX)_verify.timing -o $(CORE_PREFIX)_verify.timing.cmpr; \
		genus-path-compressor.pl -tempus -i $(CORE_PREFIX)_verify.min.timing -o $(CORE_PREFIX)_verify.min.timing.cmpr; \
		if [ -e $(CORE_PREFIX)_verify.recalc_timing ]; then \
		genus-path-compressor.pl -tempus -i $(CORE_PREFIX)_verify.recalc_timing -o $(CORE_PREFIX)_verify.recalc_timing.cmpr; \
		fi; \
		if [ -e $(CORE_PREFIX)_verify.min.recalc_timing ]; then \
		genus-path-compressor.pl -tempus -i $(CORE_PREFIX)_verify.min.recalc_timing -o $(CORE_PREFIX)_verify.min.recalc_timing.cmpr; \
		fi; \
		cd ..;)
	@(cd $(TSO_OUTDIR); \
		rm -rf tempus.cmd* tempus.log* *cmdlog *wire*rpt* ecoTiming*; \
		cd ..;)
	@($(MAKE) -s TOOL=tempus FLOW=tempus_validate DIR=$(TSO_OUTDIR) LOG=Tempus_verify.log CHECK_TIMING=1 TIMING_FILE="$(DESIGN)_verify.timing" check_error)

tempus_tso: tso_tempus_setup
	@echo "Running tso opt using Tempus Timing Signoff Solution for $(CORE_PREFIX) ......................"
	@(cd $(TSO_OUTDIR); \
		tempus -nowin -tso -init Tempus_verify.tcl > Tempus_verify_tso.log; )
	@($(MAKE) -s TOOL=tempus FLOW=tempus_tso DIR=$(TSO_OUTDIR) LOG=Tempus_verify_tso.log CHECK_TIMING=1 TIMING_FILE="$(DESIGN)_verify_tso.timing" check_error)
	@(cd $(TSO_OUTDIR); \
		rm -f tempus.cmd* tempus.log* *routed.def eco.ird; \
		cd ..;)

tso_tempus_setup:
ifeq ($(TSO_OPT)$(TSO_OPT2),00)
	echo "ERROR: Tempus_TSO_Opt and Tempus_TSO_Opt_Pass2 are both set to 0. Please modify CadSetup.file."
	exit 1;
else
	@echo "Data setup for $(CORE_PREFIX) tso opt using Tempus Timing Signoff Solution .............."
	@echo "Using TSO_INNOVUSDIR : $(TSO_INNOVUSDIR) TSO_EXTDIR : $(TSO_QRCDIR) TSO_OUTDIR : $(TSO_OUTDIR).............."
	Core_define.pl -verify_tempus -o ./$(TSO_OUTDIR)/Tempus_define.tcl -tso
	@(cd $(TSO_OUTDIR); mkdir .debug; cp -rf ../CadSetup.file .debug/CadSetup.file_tso; cd ..)
	@echo "> create softlinks to netlist, extracted spefs"
	@cp -fp $(SCRIPTS)/tempus/Tempus_verify.tcl $(TSO_OUTDIR)
	@(cd $(TSO_OUTDIR); cp -rf ../$(TSO_INNOVUSDIR)/final.enc.dat final.enc.dat; cd ..)
	@(cd $(TSO_OUTDIR); cp -f ../$(TSO_INNOVUSDIR)/final.enc final.enc; cd ..)
	@(cd $(TSO_OUTDIR); rm -f $(CORE_PREFIX)_netlist.v $(CORE_PREFIX)_verify_max.spef $(CORE_PREFIX)_verify_min.spef $(CORE_PREFIX)_verify_typ.spef; cd ..)
endif
ifneq ($(TSO_OPT2),0)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_INNOVUSDIR) SRC_FILE=$(CORE_PREFIX)_routed_eco.v TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_netlist.v check_n_symlink)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_INNOVUSDIR) SRC_FILE=$(CORE_PREFIX)_routed_eco.def TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_routed.def check_n_symlink)
else
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_INNOVUSDIR) SRC_FILE=$(CORE_PREFIX)_routed.v TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_netlist.v check_n_symlink)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_INNOVUSDIR) SRC_FILE=$(CORE_PREFIX)_routed.def TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_routed.def check_n_symlink)
endif
	@(cd $(TSO_OUTDIR); ../scripts/automation/TSO_Innovus_Lib_edit.pl; cd ..)
	@($(MAKE) -s FLOW=verify SRC_DIR=$(TSO_QRCDIR) SRC_FILE=$(CORE_PREFIX)_extract_max.spef TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_verify_max.spef check_n_symlink)
	@(if [ -e $(TSO_QRCDIR)/$(CORE_PREFIX)_extract_min.spef ]; then \
		$(MAKE) -s FLOW=verify SRC_DIR=$(TSO_QRCDIR) SRC_FILE=$(CORE_PREFIX)_extract_min.spef TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_verify_min.spef check_n_symlink; \
	else \
		$(MAKE) -s FLOW=verify SRC_DIR=$(TSO_QRCDIR) SRC_FILE=$(CORE_PREFIX)_extract_max.spef TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_verify_min.spef check_n_symlink; \
	fi)
	@(if [ -e $(TSO_QRCDIR)/$(CORE_PREFIX)_extract_typ.spef ]; then \
		$(MAKE) -s FLOW=verify SRC_DIR=$(TSO_QRCDIR) SRC_FILE=$(CORE_PREFIX)_extract_typ.spef TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_verify_typ.spef check_n_symlink; \
	else \
		$(MAKE) -s FLOW=verify SRC_DIR=$(TSO_QRCDIR) SRC_FILE=$(CORE_PREFIX)_extract_max.spef TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_verify_typ.spef check_n_symlink; \
	fi)

qrc_eco: qrc_eco_setup
	@echo "Running eco extract using QRC ............................................."
	(cd $(TSO_OUTDIR); QRC_setup.pl -in QRC_define.cmd; cd ../)
	(cd $(TSO_OUTDIR); mv QRC_extract.cmd $(CORE_PREFIX)_extract.cmd; cd ../)
	(cd $(TSO_OUTDIR); qrc -cmd $(CORE_PREFIX)_extract.cmd $(CORE_PREFIX)_extract.def; cd ../)
	(cd $(TSO_OUTDIR); if [ -e qrc.log ]; then mv -f qrc.log $(CORE_PREFIX)_extract.log; fi; cd ../)
	@(cd $(TSO_OUTDIR); if [ -e $(CORE_PREFIX)_extract_max_*.spef ]; then mv -f $(CORE_PREFIX)_extract_max_*.spef $(CORE_PREFIX)_extract_max.spef; fi; cd ../)
	@(cd $(TSO_OUTDIR); if [ -e $(CORE_PREFIX)_extract_min_*.spef ]; then mv -f $(CORE_PREFIX)_extract_min_*.spef $(CORE_PREFIX)_extract_min.spef; fi; cd ../)
	@(cd $(TSO_OUTDIR); if [ -e $(CORE_PREFIX)_extract_typ_*.spef ]; then mv -f $(CORE_PREFIX)_extract_typ_*.spef $(CORE_PREFIX)_extract_typ.spef; fi; cd ../)
	@(cd $(TSO_OUTDIR); if [ ! -e $(CORE_PREFIX)_extract_typ.spef ]; then ln -s $(CORE_PREFIX)_extract_max.spef $(CORE_PREFIX)_extract_typ.spef; fi; cd ../)
	@(cd $(TSO_OUTDIR); if [ -e __* ]; then rm -f __*; fi; cd ../)
	@($(MAKE) -s TOOL=qrc FLOW=extract_qrc DIR=$(TSO_OUTDIR) LOG=$(CORE_PREFIX)_extract.log check_error)

qrc_eco_setup:
	@echo "Data setup for qrc eco using QRC ......................................"
	(cd $(TSO_OUTDIR); if [ -e *extract_max.spef ]; then rm *extract_max.spef; fi; cd ../)
	(cd $(TSO_OUTDIR); if [ -e *extract_min.spef ]; then rm *extract_min.spef; fi; cd ../)
	(cd $(TSO_OUTDIR); if [ -e *extract_typ.spef ]; then rm *extract_typ.spef; fi; cd ../)
	Core_define.pl -extract -o ./$(TSO_OUTDIR)/QRC_define.cmd
	@(cd $(TSO_OUTDIR); cp -f ../scripts/qrc/QRC_extract.cmd .; cd ../)
	@echo "> create softlinks to routed def file"
	@($(MAKE) -s FLOW=extract SRC_DIR=$(TSO_OUTDIR) SRC_FILE=$(CORE_PREFIX)_routed_eco.def TARG_DIR=$(TSO_OUTDIR) TARG_FILE=$(CORE_PREFIX)_extract.def check_n_symlink)

innovus_eco: innovus_eco_setup
	@echo "Running innovus_eco Place and Route .............................."
	@(cd $(TSO_OUTDIR); innovus -replay Innovus_eco.cmd -nowin -nologv -log Innovus_flow.log; cd ..)
	@(cd $(TSO_OUTDIR); if [ -e ../$(LAYOUTDIR)/$(CORE_PREFIX)_routed_abstract.lef ]; then ln -s ../$(LAYOUTDIR)/$(CORE_PREFIX)_routed_abstract.lef; fi; cd ..)
	@($(MAKE) -s TOOL=innovus FLOW=innovus_eco DIR=$(TSO_OUTDIR) LOG=Innovus_flow.log CHECK_TIMING=0 check_error)

innovus_eco_setup:
	@echo "Data setup for layout using Innovus ................................"
	@echo "> Create softlinks to netlist and synthesis constraints"
	@(cd $(TSO_OUTDIR); rm -fr Innovus_flow.log* Innovus_flow.cmd* reports *.area *.ref ; cd ..)
	@echo "> generate Innovus Scripts"
	@echo "Copying top-level command file to tempus_tso directory"
	@cp -fp $(SCRIPTS)/tempus/Innovus_eco.cmd $(TSO_OUTDIR)
	(cd $(TSO_OUTDIR); if [ -e *extract_max.spef ]; then rm *extract_max.spef; fi; cd ../)
	(cd $(TSO_OUTDIR); if [ -e *extract_min.spef ]; then rm *extract_min.spef; fi; cd ../)
	(cd $(TSO_OUTDIR); if [ -e *extract_typ.spef ]; then rm *extract_typ.spef; fi; cd ../)
	@(cd $(TSO_OUTDIR); ln -s ../$(TSO_QRCDIR)/$(CORE_PREFIX)_extract_max.spef; cd ..)
	@(cd $(TSO_OUTDIR); ln -s ../$(TSO_QRCDIR)/$(CORE_PREFIX)_extract_min.spef; cd ..)
	@(if [ -e $(TSO_QRCDIR)/$(CORE_PREFIX)_extract_typ.spef ]; then \
		cd $(TSO_OUTDIR);  \
		ln -s ../$(TSO_QRCDIR)/$(CORE_PREFIX)_extract_typ.spef; \
		cd ..; \
	else \
		cd $(TSO_OUTDIR);  \
		ln -s ../$(TSO_QRCDIR)/$(CORE_PREFIX)_extract_max.spef $(CORE_PREFIX)_extract_typ.spef; \
		cd ..; \
	fi)
	@(cd $(TSO_OUTDIR); ln -s ../$(LAYOUTDIR)/Innovus_define.cmd; cd ..)


# -------------------------------------------------------------------------------
# generic targets to check correctness of xda flow
# -------------------------------------------------------------------------------

check_error:
	@(Error_Check.pl -log $(DIR)/$(LOG) -tool $(TOOL) -flow $(FLOW))
ifeq ($(CHECK_TIMING),1)
	@if [ ! -e $(DIR)/$(TIMING_FILE) ]; then \
	  echo "ERROR : Your \"make $(FLOW)\" run did not generate the right output file it is supposed to." ; \
	  echo "ERROR : Please verify your log file $(DIR)/$(LOG) for any possible problem." ; \
	  exit 1; \
	fi
endif

check_n_symlink:
	@if [ -e $(SRC_DIR)/$(SRC_FILE) ]; then \
		cd $(TARG_DIR) ; \
		ln -s ../$(SRC_DIR)/$(SRC_FILE) $(TARG_FILE) ; \
		cd .. ; \
	else \
		echo "ERROR : The file $(SRC_DIR)/$(SRC_FILE) does not exist." ; \
		echo "ERROR : It is required for the \"make $(FLOW)\" flow to run." ; \
		exit 1; \
	fi


# -------------------------------------------------------------------------------
# cleanup
# -------------------------------------------------------------------------------

cleanup:  extract_qrc_cleanup

extract_qrc_cleanup:
	( cd $(EXTDIR); \
		echo "> clean up SPEF files"; \
		\rm -rf *.spef; \
		cd .. )

.PHONY : syn_genus genus_fp_check genus_custom_ple
.PHONY : conformal_check
.PHONY : layout_innovus layout_innovus_rerun
.PHONY : extract_qrc
.PHONY : verify_tempus 
