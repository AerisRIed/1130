echo "Starting post_run_script"
    if [ -r vm_run_status ]; then
	    status=`cat vm_run_status`;
	    if [ $status == "passed" ]; then
	        #Put any clean up commands to apply only to PASSED runs here
	        \rm -rfv local_log.log
                # delete the xrun.log. Same info in local_log.log
	        for mylog in $(find cov_work -name xrun.log); do
                ls $mylog
                gzip $mylog
	        done
	    elif [ $status == "failed" ]; then
	        #Put any clean up commands to apply only to FAILED runs here
	        for mylog in $(find cov_work -name xrun.log); do
                gzip $mylog
	        done
            #gzip local_log.log
	    else
	        echo "Unknown status";
	    fi
    fi
