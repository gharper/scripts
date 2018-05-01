#!/usr/bin/env bash
# Monitors processes for runaways & kills if found

TMP_FILE=/tmp/strace.out
LOG_FILE=/var/log/runaway_proc_mon.log
NOTIFY_EMAIL=””
DATESTAMP=$(date)
PROC_OWNER=""
PROC_NAME=""
# Get list of processes using > 90% of the cpu
highcpu=$(top -b -n 1 -u $PROC_OWNER |
          grep $PROC_NAME |
          awk '{print $9 " " $1}' |
          sed 's/[.]//' |
          awk '{if ($1 > 90) print $2}')

for procid in $highcpu ; do
  # Get the cpu time of the process, strip out ':' and leading 0s
  proctime=$(ps o cputime -p $procid | sed '1d;s/://g;s/^0*//')
  # Check if running for longer than 2hrs
  if [[ $proctime -gt "20000" ]] ; then
    # Start strace on long running & high cpu process
    strace -p $procid -o $TMP_FILE &
    # Keep the strace pid
    stracepid=$!
    # Wait for reasonable amount of output then kill strace
    sleep 1
    if ( ! kill -9 $stracepid ) ; then
      /bin/mail -s "ATTN! strace not killed on $HOSTNAME" $NOTIFY_EMAIL
    fi
    # Get 10 lines of clean output, count number of repeating lines
    traceoutput=$(head -11 $TMP_FILE|sed '1d'|uniq -D|wc -l)
    # If all 10 lines are identical
    if [[ "$traceoutput" -eq "10" ]] ; then
      # Kill the runaway process
      runtime=$(ps o cputime -p $procid|sed '1d')
      if ( kill $procid ) ; then
        echo "SUCCESS: $DATESTAMP Killed PID $procid after $runtime of runtime" >> $LOG_FILE
      else
        echo "FAILED: $DATESTAMP Could not kill PID $procid" >> $LOG_FILE
        /bin/mail -s "ATTN! Could not kill $procid on $HOSTNAME" $NOTIFY_EMAIL
      fi
    fi
    # Delete tmp.out before leaving the scope
    rm $TMP_FILE
  fi
done
exit 0
