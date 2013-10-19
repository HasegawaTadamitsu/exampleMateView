#!/bin/sh
 

. ./oracle.env


exec_sql <<EOF 
set autotrace traceonly
! date
select * from MV_EX3 order by 1;
! date

exec dbms_mview.refresh('MV_EX3')


! date
select * from MV_EX3 order by 1;
! date


EOF