#!/bin/bash
# This script queries for the MATCH_EXP_JOBGLIDEIN_ResourceName classad for vanilla universe jobs. It removes spaces and changes all periods to underscores, as those are special characters in Graphite. Lastly it sorts, counts, and puts the data into graphite format before sending it off via nc
condor_q -constraint 'JobUniverse == 5 && JobStatus == 2' -format '%10s \n' MATCH_EXP_JOBGLIDEIN_ResourceName | sed 's/[[:space:]]//g' | tr '.' '_' | sort | uniq -c | awk -v date=$(date +%s) '{ print "condor.osgconnect.schedd.by_provider." $2,$1,date }' | nc -w 30 graphite.mwt2.org 2003
