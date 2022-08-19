#!/usr/bin/env bash

set -euo pipefail

temp_dir=$(mktemp -d /tmp/tmp.XXX)

if [[ ! -d "${temp_dir}" ]]; then
    echo "[ERROR]: Error creating temporal directory" >&2;
    exit 1
fi

echo "[INFO] Temporary directory created: '${temp_dir}'"

echo "::set-output name=temp_dir::${temp_dir}"

