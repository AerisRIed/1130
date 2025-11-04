#!/bin/csh

#------------------------------------------------
# this is a pg auto generate scripts for Jenkins
# created by zming 2025.9.3
#-----------------------------------------------
#zhangx@cadence.com junqiang@cadence.com zhixue@cadence.com nawang@cadence.com

set DIR = "${PHY_SCRIPTS_DIR}/pg_scripts/pg_csv/"
set LAST_COMMIT = `git log -n 1 --pretty=format:"%H" -- "pg_csv"`
echo $LAST_COMMIT

if ( -f .dir_last_commit ) then
    set PREV_COMMIT = `cat .dir_last_commit`
else
    set PREV_COMMIT = ""
endif

if ( "$LAST_COMMIT" != "$PREV_COMMIT" ) then
    echo "[INFO] $PREV_COMMIT -> $LAST_COMMIT"
    echo "[INFO] There is a new updated"
	echo "[INFO] Try to update the dir_last_commit..."
	echo "[INFo] Call gen_pg_cfg.py ..."
	python3 gen_pg_cfg.py -a -n
	echo "$LAST_COMMIT" > .dir_last_commit
	git pull origin main
	git add .dir_last_commit cdn_phy_bring_up_task.sv cdn_phy_pg_task_extern_define.sv
	git commit -m "Auto updated dir_last_commit and bring up task via Jenkins"
	git push origin HEAD:main
	ssh kdt-vmanager01 'pwd;cd /rscratch/general/wangna/eUSB2V2/jenkins_test_dv/workspace/workspace/USB4_PG_Task_Generate/verif/scripts/pg_scripts;set UP_COMMIT = `cat .dir_last_commit`; set COMMIT_ID = `git log -n 1 --pretty=format:"%H" -- "cdn_phy_bring_up_task.sv"`;set FILE_INFO = `git show --name-only $UP_COMMIT`;if (`echo "$FILE_INFO" | grep -c "Merge"` > 0) set FILE_INFO = `git show --name-only ${UP_COMMIT}~1`;echo "$FILE_INFO";echo "$COMMIT_ID";echo "Hi all,\nJenkins has updated bring up PG task automatically! \nPlease pay attention to whether the bring up register is working properly! \nTask commit ID: $COMMIT_ID\nChanged by\n$FILE_INFO\nThanks Ming\n  " | mail -s "USB4 PG Task Generate Auto send via Jenkins" zming@cadence.com zhangx@cadence.com junqiang@cadence.com zhixue@cadence.com nawang@cadence.com'
else
    echo "[INFO] There is no updated"

endif


