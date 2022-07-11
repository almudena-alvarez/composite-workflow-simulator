#!/usr/bin/env bash

echo "master"
echo $master


printf -v psql_array "'%s'," "${master[@]//\'/\'\'}"
psql_array=${psql_array%,}

echo "psql_array"
echo $psql_array

var=($( psql -U postgres -AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = 'esq_oasis' AND tablename NOT IN  ($psql_array)"));

echo "var"
echo $var

for z in "${var[@]}"
    do
    : 
    clean=$(echo "$z" | tr -d '\r')
    schema_table=$original_schema.$clean
    echo "schema_table"
    echo $schema_table
    execute_truncate $schema_table
done;
