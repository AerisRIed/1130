#############################################################################################
#        Copyright (c) 2009-2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.        #
# These coded instructions, statements, and computer programs are the                       #
# copyrighted works and confidential proprietary information of Cadence Design Systems Inc. #
# They may not be modified, copied, reproduced, distributed, or disclosed to                #
# third parties in any manner, medium, or form, in whole or in part, without                #
# the prior written consent of Cadence Design Systems Inc.                                  #
#############################################################################################

proc TIP_create_floorplan {} {
  source Innovus_define.cmd
  global FILE_NAME_PREFIX
  TIP_get_file_name_prefix

  set total_area 0.0
  foreach cell_area [dbget top.insts.area] {
    set total_area [expr $total_area + $cell_area]
  }
  set fplan_area [expr $total_area / $Fplan_CoreUtilization]
  set Fplan_Width [expr sqrt($fplan_area / $Fplan_AspectRatio)]
  set Fplan_Height [expr $fplan_area / $Fplan_Width]

  if {$LIB_PROCESS_NODE == 3} {
    set cell_name [lindex [dbGet -u head.libCells.name *BWP*] 0]
    deleteRow -all
    setFPlanMode -initAllCompatibleCoreSiteRows true
    setFPlanMode -rowHeightMultiple 2
    if {[regexp BWP143 $cell_name]} { 
      setFPlanMode -defaultRowPatternSite coreW48M143H286 -firstRowSiteIndex 0 -lastRowSiteIndex 0
      setFPlanMode -rowSiteHeight computed
      setFPlanMode -rowHeightIncrementCornerToCorner 3
      setFPlanMode -rowHeightIncrementIncornerToCorner 0
      setFPlanMode -rowHeightIncrementIncornerToIncorner 5
      setPreference ConstraintUserYGrid 0.572
      setPreference ConstraintUserXGrid 0.048
      set Fplan_CoreToIOSpacing_LeftRight 1.2
      set Fplan_CoreToIOSpacing_TopBot 1.2285
      set Fplan_Width [expr [expr int($Fplan_Width/0.192)*0.192 + 0.144]]
      set Fplan_Height [expr int($Fplan_Height/0.572)*0.572 - 0.169]
    } elseif {[regexp BWP169 $cell_name]} {
      setFPlanMode -rowSiteHeight even 
      setFPlanMode -rowHeightIncrementCornerToCorner 4
      setFPlanMode -rowHeightIncrementIncornerToCorner 0
      setFPlanMode -rowHeightIncrementIncornerToIncorner 4
      setPreference ConstraintUserYGrid 0.338
      if {[regexp BWP169H3P48 $cell_name]} {
        setPreference ConstraintUserXGrid 0.048
        set Fplan_CoreToIOSpacing_LeftRight 1.2
        set Fplan_Width [expr [expr int($Fplan_Width/0.192)*0.192 + 0.144 ]]
        set Fplan_Height [expr int($Fplan_Height/0.338)*0.338]
        set core_name bcoreW48H169
      } elseif {[regexp BWP169H3P54 $cell_name]} {
        setPreference ConstraintUserXGrid 0.054
        set Fplan_CoreToIOSpacing_LeftRight [expr 0.003 + 0.432*3 ]
        set Fplan_Width [expr int($Fplan_Width/0.432)*0.432 - 0.054]
        set Fplan_Height [expr int($Fplan_Height/0.338)*0.338]
        set core_name bcoreW54H169
      }
      set Fplan_CoreToIOSpacing_TopBot 1.352
    }
    set Fplan_AspectRatio [expr $Fplan_Height/$Fplan_Width]
    set Fplan_Area [expr $Fplan_Height*$Fplan_Width]
    set Fplan_CoreUtilization [expr $total_area/$Fplan_Area]
    setFPlanMode -snapDieGrid userDefine
    setFPlanMode -snapCoreGrid userDefine
    set additional_cmd "-coreMarginsBy die -fplanOrigin llcorner -flip s -noSnapToGrid"
  } elseif {$LIB_PROCESS_NODE == 5} {
    setFPlanMode -checkTypes oddEvenSiteRow
    setFPlanMode -rowSiteWidth odd
    setFPlanMode -rowSiteHeight even
    setPreference ConstraintUserYGrid 0.028
    setPreference ConstraintUserXGrid 0.051
    setFPlanMode -snapDieGrid userDefine
    setFPlanMode -snapCoreGrid userDefine
    setFPlanMode -snapIoGrid userDefine
    setFPlanMode -snapBlockGrid userDefine
    if {$Fplan_CoreToIOSpacing == 0} {
      set Fplan_CoreToIOSpacing_LeftRight 0
      set Fplan_CoreToIOSpacing_TopBot 0
    } else {
      set lr_factor [expr round(($Fplan_CoreToIOSpacing - 0.816) / 0.204)]
      if {$lr_factor < 0} {set lr_factor 0}
      set Fplan_CoreToIOSpacing_LeftRight [expr ($lr_factor * 0.204) + 0.816]
      set tb_factor [expr round(($Fplan_CoreToIOSpacing - 0.840) / 0.420)]
      if {$tb_factor < 0} {set tb_factor 0}
      set Fplan_CoreToIOSpacing_TopBot [expr ($tb_factor * 0.420) + 0.840]
    }
    set additional_cmd "-coreMarginsBy die -flip s"
  } else {
    if {$LIB_PROCESS_NODE == 40} {
      set core_name core12T
    } else {
      set core_name core
    }
    if {$LIB_PROCESS_NODE == 7} {
      setFPlanMode -rowSiteWidth even
      fpiSetSnapRule -for BLK -grid PG -force
    }
    set additional_cmd "-site $core_name"
    set Fplan_CoreToIOSpacing_LeftRight $Fplan_CoreToIOSpacing
    set Fplan_CoreToIOSpacing_TopBot $Fplan_CoreToIOSpacing
  }
  set fp_cmd "floorPlan $additional_cmd -r $Fplan_AspectRatio $Fplan_CoreUtilization $Fplan_CoreToIOSpacing_LeftRight $Fplan_CoreToIOSpacing_TopBot $Fplan_CoreToIOSpacing_LeftRight $Fplan_CoreToIOSpacing_TopBot"
  eval $fp_cmd
  initCoreRow
  cutRow

  generateTracks -honorPitch
  if {$LIB_PROCESS_NODE == 3} {
    if {[regexp BWP143 $cell_name]} { 
      set addTrack_pitch_pattern " {m0 offset -0.0060 \
                                    width 0.027 pitch 0.030 width 0.013 pitch 0.0230 width 0.013 pitch 0.0230 \
                                    width 0.013 pitch 0.0230 width 0.013 pitch 0.030 width 0.027 pitch 0.0305 \
                                  { width 0.014 pitch 0.0240 repeat 4 } width 0.014 pitch 0.0305 \
                                    width 0.027 pitch 0.030 width 0.013 pitch 0.0230 width 0.013 pitch 0.0230 \
                                    width 0.013 pitch 0.0230 width 0.013 pitch 0.030 width 0.027 pitch 0.0305 \
                                  { width 0.014 pitch 0.0240 repeat 4 } width 0.014 pitch 0.0305}"
      set addTrack_mask_pattern  "{m0 1 2 m2 2 1 m5 1 2}"
      set addTrack_offset "{m1  vert         0.024   m2  horiz         0.0195  m3  vert         0.024     m4  horiz 0.0 \
                            m5  vert         0.024   m6  horiz die_box 0.0     m7  vert die_box 0.052     m8  horiz die_box 0.0 \
                            m9  vert die_box 0.052   m10 horiz die_box 0.0     m11 vert die_box 0.052     m12 horiz die_box 0.0 \
                            m13 vert die_box 0.052   m14 horiz die_box 0.0     m15 vert die_box 0.0       m16 horiz die_box 0.0     m17 vert die_box 0.0}"
      add_tracks \
          -width_pitch_pattern $addTrack_pitch_pattern \
          -mask_pattern $addTrack_mask_pattern \
          -offset $addTrack_offset 
    } elseif {[regexp BWP169 $cell_name]} {
      if {[regexp BWP169H3P48 $cell_name]} {
        set M1_track_offset 0.024
        set addTrack_pitch_pattern "{m0 offset 0.0 \
            width 0.039 pitch 0.0365 \
            {width 0.014 pitch 0.024 repeat 4} \
            width 0.014 pitch 0.0365 }"
        set addTrack_mask_pattern  "{m0 2 1 m2 1 2 m5 1 2}"
        set M2_track_offset 0
        set addTrack_offset "{m1  vert  ${M1_track_offset} m2  horiz  ${M2_track_offset}  m3  vert  ${M1_track_offset}  m4  horiz 0.0 \
                              m5  vert  ${M1_track_offset} m6  horiz  die_box 0.0         m7  vert  die_box  0.052      m8  horiz die_box 0.0 \
                              m9  vert  die_box 0.052      m10 horiz  die_box 0.0         m11 vert  die_box  0.052      m12 horiz die_box 0.0 \
                              m13 vert  die_box 0.052      m14 horiz  die_box 0.0         m15 vert  die_box  0.0        m16 horiz die_box 0.0 \
                              m17 vert die_box 0.0         }"
        add_tracks \
            -width_pitch_pattern $addTrack_pitch_pattern \
            -mask_pattern $addTrack_mask_pattern \
            -offset $addTrack_offset 
      } elseif {[regexp BWP169H3P54 $cell_name]} {
        set M1_track_offset 0.027
        set addTrack_pitch_pattern "{m0 offset 0.0 \
            width 0.039 pitch 0.0365 \
            {width 0.014 pitch 0.024 repeat 4} \
            width 0.014 pitch 0.0365 \
            m2 offset 0.0 \ 
            width 0.018 pitch 0.033 \
            {width 0.020 pitch 0.034 repeat 8} \
            width 0.020 pitch 0.033 }"
        set addTrack_mask_pattern  "{m0 2 1 m2 2 1 m5 1 2}"
        set M2_track_offset 0
        set addTrack_offset "{m1  vert  ${M1_track_offset} m2  horiz  ${M2_track_offset}  m3  vert  ${M1_track_offset}  m4  horiz 0.0 \
                              m5  vert  ${M1_track_offset} m6  horiz  die_box 0.0         m7  vert  die_box 0.0520      m8  horiz die_box 0.0 \
                              m9  vert  die_box 0.0520     m10 horiz  die_box 0.0         m11 vert  die_box 0.0520      m12 horiz die_box 0.0 \
                              m13 vert  die_box 0.0        m14 horiz  die_box 0.0         m15 vert  die_box 0.0         }"
        add_tracks \
            -width_pitch_pattern $addTrack_pitch_pattern \
            -mask_pattern $addTrack_mask_pattern \
            -offset $addTrack_offset 
      }
    }
  }

  if {$Innovus_PlaceIOPins == 1} {
    TIP_place_io_pins_noc
  } elseif {$Innovus_FP_USE == 1} {
    setPlaceMode -placeIoPins true 
    setDesignMode -process $LIB_PROCESS_NODE
    setDesignMode -flowEffort standard
    placeDesign
    Puts [format "%s%s" "**ERR" "OR: Floorplan has been generated with non-recommended pin placement (Innovus_PlaceIOPins=0)."]
    Puts [format "%s%s" "**ERR" "OR: Use of this floorplan for Genus-P runs or future Innovus runs is highly discouraged."]
    Puts [format "%s%s" "**ERR" "OR: Refer to the HUG for more details."]
  } else {
    Puts [format "%s%s" "**ERR" "OR: Floorplan requires pin placement. Set Innovus_PlaceIOPins to 1 and rerun."]
    exit
  }

  if {[sizeof_collection [get_cells -hierarchical * -filter "is_macro_cell==true"]] == 0} {
    if {$Innovus_EnablePowerPlan==1} {
      if {[file exists $Innovus_PPlan_File]} {
        source $Innovus_PPlan_File
      } else {
        Puts [format "%s%s" "**ERR" "OR: Power plan script provided by user does not exist. Provide correct path to the Innovus_PPlan_File variable."]
        exit
      }
      clearDrc
      redirect -variable drc {verify_drc -check_only special}
      if {[regexp {Verification Complete\s*:\s*(\d+)\s*Viols} $drc dummy count]==1} {
        if {$count > 0} {
          Puts [format "%s%s" "**ERR" "OR: Power plan has routing DRCs. Please review the power plan script. As a workaround, disable power plan generation by setting Innovus_EnablePowerPlan to 0."]
        }
      }
    } else {
      Puts [format "%s%s" "**IN" "FO: Innovus_EnablePowerPlan is set to 0. Proceeding without power plan."]
    }
  } else {
    if {$Innovus_FP_USE == 0} {
      if {[sizeof_collection [get_cells -hierarchical * -filter "is_macro_cell==true"]] > [sizeof_collection [get_cells -hierarchical * -filter "is_memory_cell==true"]]} {
        Puts [format "%s%s" "**ERR" "OR: Automated floorplan generation and Mixed placer flow are currently not supported for designs having ETM or ILM blocks."
        Puts [format "%s%s" "**ERR" "OR: Provide path to a DEF file to the Fplan_File variable. Rerun with Innovus_MixedPlacer set to 0 and Innovus_FP_USE set to 2."]
        exit
      } elseif {$Innovus_MixedPlacer == 0} {
        Puts [format "%s%s" "**ERR" "OR: Flow requires macro placement to proceed. Set Innovus_MixedPlacer to 1 and rerun."]
        exit
      }
    }
  }
  defOut -floorplan [format "%s%s" $FILE_NAME_PREFIX "_autofloorplan.def"]
}

