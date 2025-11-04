# Makefile for generating simulation and synthesis filelists


OUTPUT_DIR         := $(PHY_DESIGN_AREA)/design/filelist/output
SIM_FILELIST_HLM   := $(PHY_DESIGN_AREA)/design/filelist/output/timberwolf_phy_hlm_sim.f
SIM_FILELIST_MLM   := $(PHY_DESIGN_AREA)/design/filelist/output/timberwolf_phy_mlm_sim.f
PHY_SYNTH_FILELIST := $(PHY_DESIGN_AREA)/design/filelist/output/timberwolf_phy_synth.f
PMA_SYNTH_FILELIST := $(PHY_DESIGN_AREA)/design/filelist/output/timberwolf_pma_synth.f

PHY_COMMON_RLT_FILELIST := \
'$$PHY_DESIGN_AREA'/design/filelist/timberwolf_phy.f \
'$$PHY_DESIGN_AREA'/design/filelist/timberwolf_phy_reuse.f

PMA_COMMON_RLT_FILELIST := \
'$$PHY_DESIGN_AREA'/design/filelist/timberwolf_pma_top.f \
'$$PHY_DESIGN_AREA'/design/filelist/timberwolf_pma_reuse.f


SIM_ONLY_FILELIST_HLM := \
'$$PHY_DESIGN_AREA'/design/filelist/timberwolf_pma_hlm.f \
'$$PHY_DESIGN_AREA'/design/filelist/timberwolf_std_cell_sim.f

SIM_ONLY_FILELIST_MLM := \
'$$PHY_DESIGN_AREA'/design/filelist/timberwolf_pma_mlm.f \
'$$PHY_DESIGN_AREA'/design/filelist/timberwolf_std_cell_sim.f

SYNTH_ONLY_FILELIST := \
'$$PHY_DESIGN_AREA'/design/filelist/timberwolf_std_cell_synth.f

PHY_COMMON_MACRO  := \
+define+MP_128B_PATH \
+define+MP_128B_PATH_32_BIT \
+define+MP_RATE_CHG_A2_EN \
+define+MP_USB \
+define+MP_USB3_2 \
+define+LM_DEP_OPTION \
+define+SD3101_N4P_22_VS130_1XAH1XBV1XCH1XDV1YAH1YBV4YHVHV2Z

PMA_COMMON_MACRO  := \
+define+SD3101_N4P_22_VS130_1XAH1XBV1XCH1XDV1YAH1YBV4YHVHV2Z


SYNTH_MACRO := \
+define+SYNTHESIS \
+define+USE_TSMC_N4P_LIB \
+define+CDNS_PMA_PWR_AWARE

all: clean sim synth

$(OUTPUT_DIR):
	@mkdir -p $@

# Generate simulation filelist
sim: $(SIM_FILELIST_HLM) $(SIM_FILELIST_MLM)

# Generate synthesis filelist
synth: $(PHY_SYNTH_FILELIST) $(PMA_SYNTH_FILELIST)


$(SIM_FILELIST_HLM): $(OUTPUT_DIR)
	@echo "// Simulation filelist generated on $$(date)" > $@
	@for var in $(PHY_COMMON_MACRO); do \
		echo "$$var" >> $@; \
	done
	@for file in $(PHY_COMMON_RLT_FILELIST); do \
		echo  "-F $$file" >> $@; \
	done
	@for file in $(PMA_COMMON_RLT_FILELIST); do \
		echo  "-F $$file" >> $@; \
	done
	@for file in $(SIM_ONLY_FILELIST_HLM); do \
		echo "-F $$file" >> $@; \
	done

$(SIM_FILELIST_MLM): $(OUTPUT_DIR)
	@echo "// Simulation filelist generated on $$(date)" > $@
	@for var in $(PHY_COMMON_MACRO); do \
		echo "$$var" >> $@; \
	done
	@for file in $(PHY_COMMON_RLT_FILELIST); do \
		echo  "-F $$file" >> $@; \
	done
	@for file in $(PMA_COMMON_RLT_FILELIST); do \
		echo  "-F $$file" >> $@; \
	done
	@for file in $(SIM_ONLY_FILELIST_MLM); do \
		echo "-F $$file" >> $@; \
	done

$(PHY_SYNTH_FILELIST): $(OUTPUT_DIR)
	@echo "// Synthesis filelist generated on $$(date)" > $@
	@for var in $(PHY_COMMON_MACRO); do \
		echo "$$var" >> $@; \
	done
	@for var in $(SYNTH_MACRO); do \
		echo "$$var" >> $@; \
	done
	@for file in $(PHY_COMMON_RLT_FILELIST); do \
		echo "-F $$file" >> $@; \
	done
	@for file in $(SYNTH_ONLY_FILELIST); do \
		echo "-F $$file" >> $@; \
	done

$(PMA_SYNTH_FILELIST): $(OUTPUT_DIR)
	@echo "// Synthesis filelist generated on $$(date)" > $@
	@for var in $(PMA_COMMON_MACRO); do \
		echo "$$var" >> $@; \
	done
	@echo "+define+HBDC_SYNTHESIS" >> $@
	@for var in $(SYNTH_MACRO); do \
		echo "$$var" >> $@; \
	done
	@for file in $(PMA_COMMON_RLT_FILELIST); do \
		echo "-F $$file" >> $@; \
	done
	@for file in $(SYNTH_ONLY_FILELIST); do \
		echo "-F $$file" >> $@; \
	done

clean:
	rm -rf $(OUTPUT_DIR)
