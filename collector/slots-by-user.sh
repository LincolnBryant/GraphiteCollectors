#!/bin/bash
# Run the python script, then filter for our schedd name. Summarize the data and send to graphite 
python job-slots.py | grep "osgconnect" | sort | uniq -c | awk -v date=`date +%s` '{ print "osgconnect.condor.slots.by_user." $2,$1,date}' | nc -w30 webapps.mwt2.org 2003
