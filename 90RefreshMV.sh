#!/bin/sh
 

. ./oracle.env


exec_sql <<EOF 
set autotrace traceonly

select * from MV_EX3 order by 1;
exec dbms_mview.refresh('MV_EX3')
select * from MV_EX3 order by 1;

EOF