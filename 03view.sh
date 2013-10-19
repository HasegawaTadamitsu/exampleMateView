#!/bin/sh
 

. ./oracle.env


exec_sql <<EOF 


begin
   dbms_stats.flush_database_monitoring_info ;
end;
/



CREATE OR REPLACE FUNCTION GET_BIGDATA1
(
  P_ID IN NUMBER
)
RETURN NUMBER
IS
  TYPE tBigData1 IS TABLE OF BIGDATA1%ROWTYPE;
  TYPE tINX      IS TABLE OF INX%ROWTYPE;
  vBigdata1 tBigData1;
  vInx tInx;
BEGIN
  SELECT * BULK COLLECT INTO vBigdata1 FROM BIGDATA1 
  WHERE id = P_ID order by seq asc;
  FOR i IN REVERSE 0..(vBIGDATA1.COUNT) LOOP
    SELECT * BULK COLLECT INTO vInx FROM INX WHERE LIVEFLG = '1';
    IF vInx.COUNT != 0 THEN
       RETURN vBIGDATA1(i).SEQ;
    END IF;
    vInx.DELETE;
  END LOOP;
  vBigdata1.DELETE;
  RETURN 0;
END;
/



CREATE or REPLACE VIEW V_EX1 as
select distinct id, GET_BIGDATA1(id) as m_seq from bigdata1
WITH READ ONLY;


CREATE or REPLACE VIEW V_EX2 as
 select * from bigdata1 t1 where
 not exists
   ( select 'X' from bigdata2 t2 where t1.id = t2.id ) and 
   (t1.id, t1.seq) in ( select id,GET_BIGDATA1(id) from bigdata1 group by id)
WITH READ ONLY;


CREATE or REPLACE VIEW V_EX3 as
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
WITH READ ONLY;


set autotrace traceonly
select * from V_EX1 order by 1;
select * from V_EX2 order by 1;
select * from V_EX3 order by 1;



EOF