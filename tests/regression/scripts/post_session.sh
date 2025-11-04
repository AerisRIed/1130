#!/bin/sh
# Session dir cleanup
# Put any clean up commands to apply for the session dir
# Run dir cleanup

for mylog in $(find . -name "*.elog"); do
   \rm $mylog
done

for arun in chain*/run_*; do

    # Put any cleanup commands to apply to ALL runs here

    if [ -r ${arun}/vm_run_status ]; then
	status=`cat ${arun}/vm_run_status`;
	if [ $status = "passed" ]; then
	    #Put any clean up commands to apply only to PASSED runs here
	    \rm ${arun}/local_log.log
            # delete the xrun.log. Same info in local_log.log
	    for mylog in $(find ${arun}/cov_work -name xrun.log); do
                ls $mylog
		\rm $mylog
	    done
	elif [ $status = "failed" ]; then
	    #Put any clean up commands to apply only to FAILED runs here
	    for mylog in $(find ${arun}/cov_work -name xrun.log); do
		gzip $mylog
	    done
	else
	    echo "Unknown status";
	fi
    fi
done
