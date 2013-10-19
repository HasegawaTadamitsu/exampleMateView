#!/bin/sh
. ./oracle.env

 
ruby 05addTestData.rb  > ./data/add.sql

exec_sql <<EOF 

@./data/add.sql

EOF

