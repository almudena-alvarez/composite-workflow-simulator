#!/bin/bash

echo "master"
echo $master


# printf -v psql_array "'%s'," "${master[@]//\'/\'\'}"
# psql_array=${psql_array%,}

# echo "psql_array"
# echo $psql_array

# IFS=',' read -r -a array <<< "$master"
# echo $array
# printf -v psql_array "'%s'," "${array[@]//\'/\'\'}"
# psql_array=${psql_array%,}

# echo $psql_array

jeje=($(psql -h postgres -d postgres_db -U postgres_user -AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = 'esq_oasis' AND tablename NOT IN  ('first')"));
echo "printing jjee"
echo $jeje


for z in "${jeje[@]}"
    do
    : 
    echo "ejej in looop"
    echo "$z"
done;

IFS=' ' read -r -a arrayjeje <<< "$jeje"
echo "jejejejejejejejeje"
echo $arrayjeje

for z in "${arrayjeje[@]}"
    do
    : 
    echo "arrayjeje in looop"
    echo "$z"
done;

bis=`psql -h postgres -d postgres_db -U postgres_user -AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = 'esq_oasis' AND tablename NOT IN  ('second')"`

echo "bis"
echo $bis

IFS=' ' read -r -a arraybis <<< "$bis"
echo "arraybis"
echo $arraybis

for z in "${arraybis[@]}"
    do
    : 
    echo "arraybis in looop"
    echo "$z"
done;

echo "not in loop anymore"
# read -r -a psarray <<< $bis

bis=`psql -h postgres -d postgres_db -U postgres_user -AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = 'esq_oasis' AND tablename NOT IN  ('third')"`

echo "bis"
echo $bis

IFS=' ' read -r -a arraybis <<< "$bis"
echo "arraybis"
echo $arraybis

for z in "${arraybis[@]}"
    do
    : 
    echo "arraybis in looop"
    echo "$z"
done;

echo "not in loop anymore"



# var=$(`psql -h postgres -d postgres_db -U postgres_user -AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = 'esq_oasis'"`);


# echo "var"
# echo $var

# for z in "${psarray[@]}"
#     do
#     : 
#     echo "bis"
#     echo "$z"
# #     clean=$(echo "$z" | tr -d '\r')
# #     schema_table=$original_schema.$clean
# #     echo "schema_table"
# #     echo $schema_table
# #     execute_truncate $schema_table
# done;

# for z in "${var[@]}"
#     do
#     : 
#     echo "var"
#     echo "$z"
# #     clean=$(echo "$z" | tr -d '\r')
# #     schema_table=$original_schema.$clean
# #     echo "schema_table"
# #     echo $schema_table
# #     execute_truncate $schema_table
# done;
