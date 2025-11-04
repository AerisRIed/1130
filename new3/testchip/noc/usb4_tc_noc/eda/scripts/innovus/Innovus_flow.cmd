#############################################################################################
#        Copyright (c) 2009-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

###############################################################################################
## Disclaimer : This EDA Flow is going through internal review process and subject to change  #
###############################################################################################

######################################################
#                                                    #
# Innovus P&R Flow Main Script                       #
#                                                    #
######################################################
report_resource -start fullFlow
source Innovus_define.cmd
set elapsed_mins [expr [clock clicks -milliseconds] / 60000]

if {![info exists SUPERTHREAD_COUNT]} {
  set SUPERTHREAD_COUNT 1
}
setMultiCpuUsage -localCpu $SUPERTHREAD_COUNT

source ../scripts/innovus/Innovus_util.cmd
source ../scripts/innovus/Innovus_cons.cmd
source ../scripts/innovus/Innovus_autofp.cmd
source ../scripts/innovus/Innovus_DFM_flow.cmd

TIP_get_file_name_prefix

set VER [lindex [split [getVersion] {-}] 0]

setCheckMode -tapeOut true
TIP_invokeError -id {IMPSP-365 ENCDF-84  IMPSP-270}
TIP_suppressError -id {ENCLF-223 IMPLF-223 IMPLF-302 TCLCMD-917  TECHLIB-1398 TA-533 IMPDB-1221}
 
if {$VER >= 17.1 && $VER <= 21.12} {
  TIP_suppressError -id TECHLIB-1318 
}

if {$VER == 21.12 && $LIB_PROCESS_NODE == 7 && $Innovus_ExtremeFlow == 1} {
  source  ../scripts/innovus/Innovus_ExtremeFlow_WorkAround.cmd
}

set runPlaceFlag 1
if {[file exists Innovus_Lib/preCtsOpt.enc.dat]} {
  set runPlaceFlag 0
}

set init_design_uniquify 1
TIP_check_derate_method 

if {$Innovus_ViaPillarFlow==1} {
  set mustjoinallports_is_one_pin 1
  setGenerateViaMode -auto true 
  setGenerateViaMode -advanced_rule true
}

if {$LIB_PROCESS_NODE <= 3 && $Innovus_UltraAccuracyMode == 1} {
  set_global timing_derate_spatial_distance_unit 1nm
}

if {$runPlaceFlag == 1} {
######################################################
# Init Design                                        #
######################################################
  if {$Innovus_UseiSpatialDB == 1} {
    if {$VER > 22} {
      if {[file exists ../syn_genus/${FILE_NAME_PREFIX}_syn.db]} {
        ln -sfn ../syn_genus/${FILE_NAME_PREFIX}_syn.db ./
        read_db ${FILE_NAME_PREFIX}_syn.db
        set timing_report_enable_novus_header false
      } else {
        Puts [format "%s%s" "**ERR" "OR: There was no iSpatial DB to load."]
        Puts [format "%s%s" "**ERR" "OR: Please check if an iSpatial DB was generated in Synthesis"]
        exit
      }
    } else {
      if {[file exists ../syn_genus/genus_innovus_interface_data/invs2genus_db]} {
        source ../syn_genus/genus_innovus_interface_data/invs2genus_db
      } else {
        Puts [format "%s%s" "**ERR" "OR: There was no iSpatial DB to load."]
        Puts [format "%s%s" "**ERR" "OR: Please check if an iSpatial DB was generated in Synthesis"]
        exit
      }
    }
    source Innovus_corner_define.cmd
    TIP_get_sdc_units
  } else {
    set init_import_mode {-treatUndefinedCellAsBbox 0 -keepEmptyModule 1} 
    set init_verilog [format "%s%s" $FILE_NAME_PREFIX "_netlist.v"]
    set init_design_netlisttype {Verilog}
    set init_design_settop {0}
    set init_lef_file "$Lib_CadencePhysicalLibrary"
    if {$Innovus_ViaPillarFlow==1} {
      if {$Lib_ViaPillar_LEF eq "_none_"} {
        Puts [format "%s%s" "**ERR" "OR: Lib_ViaPillar_LEF is required to enable Via Pillar flow."]
        exit
      } else {
        set init_lef_file "$Lib_CadencePhysicalLibrary $Lib_ViaPillar_LEF"
      }
    }
    set init_pwr_net "$Fplan_PowerNetName"
    set init_gnd_net "$Fplan_GroundNetName"
    set init_assign_buffer {0}
    if {$USE_POWER_LIBRARY == 0 } {
      set init_mmmc_file Innovus_corner_define_disable_powerLIB.cmd
    } else {
      set init_mmmc_file Innovus_corner_define.cmd
    } 
    set delaycal_use_default_delay_limit {1000}
    set delaycal_default_net_delay {1000.0ps} 
    set delaycal_default_net_load {2.0pf}
    set delaycal_input_transition_delay {100ps}
    
    TIP_get_sdc_units
    
    init_design
  }
  set i 0
  foreach CP $CLK_PORT {
    set CLK_PERIOD 0
    if {[lindex $CLK_FREQ $i] != 0} {set CLK_PERIOD [expr 1 / [lindex $CLK_FREQ $i]]}
    if {[sizeof_collection [get_clocks -quiet $CP]]!=0} {
      if {($CLK_PERIOD != 0) && ([lindex [get_attribute [get_clock $CP] period] 0] != $CLK_PERIOD)} {
        set_interactive_constraint_modes [all_constraint_modes -active] 
        reset_propagated_clock [get_clock_source $CP]
        set CLK_SOURCE_PORT [get_clock_source $CP]
        create_clock $CLK_SOURCE_PORT -name $CP -period $CLK_PERIOD
        reset_clock_uncertainty $CP
        if {$CLOCK_JITTER != 0} {
          set_clock_uncertainty -setup $CLOCK_JITTER [get_clocks $CP]
        }
        if {$HOLD_MARGIN != 0} {
          set_clock_uncertainty -hold $HOLD_MARGIN [get_clocks $CP]
        }
        set_interactive_constraint_modes {}    
      }
    }
    incr i
  }
  if {$Innovus_ViaPillarFlow==1} {
    if {$Lib_ViaPillar_Associations eq "_none_"} {
      Puts [format "%s%s" "**ERR" "OR: Lib_ViaPillar_Associations is required to enable Via Pillar flow."]
      exit
    } else {
      foreach association_tcl $Lib_ViaPillar_Associations {
        source $association_tcl
      }
      setOptMode -viaPillarEffort low
    }
  }

  TIP_applyDerate

  ##########################################################
  # Create directory for storing design pnr steps
  ##########################################################
  if ([file exists Innovus_Lib]) {
    system rm -rf Innovus_Lib
  }
  system mkdir Innovus_Lib

  ##########################################################
  # Read in the Floorplan
  ##########################################################
  if {$Innovus_UseiSpatialDB == 0} {
    if {$Innovus_FP_USE == 0} {
      source Innovus_define.cmd
      source ../scripts/innovus/Innovus_util.cmd
      source ../scripts/innovus/Innovus_cons.cmd
      TIP_create_floorplan
    } elseif {$Innovus_FP_USE == 1} {
      TIP_create_floorplan
      Puts "INFO: floorplan generated. Stopping as Innovus_DEF_USE = 1."
      exit
    } elseif {$Innovus_FP_USE == 2} {
      redirect -variable fp_read_log -tee {defIn $FPLAN_FILE}
      Puts $fp_read_log
      if {[regexp {\*\*ER.OR:} $fp_read_log]==1} {
        Puts [format "%s%s" "**ERR" "OR: There was a problem  while reading in user"]
        Puts [format "%s%s" "**ERR" "OR: floorplan DEF. Please check earlier errors"]
        Puts [format "%s%s" "**ERR" "OR: in the log and correct."]
        exit -1
      }
      TIP_verifyDRC
      set drc [open ./drc.rpt r]
      foreach drc_line [split [read $drc ] \n] {
        if {[regexp {Directional SpanLength SameMask Spacing.* M0 } $drc_line]==1} {
          Puts [format "%s%s" "**ERR" "OR: There was a problem while reading in user floorplan DEF."]
          Puts [format "%s%s" "**ERR" "OR: Please check earlier errors or DSLCol violations on M0."]
          exit -1
        }
      }
      set Innovus_PlaceIOPins 2
    } else {
      Puts [format "%s%s" "**ERR" "OR: No floorplan available for PNR."]
      exit    
    }
    if {($Innovus_MixedPlacer == 1)} {
      if {[sizeof_collection [get_cells -hierarchical * -filter "is_macro_cell==true"]] > [sizeof_collection [get_cells -hierarchical * -filter "is_memory_cell==true"]]} {
        Puts [format "%s%s" "**ERR" "OR: Mixed placer flow is currently not supported for designs having ETM or ILM blocks."
        Puts [format "%s%s" "**ERR" "OR: Provide path to a DEF file to the Fplan_File variable. Rerun with Innovus_MixedPlacer set to 0 and Innovus_FP_USE set to 2."]
        exit
      } elseif {[sizeof_collection [get_cells -hierarchical * -filter "is_memory_cell==true"]] != 0} {
        if {[dbget top.insts.isPhysOnly 1 ] != 0x0} {
          deleteInst [dbget [dbget top.insts.isPhysOnly 1 -p1].name] 
        }
        deleteAllDensityAreas
        addHaloToBlock -allBlock {2 2 2 2}
        set_macro_place_constraint -min_space_to_core 10 -forbidden_space_to_core 5 -min_space_to_macro 10 -forbidden_space_to_macro 5 -max_io_pin_group_keep_out 20
        set mem_lst [dbget top.insts.cell.subClass block -p2]
        foreach mem $mem_lst {
          dbSet $mem.pStatus placed
        }
      }
    }
  }

  TIP_globalConnect

  set unplaced_ios 0
  #Place IO pins
  if {($GENUS_USE_ISPATIAL == 1) || ($Innovus_PlaceIOPins == 2)} {
    TIP_checkUnplacedPin
  } else {
    if {$Innovus_PlaceIOPins == 1} {
      TIP_checkUnplacedPin
    } else {
      setPlaceMode -placeIoPins true 
    }
  }
  if {$unplaced_ios > 0} {
    Puts [format "%s%s" "**ERR" "OR: Not all IO pins are placed."]
    exit -1
  }
    
  clearDrc

  ##########################################################
  # Set routing constraints
  ##########################################################
  setAttribute -net $Fplan_PowerNetName  -skip_routing true
  setAttribute -net $Fplan_GroundNetName -skip_routing true
  
  # Perform Antenna Check
  if {$Innovus_DfmFlow != 0} {
    TIP_antenna_check
  }

  TIP_setRoutingLayer
  TIP_setNanoRouteSettings 

  ##########################################################
  # Allow async set/reset pin timing of sequential elements
  ##########################################################
  set_global lib_build_asynch_de_assert_arc true

  ##########################################################
  # Set timing analysis/optimization options
  ##########################################################
  setDesignMode -process $LIB_PROCESS_NODE -node $LIB_TECH_NODE
  setDesignMode -flowEffort standard

  set cell_name [TIP_get_cellname_postfix]
  
  if {$Innovus_InsertionDelayFactor != 1.5} {
    set_ccopt_property auto_limit_insertion_delay_factor $Innovus_InsertionDelayFactor   
  }
  if {$Innovus_MaxAllowedDelay != 1.0} {
    setUsefulSkewMode -maxAllowedDelay $Innovus_MaxAllowedDelay
  }  
  if {$Innovus_WFP == 1 && $LIB_PROCESS_NODE < 30} {
    setDelayCalMode -equivalent_waveform_model propagation -ewm_type simulation -enable_quiet_receivers_for_hold true
  }
  if { $LIB_PROCESS_NODE <= 7} {
    setDelayCalMode -signoff_alignment_settings true
  }
       
  if {$Innovus_ExtremeFlow == 1} {
    Puts [format "%s%s" "**ERR" "OR: Innovus Extreme flow is a limited access feature."]
    Puts [format "%s%s" "**ERR" "OR: Contact Cadence Support for setLimitedAccessFeature key."]
    Puts [format "%s%s" "**ERR" "OR: Proceeding without the setLimitedAccessFeature key."]
    setDesignMode -flowEffort extreme
    setOptMode -expExtremeHighEffOpt true       
  }

  if {$LIB_PROCESS_NODE == 16} {
    set timing_library_gen_constraint_table_using_sigma_values 0
    set timing_library_setup_sigma_multiplier 0
    set timing_library_hold_sigma_multiplier 0
  }
  
  set_interactive_constraint_modes [all_constraint_modes -active]

  #Make sure all dont_touch lib cells are dont_use
  foreach_in_collection lcell [get_lib_cells *] {
    if {[get_property $lcell is_dont_touch]==true} {
      set_dont_use $lcell true
    }
  }
  set_max_transition $MAX_DATA_TRANSITION [current_design]
  foreach CP $CLK_PORT {set_annotated_transition [expr 0.5 * $MAX_CLOCK_TRANSITION] [get_ports $CP]}

  set_global timing_disable_backward_compatible_path_group_through_mode true

  if {$Innovus_EnablePathGroups == 1} {
    TIP_create_path_groups
    set i 1
    foreach CP $CLK_PORT {
      if {[sizeof_collection [get_path_groups -quiet CLK$i]]>0} {
        setPathGroupOptions CLK$i -effortLevel high
      }
      if {[sizeof_collection [get_path_groups -quiet I2F_$i]]>0} {
        setPathGroupOptions I2F_$i -effortLevel high
      }
      if {[sizeof_collection [get_path_groups -quiet F2O_$i]]>0} {
        setPathGroupOptions F2O_$i -effortLevel high
      }
      incr i
    }
    if {[sizeof_collection [get_path_groups -quiet mem_io]]>0} {
      setPathGroupOptions mem_io -effortLevel high
    }
    if {[sizeof_collection [get_path_groups -quiet power_clkgate]]>0} {
      setPathGroupOptions power_clkgate -effortLevel high
    }
    if {[sizeof_collection [get_path_groups -quiet I2O]]>0} {
      setPathGroupOptions I2O -effortLevel high
    }
    if {[sizeof_collection [get_path_groups -quiet PMDA_TCK]]>0} {
      setPathGroupOptions PMDA_TCK -effortLevel high
    }
    if {[sizeof_collection [get_path_groups -quiet mbist_io_paths]]>0} {
      setPathGroupOptions mbist_io_paths -effortLevel high
    }
  }
  set_interactive_constraint_modes {}
  
  if {$LOW_POWER_FLOW != 0} {
    if {$LOW_POWER_STIM_FILE != "{}"} {
      read_activity_file $LOW_POWER_SAIF_FILE -format SAIF
      propagate_activity
    }
    if {($LOW_POWER_GOAL == 4) || ($LOW_POWER_GOAL == 5)} {
      setOptMode -powerEffort high -leakageToDynamicRatio $LOW_POWER_LDR -drcMargin -0.2
    } elseif {($LOW_POWER_GOAL == 2) || ($LOW_POWER_GOAL == 3)} {
      setOptMode -powerEffort high -leakageToDynamicRatio 0 -drcMargin -0.2
    } else {
      setOptMode -powerEffort high -leakageToDynamicRatio 1 -drcMargin -0.2
    }
    if {$LIB_PROCESS_NODE == 5} {
      if {($LOW_POWER_GOAL == 1) || ($LOW_POWER_GOAL == 4) || ($LOW_POWER_GOAL == 5)} {
        if {($Lib_CNODEdge_Info ne "{}") && ($Lib_MinCNODLeak_Info ne "{}") && ($Lib_CNODLeak_Config ne "{}")} {
          load_side_file -files [list $Lib_CNODEdge_Info $Lib_MinCNODLeak_Info $Lib_CNODLeak_Config] -dump_tcl_file lef_side_file.tcl
          source lef_side_file.tcl
          set cmd "cat $Lib_MinCNODLeak_Info $Lib_CNODLeak_Config > all_lib_side_file.txt"
          eval exec $cmd
          set_power_analysis_mode -boundary_gate_leakage_file all_lib_side_file.txt -write_static_currents true -boundary_gate_leakage_report true -boundary_leakage_multi_pgpin_support true -boundary_leakage_PXE_support true
        } else {
          Puts [concat "**WAR" "N: For a CNOD process, without specifying Lib_CNODEdge_Info, Lib_MinCNODLeak_Info and Lib_CNODLeak_Config files, run will continue without reporting CNOD boundary leakge."]
        }
      }
    }
  }

  if {$Innovus_MinAreaFlow == 1} {
    setOptMode -reclaimArea true -postRouteAreaReclaim holdAndSetupAware
  }

  TIP_setDerateSettings    
  TIP_set_uncertainties $Innovus_PreCTSUncertainty

  ###########################################################
  ## Perform design checks
  ###########################################################
  
  redirect design_check.rpt {checkDesign -all}
  redirect design_timing_check.rpt {check_timing}
  checkFootPrint

  # Add Endcap and Tap Cell
  if {($Fplan_AddEndcapTap == 1) || ($Innovus_DfmFlow != 0)} {
    if {$LIB_PROCESS_NODE > 3} {
      TIP_place_endcap_tap_cells
    }
  }
  
  #  Add Spare Cells and I/O Buffers
  if {$Innovus_DfmFlow != 0} {
    TIP_place_spare_cells
    setPlaceMode -place_opt_post_place_tcl ../scripts/innovus/Innovus_fixSpareCells.tcl
    TIP_add_io_buffers
    if {$LIB_PROCESS_NODE == 28 && [dbGet head.libCells.name FILL1BWP*] == 0x0} {
      setPlaceMode -place_detail_legalization_inst_gap 2
    }
  }

  # Add PG Keepout space for specific D1 cells at layer M1 in TSMC 5nm to avoid DRCs
  if {$LIB_PROCESS_NODE == 5} {
    foreach_in_collection lib_cells [get_lib_cells "AO*D1BWP* IAO*D1BWP* IOA*D1BWP* OA*D1BWP* OIA*D1BWP*" ] {
      foreach_in_collection pins [get_lib_pins -of_objects [get_lib_cells $lib_cells]] {
        set pin [lindex [split [get_object_name $pins] /] end]
        set cell [lindex [split [get_object_name $lib_cells] /] end]
        specify_pg_keepout -cell $cell -pin $pin -left 0.034 -right 0.034 -layer M1
      }
    }
  }    

  ##########################################################
  # Place Design
  ##########################################################
  # Add si prevention flow
  setBetaFeature siPreventionFlow true
  setDesignMode -siPrevention true
  setOptMode -preserveUserRouteTypeConstraints true

  if {[info exists env(INVS_PODV2)] != 0} {
    setOptMode -opt_enable_podv2_clock_opt_flow true
    setOptMode -opt_podv2_flow_effort extreme
  }

  if {$INSERT_SCAN == 1 && $Innovus_UseiSpatialDB == 0} {
    defIn -scanChain [format "%s%s" $FILE_NAME_PREFIX "_syn.scandef"]  
  }

  timeDesign -expandedViews -preplace -outDir summary_reports -prefix prePlace
  setDelayCalMode -ignoreNetLoad true
  set elapsed_mins [lindex [TIP_add_summary_point 1 $FILE_NAME_PREFIX prePlace $elapsed_mins] 0]
  setDelayCalMode -ignoreNetLoad false
  setOptMode -usefulSkewPreCTS true

  if {$USE_MULTIBIT_CELLS == 1} {
    Puts [format "%s%s" "**ERR" "OR: MultiBit Cell Interfacing uses a limited access feature."]
    Puts [format "%s%s" "**ERR" "OR: Contact Cadence Support for setLimitedAccessFeature key."]
    Puts [format "%s%s" "**ERR" "OR: Proceeding without the setLimitedAccessFeature key."]
    setLimitedAccessFeature FlipFlopMergeAndSplit 1
    setOptMode -multiBitFlopOpt true
    setOptMode -multiBitFlopOptIgnoreSDC false
  } 
  if {$Innovus_EarlyClockFlow == 1} {
     TIP_define_cts_specs
     setDesignMode -earlyClockFlow true
  }

  set macros [dbget [dbget -p2 top.insts.cell.baseClass block].hInst.name -u]
  if {$macros != 0x0} {
    if {$VER < 22.12} {
      setOptMode -preserveModuleFunction true
    } else {
      setOptMode -opt_preserve_hpin_function true
    }
    deselectAll
    foreach macro $macros {
      if {[sizeof_collection [get_cells $macro/* -filter "is_memory_cell==true" -quiet]] != 0} {
        selectModule $macro
        dbSet selected.dontTouchHports addOk
        deselectAll
      }
    }
  }

  if {($Innovus_MixedPlacer == 1)} {
    if {[sizeof_collection [get_cells -hierarchical * -filter "is_macro_cell==true"]] > [sizeof_collection [get_cells -hierarchical * -filter "is_memory_cell==true"]]} {
      Puts [format "%s%s" "**ERR" "OR: Mixed placer flow is currently not supported for designs having ETM or ILM blocks."]
      Puts [format "%s%s" "**ERR" "OR: Provide path to a DEF file to the Fplan_File variable. Rerun with Innovus_MixedPlacer set to 0 and Innovus_FP_USE set to 2."]
      exit
    } elseif {[sizeof_collection [get_cells -hierarchical * -filter "is_memory_cell==true"]] != 0} {
      setPlaceMode -place_global_align_macro true 
      place_design -concurrent_macros -no_refine_macro
      pack_align_macros 
      refine_macro_place
      reset_macro_place_constraint -horizontal_stacking -vertical_stacking
      check_macro_place_constraint 
      saveDesign myDB_local/macroPlace.enc
      
      ## re-set the macro halo to the original size after concurrent mixed placement
      addHaloToBlock -allBlock {1 1 1 1}
      refine_macro_place
      
      ## snap macro pins to track, colorize macro pin if no color
      setFPlanMode -snapBlockGrid LayerTrack
      
      ## change the macro status to fixed after refine_macro_place
      dbSet [dbget top.insts.cell.baseClass block -p2].pstatus fixed
      
      ### FLOORPLAN FINISHING
      ## add placement blockages to channel
      setFinishFPlanMode -activeObj {macro macroHalo hardBlkg softBlkg partialBlkg core iopad iocell fence} -direction xy
      ## add hard blockage into very small channels if any
      #finishFloorplan -fillPlaceBlockage hard [expr [lindex [get_macro_place_constraint -min_space_to_macro] 0] / 2.0]
      ## Optionally add following blockages in case of congestion:
      #finishFloorplan -fillPlaceBlockage soft 9.7 ; # value a little bit less than min_space_to_macro
      #finishFloorplan -fillPlaceBlockage partial 9.7 -density 30 ; # value a little bit less than min_space_to_macro
      finishFloorplan -fillPlaceBlockage partial 15 -density 60

      ## add physical instances
      #source add_physical_inst.tcl
      saveDesign myDB_local/macroPlace_noPowerMesh.dat
      ## reset the PG modeling constraint and do power routing
      reset_macro_place_constraint -cell_obs -pg_resource_model
      ## unplace standard cells temporary for power routing
      defOutBySection -compPlacement -noNets myDB_local/temp_placement.def
      ## Add power stripes
      unplaceAllInsts
      editDelete
      ## check the placement density if there are too many placement blockages added by finishFloorplan
      checkFPlan -reportUtil
      ## start power routing
      source $Innovus_PPlan_File
      setViaGenMode -optimize_cross_via true
      setViaGenMode -allow_wire_shape_change false
      setViaGenMode -extend_out_wire_end false
      verify_drc -check_only special -limit 0
      fixvia -minStep
      fixvia -minCut
      defOut -floorplan -noStdCells myDB_local/fplan_mixplacer_with_powerplan.def.gz

      set_message -id IMPDF-28 -severity warn
      defIn myDB_local/temp_placement.def
      set_message -id IMPDF-28 -severity error

      setPlaceMode -place_opt_run_global_place seed
      place_opt_design
      saveDesign myDB_local/place.enc
    } else {
      Puts [format "%s%s" "**WAR" "N: Innovus Mixed Placer flow is only applicable for designs with macros. The Innovus_MixedPlacer variable will have no effect on the flow."]
      if {$Innovus_UseiSpatialDB == 1} {
        place_opt_design -incr
      } else {
        place_opt_design
      }
    }
  } else {
    if {($Innovus_UseiSpatialDB == 1) && ($Innovus_FP_USE != 5)} {
      place_opt_design -incr
    } else {
      place_opt_design
    }
  }

  # Prevention for Innovus-only MBCI flow undefined row issue
  deleteRow -all
  initCoreRow

  saveDesign Innovus_Lib/preCtsOpt.enc
  timeDesign -expandedViews -preCTS -outDir summary_reports -prefix preCtsOpt
  set elapsed_mins [lindex [TIP_add_summary_point 0 $FILE_NAME_PREFIX preCtsOpt $elapsed_mins] 0]
  
  if {$LOW_POWER_FLOW != 0} {
    report_power -outfile preCtsOpt.dyn.power
  }
  checkPlace preCtsOpt.placement.check
  redirect preCtsOpt.floorplan.check {checkFPlan}
  TIP_user_report_area_ref preCtsOpt
  reportTranViolation -all -outfile preCtsOpt.tran.viol
  reportCapViolation -all -outfile preCtsOpt.cap.viol
}

set runCtsOptFlag 1
if {$runPlaceFlag == 0} {
  if {[file exists Innovus_Lib/postCtsOpt.enc.dat]} {
    set runCtsOptFlag 0
  } else {
    if {[file exists Innovus_Lib/preCtsOpt.enc.dat]} {
      source Innovus_Lib/preCtsOpt.enc
    }    
  }
}

if {$runCtsOptFlag == 1} {
    # Addition of Tie Cells and Decaps
    TIP_place_tie_cells
    if {$Innovus_DfmFlow == 2} {
      TIP_place_decap_cells
    }

    #####################################################
    # Specify clock tree settings
    #####################################################

    if {$Innovus_EarlyClockFlow == 0} {
       TIP_define_cts_specs
    }

    #####################################################
    # perform CTS
    #####################################################
    TIP_set_uncertainties $Innovus_CTSUncertainty
    TIP_dont_merge_icg

    if {$VER >= 15.10} {
      if {$Innovus_CcoptUsefulSkewEnabled==1} {
        set ctsStep "ccOpt"
        set_ccopt_effort -high
        if {[info exists env(INVS_PODV2)] != 0} {
          clock_opt_design 
        } else {
          ccopt_design
        }
      } else {
        set ctsStep "ctsOnly"
        ccopt_design -cts
      }
    } else {
      if {$Innovus_CcoptUsefulSkewEnabled==1} {
        set ctsStep "ccOpt"
        ccopt_design
      } else {
        set ctsStep "ctsOnly"
        ccopt_design -cts
      }
    }
    optDesign -postCTS -outDir reports

    timeDesign -expandedViews -postCTS -outDir summary_reports -prefix postCtsOpt
    set elapsed_mins [lindex [TIP_add_summary_point 0 $FILE_NAME_PREFIX postCtsOpt $elapsed_mins] 0]
    saveDesign Innovus_Lib/postCtsOpt.enc
    if {$LOW_POWER_FLOW != 0} {
      report_power -outfile postCtsOpt.dyn.power
    }
    checkPlace postCtsOpt.placement.check
    redirect postCtsOpt.floorplan.check {checkFPlan}
    TIP_user_report_area_ref postCtsOpt
    TIP_report_clock_stats postCtsOpt
    reportTranViolation -all -outfile postCtsOpt.tran.viol
    reportCapViolation -all -outfile postCtsOpt.cap.viol
}

set runCtsHoldFlag 1
if {$runCtsOptFlag == 0} {
  if {[file exists Innovus_Lib/postCtsHold.enc.dat]} {
    set runCtsHoldFlag 0
  } else {
    source Innovus_Lib/postCtsOpt.enc
  }
}

if {$runCtsHoldFlag == 1} {
  optDesign -postCTS -hold -outDir reports

  saveDesign Innovus_Lib/postCtsHold.enc
  
  timeDesign -expandedViews -postCTS -outDir summary_reports -prefix postCtsHold
  set elapsed_mins [lindex [TIP_add_summary_point 0 $FILE_NAME_PREFIX postCtsHold $elapsed_mins] 0]
  if {$LOW_POWER_FLOW != 0} {
    report_power -outfile postCtsHold.dyn.power
  }
  checkPlace postCtsHold.placement.check
  redirect postCtsHold.floorplan.check {checkFPlan}
  TIP_user_report_area_ref postCtsHold
  TIP_report_clock_stats postCtsHold
  reportTranViolation -all -outfile postCtsHold.tran.viol
  reportCapViolation -all -outfile postCtsHold.cap.viol
}

######################################################
# Route design                                       #
######################################################
setAnalysisMode -analysisType onChipVariation -cppr both
setExtractRCMode -engine postRoute
setDelayCalMode -siAware true -engine aae
setSIMode -accumulated_small_attacker_threshold 0.05 -enable_logical_correlation true -individual_attacker_threshold 0.0125  -separate_delta_delay_on_data true -si_reselection all -accumulated_small_attacker_sigma 2

if {$Innovus_WFP == 1} {
  setDelayCalMode -equivalent_waveform_model propagation -ewm_type simulation -enable_quiet_receivers_for_hold true
}
if {$LIB_PROCESS_NODE == 5} {
  setNanoRouteMode -drouteExpConcurrentMinimizeViaCountCost 64
}

set runRouteFlag 1
if {$runCtsHoldFlag == 0} {
  if {[file exists Innovus_Lib/postRoute.enc.dat]} {
    set runRouteFlag 0
  } else {
    source Innovus_Lib/postCtsHold.enc
  }
}

if {$runRouteFlag == 1} {
    TIP_set_uncertainties $Innovus_PostRouteUncertainty
    if {[info exists env(INVS_ROD)] != 0} {
      route_opt_design
    } else {
      routeDesign
      if {$Innovus_ViaPillarFlow==1} {
      	setNanoRouteMode -droutePostRouteViaPillarEffort high 
      	routeDesign -viaPillarOpt
      }
    }
    saveDesign Innovus_Lib/postRoute.enc
}

set runRouteOptFlag 1
if {$runRouteFlag == 0} {
  if {[file exists Innovus_Lib/postRouteOpt.enc.dat]} {
    set runRouteOptFlag 0
  } else {
    source Innovus_Lib/postRoute.enc
  }
}

if {$Innovus_ViaPillarFlow==1} {
  setOptMode -viaPillarEffort medium
}

if {$runRouteOptFlag == 1} {
  if {[info exists env(INVS_ROD)] != 1} {
    optDesign -postRoute -outDir reports
  }
  timeDesign -expandedViews -postRoute -outDir summary_reports -prefix postRouteOpt
  set elapsed_mins [lindex [TIP_add_summary_point 0 $FILE_NAME_PREFIX postRouteOpt $elapsed_mins] 0]
  saveDesign Innovus_Lib/postRouteOpt.enc
  if {$LOW_POWER_FLOW != 0} {
    report_power -outfile postRouteOpt.dyn.power
  }
  checkPlace postRouteOpt.placement.check
  redirect postRouteOpt.floorplan.check {checkFPlan}
  redirect postRouteOpt.route.check {checkRoute}
  TIP_user_report_area_ref postRouteOpt
  TIP_report_clock_stats postRouteOpt
  reportTranViolation -all -outfile postRouteOpt.tran.viol
  reportCapViolation -all -outfile postRouteOpt.cap.viol
}

######################################################
# Hold Fixing
######################################################
set runRouteHoldFlag 1
if {$runRouteOptFlag == 0} {
  if {[file exists Innovus_Lib/postRouteHold.enc.dat]} {
    set runRouteHoldFlag 0
  } else {
    source Innovus_Lib/postRouteOpt.enc
  }
}

if {$runRouteHoldFlag == 1} {
  TIP_remove_unconnected_nets    
  redirect [format "%s%s" $FILE_NAME_PREFIX ".drc"] {verify_drc -check_only regular}
  optDesign -postRoute -hold -outDir reports
  redirect [format "%s%s" $FILE_NAME_PREFIX ".drc"] {verify_drc -check_only regular}
  if {[dbGet top.markers.subType -p  Floating_Patch] !=0x0 } {
    TIP_fix_drc_viol "Floating_Patch"
  }
  redirect [format "%s%s" $FILE_NAME_PREFIX ".drc"] {verify_drc -check_only regular}
  if {[dbGet top.markers.subType -p  Metal_Corner_Spacing] !=0x0} {
    TIP_fix_drc_viol "Metal_Corner_Spacing"
  }
  timeDesign -expandedViews -postRoute -outDir summary_reports -prefix postRouteHold
  set elapsed_mins [lindex [TIP_add_summary_point 0 $FILE_NAME_PREFIX postRouteHold $elapsed_mins] 0]
  saveDesign Innovus_Lib/postRouteHold.enc
  if {$LOW_POWER_FLOW != 0} {
    report_power -outfile postRouteHold.dyn.power
  }
  checkPlace postRouteHold.placement.check
  redirect postRouteHold.floorplan.check {checkFPlan}
  redirect postRouteHold.route.check {checkRoute}
  TIP_user_report_area_ref postRouteHold
  TIP_report_clock_stats postRouteHold
  reportTranViolation -all -outfile postRouteHold.tran.viol
  reportCapViolation -all -outfile postRouteHold.cap.viol
}

set runFinalReportFlag 1
set runRouteAssembleFlag 1
if {$runRouteHoldFlag == 0} {
  if {[file exists postRouteAssemble.enc.dat]} {
    set runRouteAssembleFlag 0
  } elseif {[file exists final.enc.dat]} {
    set runFinalReportFlag 0
  } else {
    source Innovus_Lib/postRouteHold.enc
  }
}

if {$Fplan_AddFlipChipBump == 1} {
  deletePGPin -all
  TIP_place_flipchip_bumps
}
if {$Innovus_DfmFlow != 0} {
  # Perform EM Check and Fix the violations, add Filler cells, Metal Fill and run VerifyAntenna and Power Via check
  # TIP_em_check
  TIP_place_filler_cells
  TIP_add_metal_fill
  verifyProcessAntenna -report ProcessAntennaViolation.report
  verifyPowerVia -stackedVia

  # Add Info to summary file
  timeDesign -expandedViews -postRoute -outDir summary_reports -prefix postRouteDFM
  set elapsed_mins [lindex [TIP_add_summary_point 0 $FILE_NAME_PREFIX postRouteDFM $elapsed_mins] 0]
  saveDesign Innovus_Lib/postRouteDFM.enc
}

if {$runFinalReportFlag == 1} {
  ######################################################
  # Final report generation
  ######################################################
  saveDesign -timingGraph -tcon final.enc
  source ../scripts/innovus/Innovus_export.cmd

  ##  Report the Area occupied by the Cells added for DFM  ##
  if {($Innovus_DfmFlow != 0) || ($Fplan_AddEndcapTap == 1)} {
    TIP_report_DFM_Flow_cell_usage
  }
}

report_resource -end fullFlow -verbose
exit
