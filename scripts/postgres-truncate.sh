#!/bin/bash

echo "master"
echo $master


IFS=',' read -r -a array <<< "$master"
echo $array
printf -v psql_array "'%s'," "${array[@]//\'/\'\'}"
psql_array=${psql_array%,}


var=($(psql -h postgres -d postgres_db -U postgres_user -AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = 'esq_oasis' AND tablename NOT IN  ($psql_array)"));

echo "loop"
for z in "${var[@]}"
    do
    : 
    echo "$z"
done;
