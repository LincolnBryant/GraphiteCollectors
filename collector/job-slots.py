#!/bin/env python
# Polls the Condor collector

# Import some standard python utilities
import sys, time, argparse
import classad, htcondor

collectors = ["osg-flock.grid.iu.edu","rccf-osg.ci-connect.net:11011?sock=collector","uc3-mon.mwt2.org"]

# iterate through the slots, print out the user and schedd of the claimed ones
for collector in collectors:
  coll = htcondor.Collector(collector)
  slotState = coll.query(htcondor.AdTypes.Startd, "true",['Name','RemoteGroup','JobId','State','RemoteOwner','COLLECTOR_HOST_STRING','Cpus'])

  timestamp = str(int(time.time()))
  for slot in slotState[:]:
    if (slot['State'] == "Owner") or (slot['State'] == "Unclaimed") or (slot['State'] == "Preempting") or (slot['State'] == "Matched"):  ## If slot is in owner state there is no RemoteOwner or RemoteGroup
      print slot['State'] + ' none'
    if (slot['State'] == "Claimed"):
      for cpu in range(0,int(slot['Cpus'])):
        print ' '.join(slot['RemoteOwner'].split("@"))
