-------------------------------------------------------------------
--
--  Nom script         : Workload.sql
--
--  Objectif           : performance test
-------------------------------------------------------------------
--
-- History : who                 created     comment
--     V1    Guillaume Moulard   11-Jui-02   Creation
--     V2    Bertrand Caradec    06-JUN-08   new function names, queue test                                
--     V2    Rustam Shakirov     14-JAN-18   new tests: workload_default_notrace
--                                                      workload_default_notrace_bp
--                                                      workload_default_trace_tlog
--
-------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE workload_notrace IS
--------------------------------------------------- 
-- This function calls 100 000 times the info log function.
-- NO trace is written because the limit log level is set to WARNING.
--------------------------------------------------- 

vctx PLOGPARAM.LOG_CTX;
 counter PLS_INTEGER;
BEGIN  
  vctx := PLOG.INIT(NULL, PLOG.LWARN);

  FOR counter IN 1 .. 100000 LOOP     
    PLOG.INFO(vctx, 'debug test');
  END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE workload_trace_in_tlog IS
--------------------------------------------------- 
-- This function calls 100 000 times the info log function.
-- Trace are written in the table TLOG
--------------------------------------------------- 

  vctx PLOGPARAM.LOG_CTX;
  counter PLS_INTEGER;

BEGIN
  vctx := PLOG.INIT(NULL, PLOG.LDEBUG);
  
  FOR counter IN 1 .. 100000 LOOP
     PLOG.INFO(vctx, 'debug test');
  END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE workload_trace_in_tlog_queue IS
--------------------------------------------------- 
-- This function calls 100 000 times the info log function.
-- Trace are written in the table TLOG and in the queue (read for the Java background process)
---------------------------------------------------    
   vctx PLOGPARAM.LOG_CTX;
   counter PLS_INTEGER;
BEGIN
  vctx := PLOG.INIT(NULL, PLOG.LDEBUG, TRUE);
  FOR counter IN 1 .. 100000 LOOP
     PLOG.INFO(vctx, 'debug test');  
  END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE workload_trace_in_queue IS
--------------------------------------------------- 
-- This function calls 100 000 times the info log function.
-- Trace are written in the queue only(read for the Java background process)
---------------------------------------------------     

vctx PLOGPARAM.LOG_CTX;
  counter PLS_INTEGER;
BEGIN
  vctx := PLOG.INIT(NULL, PLOG.LDEBUG, TRUE, FALSE);

  FOR counter IN 1 .. 100000 LOOP
     PLOG.INFO(vctx, 'debug test');
  END LOOP;
END;
/

create or replace procedure workload_default_notrace is
---------------------------------------------------
-- This function calls 100 000 times the info log function.
-- NO trace is written because the limit log level is set to ERROR.
---------------------------------------------------
  l_cnt   number := 100000;
  l_start number;
  l_total number;
begin
  l_start := dbms_utility.get_time;
  for i in 1 .. l_cnt loop
    plog.debug('never insert');
  end loop;
  l_total := dbms_utility.get_time - l_start;
  dbms_output.put_line('Elapsed time (sec): '||l_total/100);
end;
/

create or replace procedure workload_default_notrace_bp is
---------------------------------------------------
-- This function calls 100 000 times the info log function.
-- NO trace is written because the limit log level is set to ERROR.
-- User Guide: "The best practice to code it is to make a test before logging with IsEnabled function".
---------------------------------------------------
  l_cnt   number := 100000;
  l_start number;
  l_total number;
begin
  l_start := dbms_utility.get_time;
  for i in 1 .. l_cnt loop
    if plog.isDebugEnabled then
      plog.debug('never insert');
    end if;
  end loop;
  l_total := dbms_utility.get_time - l_start;
  dbms_output.put_line('Elapsed time (sec): '||l_total/100);
end;
/

create or replace procedure workload_default_trace_tlog is
---------------------------------------------------
-- This function calls 100 000 times the info log function.
-- Trace are written in the table TLOG. Log level is set to ALL.
---------------------------------------------------
  l_cnt   number := 100000;
  l_start number;
  l_total number;
begin
  l_start := dbms_utility.get_time;
  for i in 1 .. l_cnt loop
    plog.debug('trace');
  end loop;
  l_total := dbms_utility.get_time - l_start;
  dbms_output.put_line('Elapsed time (sec): '||l_total/100);
end;
/