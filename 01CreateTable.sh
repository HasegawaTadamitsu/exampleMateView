#!/bin/sh

. ./oracle.env


exec_sql <<EOF 

DROP TABLE bigData1 CASCADE CONSTRAINTS ;
create table bigdata1
(
  id number,
  seq number,
  inx number,
  value char(100)
) tablespace my01
;

DROP TABLE inx CASCADE CONSTRAINTS ;
create table inx
(
  inx number,
  liveFlg char(1)
) tablespace my01
;

DROP TABLE bigData2 CASCADE CONSTRAINTS;
create table bigdata2
(
  id number,
  delFlg char(1),
  value char(100)
) tablespace my01
;

alter table bigData1
  add constraint bigdata1_pk1 primary key(id,seq);

alter table bigData2
  add constraint bigdata2_pk1 primary key(id);




show recyclebin
purge recyclebin;
show recyclebin

desc bigdata1
desc inx
desc bigdata2

quit
EOF

exit



memo

analyze index pk validate structure;
select * from index_stats where name ='PK';


delete bigData where id < 999;

analyze index pk validate structure;
select * from index_stats where name ='PK';



