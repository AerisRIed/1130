#!/bin/tcsh
cd ${WORKSPACE}
source sourceme.csh
cd ${PHY_SCRIPTS_DIR}/pg_scripts
echo "start call update task"
./check_pg_updated.csh

