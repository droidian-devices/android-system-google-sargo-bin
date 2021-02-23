#!/bin/bash -x

set -e

CI_JOB_ID="16"
ARCH="arm64"

DOWNLOAD_URL="https://ci.ubports.com/job/Device%20Compatibility%20Images/job/halium-generic_${ARCH}/${CI_JOB_ID}/artifact/halium_halium_${ARCH}.tar.xz"

rm -rf downloaded_artifacts
mkdir -p downloaded_artifacts

curl -L "${DOWNLOAD_URL}" |
	tar xJvf - -C "${PWD}/downloaded_artifacts"
