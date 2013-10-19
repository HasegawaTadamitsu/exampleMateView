#!/bin/sh
. ./oracle.env

 
ruby 02createTestData.rb  > ./data/insert.sql

exec_sql <<EOF 
truncate table bigdata1;
truncate table inx;
truncate table bigdata2;

@./data/insert.sql

EOF

