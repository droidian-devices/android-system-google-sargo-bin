#!/bin/bash -x

set -e

source ./download.conf

info() {
	echo "I: $@"
}

warning() {
	echo "W: $@" >&2
}

error() {
	echo "E: $@" >&2
	exit 1
}

tmpdir="$(mktemp -d)"
cleanup() {
	rm -rf "${tmpdir}"
}
trap cleanup EXIT

rm -rf downloaded_artifacts
mkdir -p downloaded_artifacts

if [[ "${DOWNLOAD_URL}" == *.tar.xz ]]; then
	info "Selected download url is a .tar.xz archive"
	curl -L "${DOWNLOAD_URL}" |
		tar xJvf - -C "${PWD}/downloaded_artifacts"

	find ${PWD}/downloaded_artifacts -iname \*.img -exec mv \{} ${PWD}/downloaded_artifacts/android-rootfs.img \; -quit
elif [[ "${DOWNLOAD_URL}" == *.img ]]; then
	info "Selected download url is an .img file"
	curl -L "${DOWNLOAD_URL}" > "${PWD}/downloaded_artifacts/android-rootfs.img"
fi

if [ -n "${SIGNATURE_DOWNLOAD_URL}" ]; then
	info "Downloading signature"

	curl -L "${SIGNATURE_DOWNLOAD_URL}" > "${PWD}/downloaded_artifacts/android-rootfs.img.asc"

	# Import keys
	for key in ${PWD}/keys/*; do
		info "Importing key ${key}"
		gpg --homedir "${tmpdir}" --import ${key}
	done

	info "Verifying signature"
	gpg --homedir "${tmpdir}" --verify "${PWD}/downloaded_artifacts/android-rootfs.img.asc" ||
		error "Unable to verify signature"
fi
