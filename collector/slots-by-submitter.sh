# by submit host
python job-slots.py | awk '{print $2}' | tr '.' '_'  | sort | uniq -c | awk -v date=`date +%s` '{ print "osgconnect.condor.slots.by_submitter." $2,$1,date}' | nc -w30 webapps.mwt2.org 2003
