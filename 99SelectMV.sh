#!/bin/sh
 

. ./oracle.env


exec_sql <<EOF 


set autotrace traceonly
! date
select * from MV_EX3 order by 1;

EOF