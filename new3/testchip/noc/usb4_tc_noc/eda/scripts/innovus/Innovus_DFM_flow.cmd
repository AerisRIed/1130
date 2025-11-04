#############################################################################################
#        Copyright (c) 2009-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

###############################################################################################################
####################### Procedures to Run All DFM features #################################
###############################################################################################################

#########################################################################################################
################### Procedure to get the Cell Name Postfixes ##################
#########################################################################################################


proc TIP_get_cellname_postfix {} {
    
    source Innovus_define.cmd
    
# Verify the setup for the DFM flow. Exit if the correct settings are not available
    TIP_verify_dfm_setup
    
    set reference_cell [lindex $Lib_FillerCells 0]
    
    if { $reference_cell eq "" } {
        Puts [concat "**ERR" "OR: DFM_ERROR: No cells available in the Lib_FillerCells variable for identifying postfix"]
	Puts [concat "**ERR" "OR: DFM_ERROR: No DFM features will be added"]
	exit
    } else {
        if { [regexp {FILL\d+} $reference_cell] == 1 } {
	    set postfix [regsub -all {FILL\d*} $reference_cell ""]
	    Puts "DFM: Identified Cell name Postfix - $postfix"
	    return $postfix
	} else {
	    Puts [concat "**ERR" "OR: DFM_ERROR: Expected Filler cell naming pattern is FILL<number><postfix>"]
	    Puts [concat "**ERR" "OR: DFM_ERROR: Example: FILL64BWP7T30P140"]
	    Puts [concat "**ERR" "OR: DFM_ERROR: Unable to identify VT and Cellname Postfix from the Lib_FillerCells variable. Cannot execute DFM flow"]
	    exit
	}
    }
}

proc TIP_get_cellname_vt {} {
    
    source Innovus_define.cmd
  
    set reference_cell [lindex $Lib_FillerCells 0]
    
    if { $reference_cell eq "" } {
        Puts [concat "**ERR" "OR: DFM_ERROR: No cells available in the Lib_FillerCells variable for identifying postfix"]
	Puts [concat "**ERR" "OR: DFM_ERROR: No DFM features will be added"]
	exit
    } else {
        if { [regexp {FILL\d+} $reference_cell] == 1 } {
	    set postfix [regsub -all {FILL.*CPD} $reference_cell ""]
	    Puts "DFM: cell VT is - $postfix"
	    return $postfix
	} else {
	    Puts [concat "**ERR" "OR: DFM_ERROR: Expected Filler cell naming pattern is FILL<number><postfix>"]
	    Puts [concat "**ERR" "OR: DFM_ERROR: Example: FILL64BWP7T30P140"]
	    Puts [concat "**ERR" "OR: DFM_ERROR: Unable to identify VT and Cellname Postfix from the Lib_FillerCells variable. Cannot execute DFM flow"]
	    exit
	}
    }
}


#########################################################################################################
################### Procedure to verify the Innovus Setup for running the DFM flow ######################
#########################################################################################################


proc TIP_verify_dfm_setup {} {
    
    source Innovus_define.cmd
    
    Puts "Verifying the DFM flow variables to ensure that all required variables are set"
    
    # Check if all the Decap related variables are set correctly
    if { $Innovus_DfmFlow eq "2" } {
        if {[regexp {_none_} $Innovus_DecapCells]==1} {
            Puts [concat "**ERR" "OR: DFM_ERROR: No Decap cells mentioned in the Innovus_DecapCells variable in the CadSetup.file"]
	    Puts [concat "**ERR" "OR: DFM_ERROR: Decap Cells cannot be added. Exiting the flow"]
	    exit
        }
	
	if { $Innovus_DecapPerUnitArea eq "0" } {
            Puts [concat "**ERR" "OR: DFM_ERROR: Decap Per unit area set to zero. Pleas enter a non-zero value for the Capacitance value"]
	    Puts [concat "**ERR" "OR: DFM_ERROR: Decap Cells cannot be added. Exiting the flow"]
	    exit
        }
    }
}


#######################################################################################################################
############### Procedure to place EndCap Cells and Tap Cells according to recommended guidelines #####################
#######################################################################################################################

proc TIP_place_endcap_tap_cells {} {

    source Innovus_define.cmd

    #set cell_name [dbGet [dbGet -p head.libCells.name CKBD4BWP*].name]
    #set cell_name [string range [lindex $cell_name 0] 5 [string length [lindex $cell_name 0]]]
    
    
    set cell_name [TIP_get_cellname_postfix]
    if { $cell_name eq "" } {
        Puts [concat "**ERR" "OR: DFM_ERROR: Invalid cell name postfix. Could not identify cell names. EndCap and Well Tap cells will not be placed"]
	return
    }
    
    deleteFiller -prefix ENDCAP
    deleteFiller -prefix WELLTAP
    setEndCapMode -reset


    if {$LIB_PROCESS_NODE == 28} {
        setEndCapMode -fitGap true -prefix BOUNDARY_CAP
        setEndCapMode -rightEdge "BOUNDARY_LEFT${cell_name}" -leftEdge "BOUNDARY_RIGHT${cell_name}"
	addEndCap -prefix ENDCAP
        addWellTap -cell "TAPCELL${cell_name}" -prefix WELLTAP -cellInterval 60 -inRowOffset 0 -checkerBoard
    } elseif {$LIB_PROCESS_NODE == 16} {
        setEndCapMode -fitGap true -prefix BOUNDARY_CAP -boundary_tap true
        set_well_tap_mode -rule 22 -bottom_tap_cell "BOUNDARY_NTAP${cell_name}" -top_tap_cell "BOUNDARY_PTAP${cell_name}" -cell "TAPCELL${cell_name}"
        setEndCapMode -rightEdge "BOUNDARY_LEFT${cell_name}" -leftEdge "BOUNDARY_RIGHT${cell_name}" -leftBottomCorner "BOUNDARY_NCORNER${cell_name}" -leftTopCorner "BOUNDARY_PCORNER${cell_name}" -rightTopEdge "FILL3${cell_name}" -rightBottomEdge "FILL3${cell_name}" -leftTopEdge "FILL3${cell_name}" -leftBottomEdge "FILL3${cell_name}" -bottomEdge "BOUNDARY_NROW2${cell_name} BOUNDARY_NROW3${cell_name}" -topEdge "BOUNDARY_PROW2${cell_name} BOUNDARY_PROW3${cell_name}"
	addEndCap -prefix ENDCAP
        addWellTap -cell "TAPCELL${cell_name}" -prefix WELLTAP -cellInterval 100 -inRowOffset 0 -checkerBoard
    } elseif {$LIB_PROCESS_NODE == 7} { 
        setEndCapMode -fitGap true -prefix BOUNDARY_CAP
        setEndCapMode -rightEdge "BOUNDARYLEFTCW${cell_name}" -leftEdge "BOUNDARYRIGHTCW${cell_name}" -leftBottomCorner "BOUNDARYNCORNER${cell_name}" -leftTopCorner "BOUNDARYPCORNER${cell_name}" -rightTopEdge "FILL3${cell_name}" -rightBottomEdge "FILL3${cell_name}" -leftTopEdge "FILL3${cell_name}" -leftBottomEdge "FILL3${cell_name}" -bottomEdge "BOUNDARYNROW2${cell_name} BOUNDARYNROW4${cell_name}" -topEdge "BOUNDARYPROW2${cell_name} BOUNDARYPROW4${cell_name}"
        addEndCap -prefix ENDCAP
        addWellTap -cell "TAPCELL${cell_name}" -prefix WELLTAP -cellInterval 100 -inRowOffset 0 -checkerBoard
    } elseif {$LIB_PROCESS_NODE == 5} {
        deleteFiller -prefix ENDCAP
        setEndCapMode -rightEdge "BOUNDARYLEFTCW${cell_name}" -leftEdge "BOUNDARYRIGHTCW${cell_name}" -leftBottomCorner "BOUNDARYPCORNERCW${cell_name}" -leftTopCorner "BOUNDARYPCORNERCW${cell_name}" -bottomEdge "BOUNDARYPROW8${cell_name} BOUNDARYPROW4${cell_name} BOUNDARYPROW2${cell_name} BOUNDARYPROW1${cell_name}" -topEdge "BOUNDARYPROW8${cell_name} BOUNDARYPROW4${cell_name} BOUNDARYPROW2${cell_name} BOUNDARYPROW1${cell_name}" -rightTopEdge "BOUNDARYPINCORNERCW${cell_name}" -rightBottomEdge "BOUNDARYPINCORNERCW${cell_name}" -rightTopEdgeNeighbor "BOUNDARYPROWRGAPCW${cell_name}" -rightBottomEdgeNeighbor "BOUNDARYPROWRGAPCW${cell_name}" -leftTopEdgeNeighbor "BOUNDARYPROWLGAPCW${cell_name}" -leftBottomEdgeNeighbor "BOUNDARYPROWLGAPCW${cell_name}"
        addEndCap -prefix ENDCAP
        verifyEndCap -report endcap.rpt
        deleteFiller -prefix WELLTAP
        setDesignMode -process 5 -node $LIB_TECH_NODE
        if ([regexp {210H} $cell_name]==1) {
          set addTapCellCmd "set_well_tap_mode -insert_cells { {TAPCELLFIN6${cell_name} rule 15.8 boundary_layer LUP_SRM boundary_rule 15.8} {TAPCELL${cell_name} rule 22.5} }"
	  eval $addTapCellCmd
          addWellTap -prefix WELLTAP -checkerBoard
        } else {
          set addTapCellCmd "set_well_tap_mode -insert_cells { {TAPCELLFIN9${cell_name} rule 15.8 boundary_layer LUP_SRM boundary_rule 15.8} {TAPCELL${cell_name} rule 22.5} }"
          eval $addTapCellCmd
          addWellTap -prefix WELLTAP -checkerBoard
        }
        verifyWellTap -report welltap.rpt
    } elseif  {$LIB_PROCESS_NODE == 3} {
      if {[regexp BWP169.*P48 $cell_name]} {
      setDesignMode -flowEffort standard -process 3 -node N3E
      
      set cell_vt [TIP_get_cellname_vt]
      
      set BOUNDARY_NROW                       "BOUNDARYNROW8SHBWP169H3P48CPD${cell_vt} BOUNDARYNROW4SHBWP169H3P48CPD${cell_vt} BOUNDARYNROW2SHBWP169H3P48CPD${cell_vt} BOUNDARYNROW1SHBWP169H3P48CPD${cell_vt} BOUNDARYNROWNWTAPWALLSHBWP169H3P48CPD${cell_vt} BOUNDARYNROWNWTAPSHBWP169H3P48CPD${cell_vt} BOUNDARYNROWWALLSHBWP169H3P48CPD${cell_vt}"
      set BOUNDARY_PROW                       "BOUNDARYPROW8SHBWP169H3P48CPD${cell_vt} BOUNDARYPROW4SHBWP169H3P48CPD${cell_vt} BOUNDARYPROW2SHBWP169H3P48CPD${cell_vt} BOUNDARYPROW1SHBWP169H3P48CPD${cell_vt} BOUNDARYPROWPWTAPWALLSHBWP169H3P48CPD${cell_vt} BOUNDARYPROWPWTAPSHBWP169H3P48CPD${cell_vt} BOUNDARYPROWWALLSHBWP169H3P48CPD${cell_vt}"
      set BOUNDARY_LEFT                       "BOUNDARYLEFTSHBWP169H3P48CPD${cell_vt} BOUNDARYLEFTPWTAPSHBWP169H3P48CPD${cell_vt} BOUNDARYLEFTNWTAPSHBWP169H3P48CPD${cell_vt}"
      set BOUNDARY_RIGHT                      "BOUNDARYRIGHTSHBWP169H3P48CPD${cell_vt} BOUNDARYRIGHTPWTAPSHBWP169H3P48CPD${cell_vt} BOUNDARYRIGHTNWTAPSHBWP169H3P48CPD${cell_vt}"
      set BOUNDARY_NCORNER                    "BOUNDARYNCORNERSHBWP169H3P48CPD${cell_vt} BOUNDARYNCORNERNWTAPSHBWP169H3P48CPD${cell_vt}"
      set BOUNDARY_PCORNER                    "BOUNDARYPCORNERSHBWP169H3P48CPD${cell_vt} BOUNDARYPCORNERPWTAPSHBWP169H3P48CPD${cell_vt}"
      set BOUNDARY_NINCORNER                  "BOUNDARYNINCORNERSHBWP169H3P48CPD${cell_vt} BOUNDARYNINCORNERNWTAPSHBWP169H3P48CPD${cell_vt} BOUNDARYNINCORNERPWTAPSHBWP169H3P48CPD${cell_vt}"
      set BOUNDARY_PINCORNER                  "BOUNDARYPINCORNERSHBWP169H3P48CPD${cell_vt} BOUNDARYPINCORNERNWTAPSHBWP169H3P48CPD${cell_vt} BOUNDARYPINCORNERPWTAPSHBWP169H3P48CPD${cell_vt}"
      set WELL_TAP_CELL "TAPCELLNWBWP169H3P48CPD${cell_vt} TAPCELLNWWALLBWP169H3P48CPD${cell_vt} TAPCELLPWBWP169H3P48CPD${cell_vt} TAPCELLPWWALLBWP169H3P48CPD${cell_vt} FILLWALLBWP169H3P48CPD${cell_vt} FILLCPWWALLBWP169H3P48CPD${cell_vt} FILLWALLATBWP169H3P48CPD${cell_vt} FILLCPWWALLATBWP169H3P48CPD${cell_vt} FILLWALLSHBWP169H3P48CPD${cell_vt} FILLWALLATSHBWP169H3P48CPD${cell_vt}"
      
      
      setEndCapMode \
           -rightEdge        $BOUNDARY_LEFT \
           -leftEdge         $BOUNDARY_RIGHT \
           -leftTopCorner    $BOUNDARY_PCORNER \
           -leftBottomCorner $BOUNDARY_NCORNER \
           -topEdge          $BOUNDARY_PROW \
           -bottomEdge       $BOUNDARY_NROW \
           -leftTopEdge      $BOUNDARY_PINCORNER \
           -leftBottomEdge   $BOUNDARY_NINCORNER \
           -boundary_tap     true \
           -boundary_tap_swap_flow true
       
      set_well_tap_mode -insert_cells $WELL_TAP_CELL
      
      setEndCapMode -wall_pitch 95.76
      setEndCapMode -wall_to_incorner_spacing 0.768
      #tlef and library already enable tap-rule and delta-D to calculate TAP distance
      set_well_tap_mode -disable_check_zone_at_boundary vdd
      ## Check FPlan##
      checkFPlan
      addEndCap
      addWellTap -checkerBoard
      } elseif {[regexp BWP169.*P54 $cell_name]} {
      setDesignMode -flowEffort standard -process 3 -node N3E
      
      set cell_vt [TIP_get_cellname_vt]
      set BOUNDARY_NROW                       "BOUNDARYNROW8SHBWP169H3P54CPDLVT BOUNDARYNROW4SHBWP169H3P54CPDLVT BOUNDARYNROW2SHBWP169H3P54CPDLVT BOUNDARYNROW1SHBWP169H3P54CPDLVT BOUNDARYNROWNWTAPWALLSHBWP169H3P54CPDLVT BOUNDARYNROWNWTAPSHBWP169H3P54CPDLVT BOUNDARYNROWWALLSHBWP169H3P54CPDLVT"
      set BOUNDARY_PROW                       "BOUNDARYPROW8SHBWP169H3P54CPDLVT BOUNDARYPROW4SHBWP169H3P54CPDLVT BOUNDARYPROW2SHBWP169H3P54CPDLVT BOUNDARYPROW1SHBWP169H3P54CPDLVT BOUNDARYPROWPWTAPWALLSHBWP169H3P54CPDLVT BOUNDARYPROWPWTAPSHBWP169H3P54CPDLVT BOUNDARYPROWWALLSHBWP169H3P54CPDLVT"
      set BOUNDARY_LEFT                       "BOUNDARYLEFTSHBWP169H3P54CPDLVT BOUNDARYLEFTPWTAPSHBWP169H3P54CPDLVT BOUNDARYLEFTNWTAPSHBWP169H3P54CPDLVT"
      set BOUNDARY_RIGHT                      "BOUNDARYRIGHTSHBWP169H3P54CPDLVT BOUNDARYRIGHTPWTAPSHBWP169H3P54CPDLVT BOUNDARYRIGHTNWTAPSHBWP169H3P54CPDLVT"
      set BOUNDARY_NCORNER                    "BOUNDARYNCORNERSHBWP169H3P54CPDLVT BOUNDARYNCORNERNWTAPSHBWP169H3P54CPDLVT"
      set BOUNDARY_PCORNER                    "BOUNDARYPCORNERSHBWP169H3P54CPDLVT BOUNDARYPCORNERPWTAPSHBWP169H3P54CPDLVT"
      set BOUNDARY_NINCORNER                  "BOUNDARYNINCORNERSHBWP169H3P54CPDLVT BOUNDARYNINCORNERNWTAPSHBWP169H3P54CPDLVT BOUNDARYNINCORNERPWTAPSHBWP169H3P54CPDLVT"
      set BOUNDARY_PINCORNER                  "BOUNDARYPINCORNERSHBWP169H3P54CPDLVT BOUNDARYPINCORNERNWTAPSHBWP169H3P54CPDLVT BOUNDARYPINCORNERPWTAPSHBWP169H3P54CPDLVT"
      set WELL_TAP_CELL			{{TAPCELLNWBWP169H3P54CPDLVT} {TAPCELLNWWALLBWP169H3P54CPDLVT} {TAPCELLPWBWP169H3P54CPDLVT} {TAPCELLPWWALLBWP169H3P54CPDLVT} {FILLWALLBWP169H3P54CPDLVT} {FILLCPWWALLBWP169H3P54CPDLVT} {FILLWALLATBWP169H3P54CPDLVT} {FILLCPWWALLATBWP169H3P54CPDLVT} {FILLWALLSHBWP169H3P54CPDLVT} {FILLWALLATSHBWP169H3P54CPDLVT}}

      setEndCapMode \
           -rightEdge        $BOUNDARY_LEFT \
           -leftEdge         $BOUNDARY_RIGHT \
           -leftTopCorner    $BOUNDARY_PCORNER \
           -leftBottomCorner $BOUNDARY_NCORNER \
           -topEdge          $BOUNDARY_PROW \
           -bottomEdge       $BOUNDARY_NROW \
           -leftTopEdge      $BOUNDARY_PINCORNER \
           -leftBottomEdge   $BOUNDARY_NINCORNER \
           -boundary_tap     true \
           -boundary_tap_swap_flow true
       
      set_well_tap_mode -insert_cells $WELL_TAP_CELL

      setEndCapMode -wall_pitch 95.904
      setEndCapMode -wall_to_convex_corner_spacing 0.864
      #tlef and library already enable tap-rule and delta-D to calculate TAP distance
      set_well_tap_mode -disable_check_zone_at_boundary vdd
      ## Check FPlan##
      checkFPlan
      addEndCap
      addWellTap -checkerBoard
      } elseif {[regexp BWP143 $cell_name]} {
      setDesignMode -flowEffort standard -process 3 -node N3E
      
      set cell_vt [TIP_get_cellname_vt]
      set BOUNDARY_NROW                       "BOUNDARYNROWWALLBWP143M117H3P48CPD${cell_vt} BOUNDARYNROW8BWP143M117H3P48CPD${cell_vt} BOUNDARYNROW4BWP143M117H3P48CPD${cell_vt} BOUNDARYNROW2BWP143M117H3P48CPD${cell_vt} BOUNDARYNROW1BWP143M117H3P48CPD${cell_vt} BOUNDARYNROWNWTAPBWP143M286H3P48CPD${cell_vt} BOUNDARYNROWNWTAPWALLBWP143M286H3P48CPD${cell_vt}"
      set BOUNDARY_PROW                       "BOUNDARYPROWWALLBWP143M117H3P48CPD${cell_vt} BOUNDARYPROW8BWP143M117H3P48CPD${cell_vt} BOUNDARYPROW4BWP143M117H3P48CPD${cell_vt} BOUNDARYPROW2BWP143M117H3P48CPD${cell_vt} BOUNDARYPROW1BWP143M117H3P48CPD${cell_vt} BOUNDARYPROWPWTAPBWP143M286H3P48CPD${cell_vt} BOUNDARYPROWPWTAPWALLBWP143M286H3P48CPD${cell_vt}"
      set BOUNDARY_LEFT                       "BOUNDARYLEFTBWP143M117H3P48CPD${cell_vt} BOUNDARYLEFTBWP143M169H3P48CPD${cell_vt} BOUNDARYLEFTPWTAPBWP143M286H3P48CPD${cell_vt} BOUNDARYLEFTNWTAPBWP143M286H3P48CPD${cell_vt}"
      set BOUNDARY_RIGHT                      "BOUNDARYRIGHTBWP143M117H3P48CPD${cell_vt} BOUNDARYRIGHTBWP143M169H3P48CPD${cell_vt} BOUNDARYRIGHTPWTAPBWP143M286H3P48CPD${cell_vt} BOUNDARYRIGHTNWTAPBWP143M286H3P48CPD${cell_vt}"
      set BOUNDARY_NCORNER                    "BOUNDARYNCORNERBWP143M117H3P48CPD${cell_vt} BOUNDARYNCORNERNWTAPBWP143M286H3P48CPD${cell_vt}"
      set BOUNDARY_PCORNER                    "BOUNDARYPCORNERBWP143M117H3P48CPD${cell_vt} BOUNDARYPCORNERPWTAPBWP143M286H3P48CPD${cell_vt}"
      set BOUNDARY_NINCORNER                  "BOUNDARYNINCORNERBWP143M286H3P48CPD${cell_vt} BOUNDARYNINCORNERNWTAPBWP143M403H3P48CPD${cell_vt} BOUNDARYNINCORNERPWTAPBWP143M286H3P48CPD${cell_vt}"
      set BOUNDARY_PINCORNER                  "BOUNDARYPINCORNERBWP143M286H3P48CPD${cell_vt} BOUNDARYPINCORNERPWTAPBWP143M403H3P48CPD${cell_vt} BOUNDARYPINCORNERNWTAPBWP143M286H3P48CPD${cell_vt}"
      set WELL_TAP_CELL		     	"TAPCELLNWBWP143M286H3P48CPD${cell_vt} TAPCELLNWWALLBWP143M286H3P48CPD${cell_vt} TAPCELLPWBWP143M286H3P48CPD${cell_vt} TAPCELLPWWALLBWP143M286H3P48CPD${cell_vt} FILLWALLBWP143M286H3P48CPD${cell_vt} FILLCPWWALLBWP143M286H3P48CPD${cell_vt} FILLWALLATBWP143M286H3P48CPD${cell_vt} FILLCPWWALLATBWP143M286H3P48CPD${cell_vt} FILLWALLSHBWP143M117H3P48CPD${cell_vt} FILLWALLSHBWP143M169H3P48CPD${cell_vt} FILLWALLATSHBWP143M117H3P48CPD${cell_vt} FILLWALLATSHBWP143M169H3P48CPD${cell_vt}"
      setEndCapMode \
           -rightEdge        $BOUNDARY_LEFT \
           -leftEdge         $BOUNDARY_RIGHT \
           -leftTopCorner    $BOUNDARY_PCORNER \
           -leftBottomCorner $BOUNDARY_NCORNER \
           -topEdge          $BOUNDARY_PROW \
           -bottomEdge       $BOUNDARY_NROW \
           -leftTopEdge      $BOUNDARY_PINCORNER \
           -leftBottomEdge   $BOUNDARY_NINCORNER \
           -boundary_tap     true \
           -boundary_tap_swap_flow true
       
       set_well_tap_mode -insert_cells $WELL_TAP_CELL
       
       setEndCapMode -wall_pitch 95.76
       setEndCapMode -wall_to_incorner_spacing 0.768
       set_well_tap_mode -disable_check_zone_at_boundary vdd
       ## Check FPlan##
       checkFPlan
       addEndCap
       addWellTap -checkerBoard

      } else {
      Puts [concat "**ERR" "OR: DFM_ERROR: 3nm Design only support H169 and H143 cells "]
      exit
      }
    } else {
        Puts [concat "**ERR" "OR: DFM_ERROR: Technology node not supported for adding Endcap or Tap Cell"]
        exit
    }
}

#########################################################################################################
################ Procedure to place Tie Cells according to recommended guidelines #######################
#########################################################################################################

proc TIP_place_tie_cells {} {

    set tieHiCell [dbGet [dbGet -p head.libCells.name TIEH*].name]
    set tieHiCell [lindex $tieHiCell 0]
    set tieLoCell [dbGet [dbGet -p head.libCells.name TIEL*].name]
    set tieLoCell [lindex $tieLoCell 0]
    
    if { ($tieHiCell eq "") || ($tieLoCell eq "") } {
        Puts [concat "**ERR" "OR: DFM_ERROR: No matching Tie Cells available. Tie Cells will not be placed"]
	return
    }
    
    set pdNames [dbGet top.fplan.groups.pd]
    setTieHiLoMode -cell "$tieHiCell $tieLoCell" -maxDistance 50 -maxFanout 10 -prefix "TIECELL"
    addTieHiLo -createHierPort true

}

#########################################################################################################
################ Procedure to place Spare Cells according to recommended guidelines #####################
#########################################################################################################

proc TIP_place_spare_cells {} {

    source Innovus_define.cmd
    set spare_cell_percentage 0.01
    set number_of_modules 10

    set flopQuantity 10
    set clk_len [llength $CLK_PORT]
    set flopQuantity [expr {$flopQuantity / $clk_len}]
    set flopQuantity [expr {int($flopQuantity)}]

    set cell_name [TIP_get_cellname_postfix]
    if { $cell_name eq "" } {
        Puts [concat "**ERR" "OR: DFM_ERROR: Invalid Cell name Postfix. Cannot identify cell names. Spare cells will not be placed"]
	return
    }
    
    set list [dbGet [dbGet -p top.insts.cell.name INVD*].name]
    set temp [llength $list]
    set inv1Quantity [expr {$spare_cell_percentage * $temp}]
    set inv1Quantity [expr {$inv1Quantity / 2}]
    set inv1Quantity [expr {$inv1Quantity / $number_of_modules}]
    set inv1Quantity [expr {$inv1Quantity / $clk_len}]
    set inv1Quantity [expr {int($inv1Quantity)}]

    set list [dbGet [dbGet -p top.insts.cell.name INVD*].name]
    set temp [llength $list]
    set inv2Quantity [expr {$spare_cell_percentage * $temp}]
    set inv2Quantity [expr {$inv2Quantity / 2}]
    set inv2Quantity [expr {$inv2Quantity / $number_of_modules}]
    set inv2Quantity [expr {$inv2Quantity / $clk_len}]
    set inv2Quantity [expr {int($inv2Quantity)}]

    set list [dbGet [dbGet -p top.insts.cell.name BUFFD*].name]
    set temp [llength $list]
    set buff1Quantity [expr {$spare_cell_percentage * $temp}]
    set buff1Quantity [expr {$buff1Quantity / 2}]
    set buff1Quantity [expr {$buff1Quantity / $number_of_modules}]
    set buff1Quantity [expr {$buff1Quantity / $clk_len}]
    set buff1Quantity [expr {int($buff1Quantity)}]

    set list [dbGet [dbGet -p top.insts.cell.name BUFFD*].name]
    set temp [llength $list]
    set buff2Quantity [expr {$spare_cell_percentage * $temp}]
    set buff2Quantity [expr {$buff2Quantity / 2}]
    set buff2Quantity [expr {$buff2Quantity / $number_of_modules}]
    set buff2Quantity [expr {$buff2Quantity / $clk_len}]
    set buff2Quantity [expr {int($buff2Quantity)}]

    set list [dbGet [dbGet -p top.insts.cell.name ND2D*].name]
    set temp [llength $list]
    set nd2d2Quantity [expr {$spare_cell_percentage * $temp}]
    set nd2d2Quantity [expr {$nd2d2Quantity / $number_of_modules}]
    set nd2d2Quantity [expr {$nd2d2Quantity / $clk_len}]
    set nd2d2Quantity [expr {int($nd2d2Quantity)}]

    set list [dbGet [dbGet -p top.insts.cell.name ND3D*].name]
    set temp [llength $list]
    set nd3d2Quantity [expr {$spare_cell_percentage * $temp}]
    set nd3d2Quantity [expr {$nd3d2Quantity / $number_of_modules}]
    set nd3d2Quantity [expr {$nd3d2Quantity / $clk_len}]
    set nd3d2Quantity [expr {int($nd3d2Quantity)}]

    set list [dbGet [dbGet -p top.insts.cell.name NR2D*].name]
    set temp [llength $list]
    set nr2d2Quantity [expr {$spare_cell_percentage * $temp}]
    set nr2d2Quantity [expr {$nr2d2Quantity / $number_of_modules}]
    set nr2d2Quantity [expr {$nr2d2Quantity / $clk_len}]
    set nr2d2Quantity [expr {int($nr2d2Quantity)}]

    set list [dbGet [dbGet -p top.insts.cell.name NR3D*].name]
    set temp [llength $list]
    set nr3d2Quantity [expr {$spare_cell_percentage * $temp}]
    set nr3d2Quantity [expr {$nr3d2Quantity / $number_of_modules}]
    set nr3d2Quantity [expr {$nr3d2Quantity / $clk_len}]
    set nr3d2Quantity [expr {int($nr3d2Quantity)}]

    set tieHiCell [dbGet [dbGet -p head.libCells.name TIEH*].name]
    set tieHiCell [lindex $tieHiCell 0]
    
    set tieLoCell [dbGet [dbGet -p head.libCells.name TIEL*].name]
    set tieLoCell [lindex $tieLoCell 0]

    set i 1
    foreach CP $CLK_PORT {
        if {$LIB_PROCESS_NODE == 5} {
          set cell_height_280 [dbGet [dbGet -p head.libCells.name CKBKAD1BWP*].name]
          if ([regexp {280H} $cell_height_280]==1) {
            createSpareModule -cell "DFQKAD1${cell_name} $flopQuantity INVKAD1${cell_name} $inv1Quantity INVKAD2${cell_name} $inv2Quantity BUFFKAD1${cell_name} $buff1Quantity BUFFKAD2${cell_name} $buff2Quantity ND2KAD2${cell_name} $nd2d2Quantity ND3KAD2${cell_name} $nd3d2Quantity NR2KAD2${cell_name} $nr2d2Quantity NR3KAD2${cell_name} $nr3d2Quantity" -moduleName "spnrSpare${i}" -tie "$tieHiCell $tieLoCell" -tielo "ND2KAD2${cell_name}:A1 ND3KAD2${cell_name}:A1" -useCellAsPrefix -clock "$CP"
          } else {
            createSpareModule -cell "DFQD1${cell_name} $flopQuantity INVD1${cell_name} $inv1Quantity INVD2${cell_name} $inv2Quantity BUFFD1${cell_name} $buff1Quantity BUFFD2${cell_name} $buff2Quantity ND2D2${cell_name} $nd2d2Quantity ND3D2${cell_name} $nd3d2Quantity NR2D2${cell_name} $nr2d2Quantity NR3D2${cell_name} $nr3d2Quantity" -moduleName "spnrSpare${i}" -tie "$tieHiCell $tieLoCell" -tielo "ND2D2${cell_name}:A1 ND3D2${cell_name}:A1" -useCellAsPrefix -clock "$CP"
          }
        } else {
          createSpareModule -cell "DFQD1${cell_name} $flopQuantity INVD1${cell_name} $inv1Quantity INVD2${cell_name} $inv2Quantity BUFFD1${cell_name} $buff1Quantity BUFFD2${cell_name} $buff2Quantity ND2D2${cell_name} $nd2d2Quantity ND3D2${cell_name} $nd3d2Quantity NR2D2${cell_name} $nr2d2Quantity NR3D2${cell_name} $nr3d2Quantity" -moduleName "spnrSpare${i}" -tie "$tieHiCell $tieLoCell" -tielo "ND2D2${cell_name}:A1 ND3D2${cell_name}:A1" -useCellAsPrefix -clock "$CP"
        }
        incr i
    }

    set mincoordx [dbGet top.fplan.coreBox_llx]
    set maxcoordx [dbGet top.fplan.coreBox_urx]
    set mincoordy [dbGet top.fplan.coreBox_lly]
    set maxcoordy [dbGet top.fplan.coreBox_ury]

    set mincoordx [expr {int($mincoordx)}]
    set maxcoordx [expr {int($maxcoordx)}]
    set mincoordy [expr {int($mincoordy)}]
    set maxcoordy [expr {int($maxcoordy)}]

    set ypitch [expr {$maxcoordy - $mincoordy}]
    set ypitch [expr {$ypitch / $number_of_modules}]

    for {set j $mincoordy} {$j < $maxcoordy} {incr j $ypitch} {
        set y [expr {$j + $ypitch}]
        if {$y > $maxcoordy} {
            break
        }
        set i 1
        foreach CP $CLK_PORT {
          placeSpareModule -moduleName "spnrSpare${i}" -numModules 1 -prefix SPARE -area $mincoordx $j $maxcoordx $y
          incr i
        }
    }
}

#########################################################################################################
################ Procedure to place Filler Cells according to recommended guidelines ####################
#########################################################################################################

proc TIP_place_filler_cells {} {

    set cell_name [dbGet [dbGet -p head.libCells.name FILL*].name]
    if { $cell_name eq "" } {
        Puts [concat "**ERR" "OR: DFM_ERROR: No matching Filler cells available in the library. Fillers cannot be placed."]
	Puts [concat "**ERR" "OR: DFM_ERROR: Expected Filler cell name pattern is FILL<number><postfix>"]
	Puts [concat "**ERR" "OR: DFM_ERROR: Example FILL64BWP7T30P140"]
	return
    } else {
        Puts "DFM_INFO: All available FILL* cells are enabled to addFiller command"
    }
    
    setFillerMode -core $cell_name
    addFiller -prefix FILLER

}

#########################################################################################################
################### Procedure to get the Memory Macro locations ##################
#########################################################################################################


proc TIP_get_memory_macro_names {} {
    
    source Innovus_define.cmd
    if {[file exists "${TOP_DESIGN}_netlist.v"]} {
        source ${TOP_DESIGN}_syn.memory_macro_list
    }
    
    set DFM_Macro_Names [open "./Memory_Macros_Names.txt" w]
    foreach mem_inst $UNIQUE_MACRO_CELLS {
        puts $mem_inst
	set CHILD_MEMORY_MACROS [dbGet [dbGet -p2 top.insts.cell.name $mem_inst].name]
        Puts "Floorplan read: $CHILD_MEMORY_MACROS"
    	Puts $DFM_Macro_Names $CHILD_MEMORY_MACROS
    }
    close $DFM_Macro_Names
}


###################################################################################################################
################### Procedure to place Decap Cells based on Capacitance per unit area (Revised)  ##################
###################################################################################################################
proc TIP_place_decap_cells {} {

    source Innovus_define.cmd

    if {[regexp {_none_} $Innovus_DecapCells]==1} {
        Puts [concat "**ERR" "OR: DFM_ERROR: No Decap cells mentioned in the Innovus_DecapCells variable in the CadSetup.file"]
	Puts [concat "**ERR" "OR: DFM_ERROR: Decap Cells cannot be added. Exiting the flow"]
	exit
    }
    set config [regsub -all {\s+} $Innovus_DecapCells " "]
    set configList [split $config " "]

    #subroutine to separate the Innovus_Decapcells variable into CellName-Capacitance pairs
    set decapfile [open "./DecapCellCandidatesFile.txt" w]
    set decapindex 0
    while { $decapindex < [llength $Innovus_DecapCells] } {
        set decapslice [lrange $Innovus_DecapCells $decapindex [expr {$decapindex + 1}]]
	puts $decapfile $decapslice
	set decapindex [expr {$decapindex + 2}]
    }
    close $decapfile
    
    if { $Innovus_DecapPerUnitArea eq "0" } {
        Puts [concat "**ERR" "OR: DFM_ERROR: Decap Per unit area set to zero. Pleas enter a non-zero value for the Capacitance value"]
	Puts [concat "**ERR" "OR: DFM_ERROR: Decap Cells cannot be added. Exiting the flow"]
	exit
    }
    
    if {($USE_MEMORY_MACROS eq "1")} {
	TIP_get_memory_macro_names

#  Read memory macro names to identify blockages
    	set memory_macro_file [open "./Memory_Macros_Names.txt" r]
    	set macro_names_text [read $memory_macro_file]
    	set memory_macro_names [string trim $macro_names_text]
    	set memory_macros_list [list {*}$memory_macro_names]
    	close $memory_macro_file

# Calculate Total Memory Macro Area
    	set Total_Memory_Macro_Area 0
    	set Blockage_Area ""
    	foreach instName $memory_macros_list {
            set instArea [dbGet [dbGetInstByName $instName].pHaloBox_area]
	    set Total_Memory_Macro_Area [expr $Total_Memory_Macro_Area + $instArea]
    	    append Blockage_Area " " [dbGet [dbGetInstByName $instName].pHaloBox]
        }

# Calculate Total capacitance to be placed
    	set Total_Core_Area [dbGet top.fplan.CoreBox_area]
    	set Total_Decap_Coverage [expr $Total_Core_Area - $Total_Memory_Macro_Area]
    	set Total_Capacitance [expr $Innovus_DecapPerUnitArea*$Total_Decap_Coverage]

    	addDeCapCellCandidates -fromFile ./DecapCellCandidatesFile.txt
	if {$LIB_PROCESS_NODE <= 7} {
            addDeCap -totCap $Total_Capacitance -addFixAttr -effort high -log DecapPlacementInformation.txt -prefix DECAP -exclude $Blockage_Area -noFixDRC
        } else {
            addDeCap -totCap $Total_Capacitance -addFixAttr -effort high -log DecapPlacementInformation.txt -prefix DECAP -exclude $Blockage_Area
    	}
    } else {
        set Total_Core_Area [dbGet top.fplan.CoreBox_area]
	set Total_Capacitance [expr $Innovus_DecapPerUnitArea*$Total_Core_Area]
	addDeCapCellCandidates -fromFile ./DecapCellCandidatesFile.txt
	if {$LIB_PROCESS_NODE <= 7} {
            addDeCap -totCap $Total_Capacitance -addFixAttr -effort high -log DecapPlacementInformation.txt -prefix DECAP -noFixDRC
        } else {
            addDeCap -totCap $Total_Capacitance -addFixAttr -effort high -log DecapPlacementInformation.txt -prefix DECAP
        }	
    }

}

#########################################################################################################
################### Procedure to place Decap Cells according to recommended guidelines ##################
#########################################################################################################

proc TIP_place_decap_cells_grid_based {} {

source Innovus_define.cmd

if {[regexp {_none_} $Innovus_DecapCells]==1} {
    return
   }
set config [regsub -all {\s+} $Innovus_DecapCells " "]
set configList [split $config " "]

set decapfile [open "./DecapCellCandidatesFile.txt" w]
puts $decapfile $Innovus_DecapCells
close $decapfile

if {$Innovus_DecapWindowPitch==0} {
 addDeCapCellCandidates -fromFile ./DecapCellCandidatesFile.txt
 return
}

#  Read memory macro locations to identify blockages
set memory_macro_file [open "./Memory_Macros_Locations.txt" r]
set memory_locations_text [read $memory_macro_file]
set memory_macro_locations [string trim $memory_locations_text]
close $memory_macro_file

set mincoordx [dbGet top.fplan.coreBox_llx]
set maxcoordx [dbGet top.fplan.coreBox_urx]
set mincoordy [dbGet top.fplan.coreBox_lly]
set maxcoordy [dbGet top.fplan.coreBox_ury]

set mincoordx [expr {int($mincoordx)}]
set maxcoordx [expr {int($maxcoordx)}]
set mincoordy [expr {int($mincoordy)}]
set maxcoordy [expr {int($maxcoordy)}]

set horizontal_pitch_for_decap $Innovus_DecapWindowPitch
set vertical_pitch_for_decap $Innovus_DecapWindowPitch

set horizontal_pitch_for_decap [expr {int($horizontal_pitch_for_decap)}]
set vertical_pitch_for_decap [expr {int($vertical_pitch_for_decap)}]

set xpitch [expr {$maxcoordx - $mincoordx}]
set xpitch [expr {$xpitch / $horizontal_pitch_for_decap}]

set ypitch [expr {$maxcoordy - $mincoordy}]
set ypitch [expr {$ypitch / $vertical_pitch_for_decap}]

addDeCapCellCandidates -fromFile ../DecapCellCandidatesFile.txt 

for {set i $mincoordx} {$i < $maxcoordx} {incr i $xpitch} {
 set x [expr {$i + $xpitch}]
 for {set j $mincoordy} {$j < $maxcoordy} {incr j $ypitch} {
  set y [expr {$j + $ypitch}]
  addDeCap -totCap $Innovus_TotalDecapperWindow -addFixAttr -effort high -log DecapPlacementInfo.txt -prefix DECAP -area $i $j $x $y -exclude $memory_macro_locations
 }
}

}

#########################################################################################################
################## #Procedure to add Metal Fill according to recommended guidelines ##################
#########################################################################################################

proc TIP_add_metal_fill_floating {} {

    source Innovus_define.cmd
    
    set tech_lef [lindex $Lib_CadencePhysicalLibrary 0]
    set metal_layers [exec grep -B1 ROUTING $tech_lef | grep -v "^#" | grep LAYER | awk {{print $2}}]
    set metal_layers [split $metal_layers "\n"]
   
    if {$LIB_PROCESS_NODE <= 7} {
        set delete_metal_layers {}
        foreach layer_name $metal_layers {    
            if {[regexp {_FB1$} $layer_name] != 1 && [regexp {PC$} $layer_name] != 1 && [regexp {AP_} $layer_name] != 1  } {
                lappend delete_metal_layers $layer_name
            }
        }
        set metal_layers $delete_metal_layers
    }

    deleteMetalFill -layer $metal_layers
    setMetalFill -layer $metal_layers -iterationName STEP1 -minDensity 80 -maxDensity 100 -minUnionDensityToAboveLayer 160 
    addMetalFill -layer $metal_layers  -iterationNameList { STEP1 }

}

proc TIP_add_metal_fill {} {

    source Innovus_define.cmd
    
    set tech_lef [lindex $Lib_CadencePhysicalLibrary 0]
    set metal_layers [exec grep -B1 ROUTING $tech_lef | grep -v "^#" | grep LAYER | awk {{print $2}}]
    set metal_layers [split $metal_layers "\n"]
   
    if {$LIB_PROCESS_NODE <= 7} {
        set delete_metal_layers {}
        foreach layer_name $metal_layers {    
            if {[regexp {_FB1$} $layer_name] != 1 && [regexp {PC$} $layer_name] != 1 && [regexp {AP_} $layer_name] != 1  } {
                lappend delete_metal_layers $layer_name
            }
        }
        set metal_layers $delete_metal_layers
    }

    deleteMetalFill -layer $metal_layers
    setMetalFill -layer $metal_layers -iterationName STEP1 -minDensity 80 -maxDensity 100 -minUnionDensityToAboveLayer 160 
    addMetalFill -layer $metal_layers -nets "$Fplan_GroundNetName $Fplan_PowerNetName" -iterationNameList { STEP1 }

}


proc TIP_add_metal_fill_mesh {} {

    source Innovus_define.cmd
    
    set tech_lef [lindex $Lib_CadencePhysicalLibrary 0]
    set metal_layers [exec grep -B1 ROUTING $tech_lef | grep -v "^#" | grep LAYER | awk {{print $2}}]
    set metal_layers [split $metal_layers "\n"]
   
    if {$LIB_PROCESS_NODE <= 7} {
        set delete_metal_layers {}
        foreach layer_name $metal_layers {    
            if {[regexp {_FB1$} $layer_name] != 1 && [regexp {PC$} $layer_name] != 1 && [regexp {AP_} $layer_name] != 1  } {
                lappend delete_metal_layers $layer_name
            }
        }
        set metal_layers $delete_metal_layers
    }

    deleteMetalFill -layer $metal_layers
    setMetalFill -layer $metal_layers -iterationName STEP1 -minDensity 80 -maxDensity 100 -minUnionDensityToAboveLayer 160 
    addMetalFill -layer $metal_layers -nets "$Fplan_GroundNetName $Fplan_PowerNetName" -iterationNameList { STEP1 } -mesh

}


proc TIP_add_metal_fill_meshOnly {} {

    source Innovus_define.cmd
    
    set tech_lef [lindex $Lib_CadencePhysicalLibrary 0]
    set metal_layers [exec grep -B1 ROUTING $tech_lef | grep -v "^#" | grep LAYER | awk {{print $2}}]
    set metal_layers [split $metal_layers "\n"]
   
    if {$LIB_PROCESS_NODE <= 7} {
        set delete_metal_layers {}
        foreach layer_name $metal_layers {    
            if {[regexp {_FB1$} $layer_name] != 1 && [regexp {PC$} $layer_name] != 1 && [regexp {AP_} $layer_name] != 1  } {
                lappend delete_metal_layers $layer_name
            }
        }
        set metal_layers $delete_metal_layers
    }

    deleteMetalFill -layer $metal_layers
    setMetalFill -layer $metal_layers -iterationName STEP1 -minDensity 80 -maxDensity 100 -minUnionDensityToAboveLayer 160 
    addMetalFill -layer $metal_layers -nets "$Fplan_GroundNetName $Fplan_PowerNetName" -iterationNameList { STEP1 } -meshOnly

}

proc TIP_delete_metal_fill {} {

    source Innovus_define.cmd
    
    set tech_lef [lindex $Lib_CadencePhysicalLibrary 0]
    set metal_layers [exec grep -B1 ROUTING $tech_lef | grep -v "^#" | grep LAYER | awk {{print $2}}]
    set metal_layers [split $metal_layers "\n"]
   
    if {$LIB_PROCESS_NODE <= 7} {
        set delete_metal_layers {}
        foreach layer_name $metal_layers {    
            if {[regexp {_FB1$} $layer_name] != 1 && [regexp {PC$} $layer_name] != 1 && [regexp {AP_} $layer_name] != 1  } {
                lappend delete_metal_layers $layer_name
            }
        }
        set metal_layers $delete_metal_layers
    }

    deleteMetalFill -layer $metal_layers

}

#########################################################################################################
############## Procedure to perform and fix EM Check according to recommended guidelines ################
#########################################################################################################

proc TIP_em_check {} {

    source Innovus_define.cmd

    if {$LOW_POWER_STIM_FILE == "{}"} {
        extractRC
	set_signal_em_analysis_mode -ict_em_models $Lib_IctEmModel -toggle 0.2 -report EMViolations.report -method {rms avg peak}
        verifyACLimit 
        fixACLimitViolation -useReportFile EMViolations.report
    } else {
        read_activity_file -format SAIF -set_net_freq true $LOW_POWER_STIM_FILE
        verifyACLimit -use_db_freq -report EMViolations.rpt
        fixACLimitViolation -useReportFile EMViolations.rpt
    }

}

#########################################################################################################
############ Procedure to perform and fix Antenna Check according to recommended guidelines #############
#########################################################################################################

proc TIP_antenna_check {} {

    set cell_name [dbGet [dbGet -p head.libCells.name ANTEN*].name]
    
    if { $cell_name eq "" } {
        Puts [concat "**ERR" "OR: DFM_ERROR: No matching cells available for Antenna fixes. Antenna violations will not be checked or fixed"]
	return
    }

    setNanoRouteMode -drouteFixAntenna true
    setNanoRouteMode -routeAntennaCellName $cell_name
    setNanoRouteMode -routeInsertAntennaDiode true
    setNanoRouteMode -routeInsertDiodeForClockNets true

}

#########################################################################################################
################## Procedure to add I/O Buffers according to recommended guidelines #####################
#########################################################################################################

proc TIP_add_io_buffers {} {

    set cell_name [dbGet [dbGet -p head.libCells.name BUFF*].name]
    if { $cell_name eq "" } {
        Puts [concat "**ERR" "OR: DFM_ERROR: No matching cells available for I/O buffers. Buffers will not be inserted"]
	return
    }
    
    attachIOBuffer -port -suffix _IOBUF -in $cell_name -out $cell_name -status fixed

}

###########################################################################################
##  Procedure to report the Area occupied by the Cells added in the DFM flow  ##
###########################################################################################

proc TIP_report_DFM_Flow_cell_usage {} {
    
#Find Total Standard Cell area
    
    set stdCellArea 0
    dbForEachCellInst [dbHeadTopCell] inst {
        set cell [dbInstCell $inst]
        set cellName [dbCellName $cell]
        set instArea [TIP_userInstArea $inst]
	
        if {[dbIsInstStdCell $inst]} {
	    if {!([dbIsInstAreaIo $inst])} {
                set stdCellArea [expr $instArea + $stdCellArea]
            }
	}
    }
    
    set total_core_area [dbGet top.fplan.coreBox_area]
    
    #Code for formatting the output
    ######################################
    set area_strlength [string length $total_core_area]
    set area_header_string "Total Area"
    set area_header_line2 "(um2)"
    if { $area_strlength < 10 } {
        set area_strlength 10
    }
    
    set category_header_length 8
    set Instcount_header_length 14
    set perc_stdcell_header_length 34
    set util_header_length 34
    
    set separator [string repeat - $category_header_length][string repeat - $Instcount_header_length][string repeat - $area_strlength][string repeat - $perc_stdcell_header_length][string repeat - $util_header_length][string repeat - 6]
    
    set outfile [open "./DFM_Flow_Cell_Usage.rpt" w]
    puts $outfile $separator
    puts $outfile [format "|Category|Instance Count|%*s|Percentage of Total Std Cell Area |Contribution to Core utilization  |" $area_strlength $area_header_string]
    puts $outfile [format "|        |              |%*s|(%%)                               |(%%)                               |" $area_strlength $area_header_line2]
    puts $outfile $separator
    
#Find area of all the End Caps added in the DFM Flow
    set category_name "ENDCAP"
    set ENDCAP_AREA 0
    set ENDCAP_COUNT [llength [dbGet -p top.insts.name ENDCAP*]]
    if {[dbGet -p top.insts.name ENDCAP*] != 0x0} {
        foreach inst [dbGet -p top.insts.name ENDCAP*] {
            set ENDCAP_AREA [expr {$ENDCAP_AREA + [dbGet $inst.area]}]
        }
	set ENDCAP_PERC [expr {100*$ENDCAP_AREA/$stdCellArea}]
	set ENDCAP_UTIL [expr {100*$ENDCAP_AREA/$total_core_area}]
        puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $ENDCAP_COUNT $area_strlength [format "%.2f" $ENDCAP_AREA] $perc_stdcell_header_length [format "%3.3f" $ENDCAP_PERC] $util_header_length [format "%3.3f" $ENDCAP_UTIL]]
    } else {
	set ENDCAP_COUNT 0
	set ENDCAP_PERC 0
	set ENDCAP_UTIL 0
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $ENDCAP_COUNT $area_strlength $ENDCAP_AREA $perc_stdcell_header_length $ENDCAP_PERC $util_header_length $ENDCAP_UTIL]
    }

#Find area of all the Well Taps added in the DFM Flow
    set category_name "WELLTAP"
    set WELLTAP_AREA 0
    set WELLTAP_COUNT [llength [dbGet -p top.insts.name WELLTAP*]]
    if {[dbGet -p top.insts.name WELLTAP*] != 0x0} {
        foreach inst [dbGet -p top.insts.name WELLTAP*] {
            set WELLTAP_AREA [expr {$WELLTAP_AREA + [dbGet $inst.area]}]
        }
	set WELLTAP_PERC [expr {100*$WELLTAP_AREA/$stdCellArea}]
	set WELLTAP_UTIL [expr {100*$WELLTAP_AREA/$total_core_area}]
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $WELLTAP_COUNT $area_strlength [format "%.2f" $WELLTAP_AREA] $perc_stdcell_header_length [format "%3.3f" $WELLTAP_PERC] $util_header_length [format "%3.3f" $WELLTAP_UTIL]]
    } else {
	set WELLTAP_COUNT 0
	set WELLTAP_PERC 0
	set WELLTAP_UTIL 0
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $WELLTAP_COUNT $area_strlength $WELLTAP_AREA $perc_stdcell_header_length $WELLTAP_PERC $util_header_length $WELLTAP_UTIL]
    }

#Find area of all the Decap cells added in DFM Flow
    set category_name "DECAP"
    set DECAP_AREA 0
    set DECAP_COUNT [llength [dbGet -p top.insts.name DECAP*]]
    if {[dbGet -p top.insts.name DECAP*] != 0x0} {
        foreach inst [dbGet -p top.insts.name DECAP*] {
            set DECAP_AREA [expr {$DECAP_AREA + [dbGet $inst.area]}]
        }
	set DECAP_PERC [expr {100*$DECAP_AREA/$stdCellArea}]
	set DECAP_UTIL [expr {100*$DECAP_AREA/$total_core_area}]
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $DECAP_COUNT $area_strlength [format "%.2f" $DECAP_AREA] $perc_stdcell_header_length [format "%3.3f" $DECAP_PERC] $util_header_length [format "%3.3f" $DECAP_UTIL]]
    } else {
	set DECAP_COUNT 0
	set DECAP_PERC 0
	set DECAP_UTIL 0
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $DECAP_COUNT $area_strlength $DECAP_AREA $perc_stdcell_header_length $DECAP_PERC $util_header_length $DECAP_UTIL]
    }

#Find area of all the Filler cells added in DFM Flow
    set category_name "TIECELL"
    set TIECELL_AREA 0
    set TIECELL_COUNT [llength [dbGet -p top.insts.name TIECELL*]]
    if {[dbGet -p top.insts.name TIECELL*] != 0x0} {
        foreach inst [dbGet -p top.insts.name TIECELL*] {
            set TIECELL_AREA [expr {$TIECELL_AREA + [dbGet $inst.area]}]
        }
	set TIECELL_PERC [expr {100*$TIECELL_AREA/$stdCellArea}]
	set TIECELL_UTIL [expr {100*$TIECELL_AREA/$total_core_area}]
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $TIECELL_COUNT $area_strlength [format "%.2f" $TIECELL_AREA] $perc_stdcell_header_length [format "%3.3f" $TIECELL_PERC] $util_header_length [format "%3.3f" $TIECELL_UTIL]]
    } else {
	set TIECELL_COUNT 0
	set TIECELL_PERC 0
	set TIECELL_UTIL 0
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $TIECELL_COUNT $area_strlength $TIECELL_AREA $perc_stdcell_header_length $TIECELL_PERC $util_header_length $TIECELL_UTIL]
    }
    
#Find area of all the Filler cells added in DFM Flow
    set category_name "FILLER"
    set FILLER_AREA 0
    set FILLER_COUNT [llength [dbGet -p top.insts.name FILLER*]]
    if {[dbGet -p top.insts.name FILLER*] != 0x0} {
        foreach inst [dbGet -p top.insts.name FILLER*] {
            set FILLER_AREA [expr {$FILLER_AREA + [dbGet $inst.area]}]
        }
	set FILLER_PERC [expr {100*$FILLER_AREA/$stdCellArea}]
	set FILLER_UTIL [expr {100*$FILLER_AREA/$total_core_area}]
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $FILLER_COUNT $area_strlength [format "%.2f" $FILLER_AREA] $perc_stdcell_header_length [format "%3.3f" $FILLER_PERC] $util_header_length [format "%3.3f" $FILLER_UTIL]]
    } else {
	set FILLER_COUNT 0
	set FILLER_PERC 0
	set FILLER_UTIL 0
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $FILLER_COUNT $area_strlength $FILLER_AREA $perc_stdcell_header_length $FILLER_PERC $util_header_length $FILLER_UTIL]
    }
    
#Find area of all the Filler cells added in DFM Flow
    set category_name "SPARE"
    set SPARE_AREA 0
    set SPARE_COUNT [llength [dbGet -p top.insts.name SPARE*]]
    if {[dbGet -p top.insts.name SPARE*] != 0x0} {
        foreach inst [dbGet -p top.insts.name SPARE*] {
            set SPARE_AREA [expr {$SPARE_AREA + [dbGet $inst.area]}]
        }
	set SPARE_PERC [expr {100*$SPARE_AREA/$stdCellArea}]
	set SPARE_UTIL [expr {100*$SPARE_AREA/$total_core_area}]
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $SPARE_COUNT $area_strlength [format "%.2f" $SPARE_AREA] $perc_stdcell_header_length [format "%3.3f" $SPARE_PERC] $util_header_length [format "%3.3f" $SPARE_UTIL]]
    } else {
	set SPARE_COUNT 0
	set SPARE_PERC 0
	set SPARE_UTIL 0
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $SPARE_COUNT $area_strlength $SPARE_AREA $perc_stdcell_header_length $SPARE_PERC $util_header_length $SPARE_UTIL]
    }
    
#Find area of all the I/O Buffers added in the DFM Flow
    set category_name "IOBUF"
    set IOBUF_AREA 0
    set IOBUF_COUNT [llength [dbget [dbget -p top.terms.name *].net.instTerms.inst.name *_IOBUF]]
    if {[dbget [dbget -p top.terms.name *].net.instTerms.inst.name *_IOBUF] != 0x0} {
        foreach inst [dbGet -p [dbGet -p top.terms.name *].net.instTerms.inst.name *_IOBUF] {
            set IOBUF_AREA [expr {$IOBUF_AREA + [dbGet $inst.area]}]
        }
	set IOBUF_PERC [expr {100*$IOBUF_AREA/$stdCellArea}]
	set IOBUF_UTIL [expr {100*$IOBUF_AREA/$total_core_area}]
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $IOBUF_COUNT $area_strlength [format "%.2f" $IOBUF_AREA] $perc_stdcell_header_length [format "%3.3f" $IOBUF_PERC] $util_header_length [format "%3.3f" $IOBUF_UTIL]]
    } else {
	set IOBUF_COUNT 0
	set IOBUF_PERC 0
	set IOBUF_UTIL 0
	puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $IOBUF_COUNT $area_strlength $IOBUF_AREA $perc_stdcell_header_length $IOBUF_PERC $util_header_length $IOBUF_UTIL]
    }
    puts $outfile $separator
    
    #Print final DFM statistics
    set Total_DFM_Area [expr {$ENDCAP_AREA + $WELLTAP_AREA + $DECAP_AREA + $TIECELL_AREA + $FILLER_AREA + $SPARE_AREA + $IOBUF_AREA}]
    set Total_DFM_Count [expr {$ENDCAP_COUNT + $WELLTAP_COUNT + $DECAP_COUNT + $TIECELL_COUNT + $FILLER_COUNT + $SPARE_COUNT + $IOBUF_COUNT}]
    set Total_DFM_PERC [expr {$ENDCAP_PERC + $WELLTAP_PERC + $DECAP_PERC + $TIECELL_PERC + $FILLER_PERC + $SPARE_PERC + $IOBUF_PERC}]
    set Total_DFM_UTIL [expr {$ENDCAP_UTIL + $WELLTAP_UTIL + $DECAP_UTIL + $TIECELL_UTIL + $FILLER_UTIL + $SPARE_UTIL + $IOBUF_UTIL}]
    set category_name "TOTAL"
    
    puts $outfile [format "|%*s|%*s|%*s|%*s|%*s|" $category_header_length $category_name $Instcount_header_length $Total_DFM_Count $area_strlength [format "%.2f" $Total_DFM_Area] $perc_stdcell_header_length [format "%3.3f" $Total_DFM_PERC] $util_header_length [format "%3.3f" $Total_DFM_UTIL]]
    puts $outfile $separator
    
    # Calculate block usage
    puts $outfile "\n"
    
    set Block_Area 0
    if { [dbGet top.insts.cell.baseClass block] != 0x0 } {
        foreach inst [dbGet -p2 top.insts.cell.baseClass block] {
	    set inst_sizex [dbGet $inst.box_sizex]
	    set inst_sizey [dbGet $inst.box_sizey]
	    set inst_Area [expr {$inst_sizex * $inst_sizey}]
	    set Block_Area [expr {$Block_Area + $inst_Area}]
	}
    }
	    
    set STDCELL_utilization [expr {$stdCellArea - $Total_DFM_Area}]
    set STDCELL_utilization [expr {$STDCELL_utilization + $Block_Area}]
    set Core_utilization [expr 100*$STDCELL_utilization/$total_core_area]
    
    puts $outfile "Core Density (Excluding DFM additions) = (Standard Cell (excluding DFM additions) + Block + Black Box) / Core Area"
    puts $outfile [format "Core Density (Excluding DFM additions) = %3.2f%%" $Core_utilization]
    
    close $outfile
}
