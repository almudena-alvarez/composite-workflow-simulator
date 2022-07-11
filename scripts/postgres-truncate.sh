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


  # echo "Creating ${target_schema} from ${source_schema} using SQL DMLs from ${script_dir}..."
}


function execute_truncate() {
        local truncated_table="${1}"
        shift
        echo "TRUNCATE TABLE "$truncated_table" CASCADE;" >> "$workflow_scripts"/truncate.sql
    }

function execute_ddl() {
        local script_name="${@}"
        shift
        PGSSLMODE="${pgsslmode}" PGPASSWORD="${target_password}" psql -h ${target_host} -U ${target_username} -d ${target_database} -f "$workflow_scripts"/"${script_name}"
}

input_parameters "$@"
copySchema=$original_schema'_copy'
IFS=',' read -r -a array <<< "$master"
echo $array
printf -v psql_array "'%s'," "${array[@]//\'/\'\'}"
psql_array=${psql_array%,}


echo "alter $original_schema to $copySchema and create karate $original_schema"
{
  echo "SET @original_schema='${original_schema}'; SET @copySchema='${copySchema}';";
  cat "$workflow_scripts"/postgres-setup-new-table.sql;
} | execute_ddl postgres-setup-new-table.sql





echo "add tables to karate $original_schema"
execute_ddl $karateDataFile

echo "clean truncate script"
> "$workflow_scripts"/truncate.sql

echo "delete unneccessary data";
var=($(PGSSLMODE="${pgsslmode}" PGPASSWORD="${target_password}" psql -h ${target_host} -U ${target_username} -d ${target_database} -AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = '$original_schema' AND tablename NOT IN  ($psql_array)"));

for z in "${var[@]}"
    do
    : 
    clean=$(echo "$z" | tr -d '\r')
    schema_table=$original_schema.$clean
    execute_truncate $schema_table
done;

#  execute_ddl -f "$workflow_scripts"/truncate.sql;

# echo "insert karate data"
# execute_ddl -f "$workflow_scripts"/$karateDataFile




# var=($(psql -h postgres -d postgres_db -U postgres_user -AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = 'esq_oasis' AND tablename NOT IN  ($psql_array)"));

# echo "loop"
# for z in "${var[@]}"
#     do
#     : 
#     echo "$z"
# done;
