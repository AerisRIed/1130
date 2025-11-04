Author: matthew@cadence.com
edited by swenchen

reg_model_gen
  |->create_ipxact_eusb
  |---> py_files – python program files
  |---> projects
  |---> scripts – scripts used to help bootstrap a new project

defined needed:
${PHY_VERIF_AREA}---use for reg model gen directory
${PHY_IPXACT_HOME} --- use for ipxact files save
 ${PHY_DESIGN_AREA} --- use for store origin xml 

prepare steps: 
1.design release ipxact files in directory ${PHY_DESIGN_AREA}/ipxact



run scripts:
./create_ipxact_eusb 

run success when -> Done flag exists and no more *E or error find when running 


