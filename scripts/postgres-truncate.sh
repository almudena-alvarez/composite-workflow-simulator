#!/bin/bash

echo "master"
echo $master


var=($(psql -h postgres -d postgres_db -U postgres_user -AXqtc "SELECT tablename FROM pg_tables WHERE schemaname = 'esq_oasis' AND tablename NOT IN  ('first')"));

echo "loop"
for z in "${var[@]}"
    do
    : 
    echo "$z"
done;
