#!/usr/bin/env bash

set -euo pipefail

if [[ -z ${INPUT_FILE_TYPE} ]]; then
    temp_file=$(mktemp -p "${INPUT_TEMP_DIR}" ".${INPUT_NAME}.XXXXX")
else
    temp_file=$(mktemp -p "${INPUT_TEMP_DIR}" --suffix ".${INPUT_FILE_TYPE}" ".truncate.XXXXX")
fi

if [[ ! -f "${temp_file}" ]]; then
    echo "[ERROR]: Error creating temporal file" >&2;
    exit 1
fi

echo "[INFO]: Temporal file ${temp_file} created successfully" 
echo "::set-output name=temp_file::${temp_file}"