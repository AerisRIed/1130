#!/bin/csh -f

cd ../../../
source sourceme.csh
sleep 1
cd trunk/design/ssg_omega_script_pack_OA-2025p4/
module unload jasper
unalias module
source ./scripts/core/common/omega_tool_setup.sh

