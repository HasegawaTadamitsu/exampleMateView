#!/bin/sh
 

. ./oracle.env


exec_sql <<EOF 

set autotrace on

select count(*) from bigData1;
select count(*) from bigData1 where seq = 0;
select count(*) from bigData1 where seq = 1;

select count(distinct id) from bigData1;

select count(*) from inx;
select count(*) from inx where liveFlg ='1';

select count(*) from bigData2;
select count(*) from bigData2 where delFlg != '1';



select count(*) from V_EX1 order by 1;
select count(*) from V_EX2 order by 1;
select count(*) from V_EX3 order by 1;

select count(*) from MV_EX3 order by 1;



EOF