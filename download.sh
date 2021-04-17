#!/bin/bash -x

set -e

CI_JOB_ID="lastSuccessfulBuild"
ARCH="arm64"

DOWNLOAD_URL="https://ci.ubports.com/job/UBportsCommunityPortsJenkinsCI/job/ubports%252Fcommunity-ports%252Fjenkins-ci%252Fgeneric_${ARCH}/job/main/${CI_JOB_ID}/artifact/halium_halium_${ARCH}.tar.xz"

rm -rf downloaded_artifacts
mkdir -p downloaded_artifacts

curl -L "${DOWNLOAD_URL}" |
	tar xJvf - -C "${PWD}/downloaded_artifacts"
