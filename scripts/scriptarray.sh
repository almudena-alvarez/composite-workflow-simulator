#!/bin/bash


function input_parameters() {

echo "holiff"
  local p_alm_users=""

while [[ $# -gt 0 ]]; do
      case "$1" in
          -u|--users)
              if [[ $# == 1 ]]; then
                >&2 echo "ERROR: No users specified"
                exit 1
              fi
              p_alm_users="${2}"
              shift 2
              ;;
          
          --)
              shift
              break
              ;;
          -*)
              >&2 echo "ERROR: Unexpected option '${1}'"
              exit 1
              ;;
          *)
              break
              ;;
      esac
  done


  alm_user="${p_alm_users:-${INPUT_ALM_USERS?"No ALM user defined"}}"



  # echo "Creating ${target_schema} from ${source_schema} using SQL DMLs from ${script_dir}..."
}


input_parameters "$@"

echo "alm_user:"
echo $alm_user

echo "holi"
