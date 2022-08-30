#!/usr/bin/env bash

set -euo pipefail

exec {output}> ./output.sh
temp_dir=$(mktemp -d /tmp/tmp.XXX)

if [[ ! -d "${temp_dir}" ]]; then
    echo "[ERROR]: Error creating temporal directory" >&2;
    exit 1
fi

echo "${temp_dir}" >${output}

echo $(pwd)

# echo "::set-output name=temp_dir::${temp_dir}"

