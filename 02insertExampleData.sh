#!/bin/sh
. ./oracle.env

sure_and_exit "truncate and create testdata"
ruby 99CreateTestData.rb  1000 0 > ./data/insert.sql

exec_sql <<EOF 
truncate table bigdata1;
truncate table inx;
truncate table bigdata2;

@./data/insert.sql

EOF

