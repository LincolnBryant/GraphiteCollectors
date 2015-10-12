#!/bin/bash
# Parses condor_q, removes spaces, sorts and counts entries. Removes extraneous lines and puts the data into graphite format before sending it off
condor_q | awk '{print $2,$6}' | grep -v "^[[:space:]]" | sort | uniq -c | grep -v "jobs; removed" | grep -v "OWNER" | grep -v "Submitter\:"  | awk -v date=$(date +%s) '{ print "condor.osgconnect.schedd." $2 "." $3,$1,date}' | nc -w 30 graphite.mwt2.org 2003
