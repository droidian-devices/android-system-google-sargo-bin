#!/bin/bash

rm -rf system partitions halium_sargo.tar.xz

LATEST=$(wget -O - https://ci.ubports.com/job/UBportsCommunityPortsJenkinsCI/job/ubports%252Fporting%252Fcommunity-ports%252Fjenkins-ci%252Fsargo/job/main/api/json | awk -F 'org.jenkinsci.plugins.workflow.job.WorkflowRun' '{print $2}' | cut -d '"' -f7)
wget $LATEST/artifact/halium_sargo.tar.xz

tar -xf halium_sargo.tar.xz
