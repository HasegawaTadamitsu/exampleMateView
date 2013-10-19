#!/bin/sh
. ./oracle.env

ruby 99CreateTestData.rb 100 10000000 > ./data/add.sql

exec_sql <<EOF 

@./data/add.sql

EOF

