#!/bin/sh
 

. ./oracle.env


exec_sql <<EOF 





DROP materialized view   MV_EX3;

! date

CREATE  MATERIALIZED VIEW  MV_EX3
 as
select * from bigdata1 t1
where
(t1.id,t1.seq) in  (
select t1.id, max(t1.seq) from bigdata1 t1 where
  (exists
    (select 'X' from inx t2 where 
      ( t1.inx = t2.inx and t2.liveflg ='1')
      or 
      ( t1.inx = 0)
    )
  )
group by t1.id
)
and
(not exists (select 'X' from bigdata2 t2 where t1.id = t2.id))
;

! date
alter materialized view mv_ex3 refresh complete;

! date

EOF