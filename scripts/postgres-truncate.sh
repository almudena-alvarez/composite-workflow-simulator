#!/bin/bash

workflow_scripts="/__w/composite-workflow-simulator/composite-workflow-simulator/workflow/scripts"

function input_parameters() {
  local p_original_schema=""
  local p_target_database=""
  local p_pgsslmode=""
  local p_target_password=""
  local p_target_host=""
  local p_target_username=""
  local p_karateDataFile=""
  local p_master_tables=""


  while [[ $# -gt 0 ]]; do
      case "$1" in
          -s|--schema)
              if [[ $# == 1 ]]; then
                >&2 echo "ERROR: No source schema specified"
                exit 1
              fi
              p_original_schema="${2}"
              echo $p_original_schema
              shift 2
              ;;
          -d|--dbase)
              if [[ $# == 1 ]]; then
                >&2 echo "ERROR: No target database specified"
                exit 1
              fi
              p_target_database="${2}"
              shift 2
              ;;
          -ssl|--sslmode)
              if [[ $# == 1 ]]; then
                >&2 echo "ERROR: No pgsslmode specified"
                exit 1
              fi
              p_pgsslmode="${2}"
              shift 2
              ;;
          -p|--pass)
              if [[ $# == 1 ]]; then
                >&2 echo "ERROR: No postgres password specified"
                exit 1
              fi
              p_target_password="${2}"
              shift 2
              ;;
          -h|--host)
              if [[ $# == 1 ]]; then
                >&2 echo "ERROR: No host specified"
                exit 1
              fi
              p_target_host="${2}"
              shift 2
              ;;

          -u|--user)
              if [[ $# == 1 ]]; then
                >&2 echo "ERROR: No username specified"
                exit 1
              fi
              p_target_username="${2}"
              shift 2
              ;;

          -k|--karatedata)
              if [[ $# == 1 ]]; then
                >&2 echo "ERROR: No karate data specified"
                exit 1
              fi
              p_karateDataFile="${2}"
              shift 2
              ;;

          -m|--master)
              if [[ $# == 1 ]]; then
                >&2 echo "ERROR: No master tables specified"
                exit 1
              fi
              p_master_tables="${2}"
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


  original_schema="${p_original_schema:-${INPUT_ORIGINAL_SCHEMA?"No source schema defined"}}"
  target_database="${p_target_database:-${INPUT_TARGET_DATABASE?"No target database defined"}}"
  pgsslmode="${p_pgsslmode:-${INPUT_PGSSLMODE?"No sslmode defined defined"}}"
  target_password="${p_target_password:-${INPUT_TARGET_PASSWORD?"No database password defined"}}"
  target_host="${p_target_host:-${INPUT_HOST?"No target host defined"}}"
  target_username="${p_target_username:-${INPUT_USERNAME?"No username defined"}}"
  karateDataFile="${p_karateDataFile:-${INPUT_KARATE_DATAFILE?"No karate datafile defined"}}"
  master_tables="${p_master_tables:-${INPUT_MASTER_TABLES?"No target schema defined"}}"

  if [[ $master_tables ]]; then
    readarray -td, tables <<<"$master_tables,"; unset 'tables[-1]'; declare -p tables;
      formatted_master_tables="";
      for table in "${tables[@]}"; do
        formatted_master_tables="${formatted_master_tables}${formatted_master_tables:+,}'${table}'"
      done
      echo "Formatted Master Tables: ${formatted_master_tables}"
  fi
}


function execute_truncate() {
        local truncated_table="${1}"
        shift
        echo "TRUNCATE TABLE "$truncated_table" CASCADE;" >> "$workflow_scripts"/truncate.sql
    }

function execute_ddl() {
        local script_name="${1}"
        shift
        PGSSLMODE="${pgsslmode}" PGPASSWORD="${target_password}" \
        psql -h ${target_host} \
        -U ${target_username} \
        -d ${target_database} \
        -f "$workflow_scripts"/"${script_name}" "$@"
}

input_parameters "$@"

copy_schema=$original_schema'_copy'
echo "copy_schema: " $copy_schema
echo "copy_schema=$copy_schema" >> $GITHUB_ENV

echo "alter $original_schema to $copy_schema and create karate $original_schema"
execute_ddl postgres-setup-new-table.sql \
-v original_schema=$original_schema \
-v copy_schema=$copy_schema \
-v target_username=$target_username

echo "add tables to karate $original_schema"
execute_ddl $karateDataFile \
-v original_schema=$original_schema

echo "clean truncate script"
> "$workflow_scripts"/truncate.sql

var=($(PGSSLMODE="${pgsslmode}" PGPASSWORD="${target_password}" psql \
-h ${target_host} \
-U ${target_username} \
-d ${target_database} \
-AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = '$original_schema' AND tablename NOT IN  ($formatted_master_tables)"));

echo "Tables to truncate: "
for z in "${var[@]}"
    do
    : 
    clean=$(echo "$z" | tr -d '\r')
    schema_table=$original_schema.$clean
    echo $schema_table
    execute_truncate $schema_table
done;

echo "Truncate script: "
cat "$workflow_scripts"/truncate.sql

echo "Executing Truncate script: "
execute_ddl truncate.sql;
 
echo "Number of rows per table: "
PGSSLMODE="${pgsslmode}" PGPASSWORD="${target_password}" psql -h ${target_host} -U ${target_username} -d ${target_database} -c '\dn'
PGSSLMODE="${pgsslmode}" PGPASSWORD="${target_password}" psql -h ${target_host} -U ${target_username} -d ${target_database} -c "SELECT count(*) FROM $original_schema.first"
PGSSLMODE="${pgsslmode}" PGPASSWORD="${target_password}" psql -h ${target_host} -U ${target_username} -d ${target_database} -c "SELECT count(*) FROM $original_schema.second"
PGSSLMODE="${pgsslmode}" PGPASSWORD="${target_password}" psql -h ${target_host} -U ${target_username} -d ${target_database} -c "SELECT count(*) FROM $original_schema.third"
