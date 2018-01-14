create or replace package body plog_gctx is

--*******************************************************************************
-- NAME: PLOG_GCTX (body)
--
-- DESCRIPTION: 
-- Context management package.
-- Created to manage the global context of the PLOG module.
-- Allows you to write and read the attribute value.
--
--------------------------------------------------------------------------------
-- See the history in the specification
--------------------------------------------------------------------------------
--******************************************************************************

procedure set_ctx(
  p_ns     varchar2 default C_PLOG_CTX
 ,p_atr    varchar2
 ,p_val    varchar2
 ,p_user   varchar2 default null
 ,p_client varchar2 default null
) is
begin
  dbms_session.set_context(namespace => p_ns
                          ,attribute => p_atr
                          ,value     => p_val
                          ,username  => p_user
                          ,client_id => p_client);
end;

function get_ctx(
  p_ns     varchar2 default C_PLOG_CTX
 ,p_atr    varchar2
) return varchar2 is
begin
  return sys_context(namespace => p_ns,attribute => p_atr);
end;

procedure clear_ctx(
  p_ns     varchar2 default C_PLOG_CTX
 ,p_client varchar2 default null
 ,p_atr    varchar2
) is
begin
  dbms_session.clear_context(namespace => p_ns
                            ,client_id => p_client
                            ,attribute => p_atr);
end;

procedure set_log_ctx(
  p_atr    varchar2
 ,p_val    varchar2
 ,p_user   varchar2 default null
 ,p_client varchar2 default null
) is
begin
  set_ctx(C_PLOG_CTX, p_atr, p_val, p_user, p_client);
end;

function get_log_ctx(
  p_atr    varchar2
) return varchar2 is
begin
  return get_ctx(C_PLOG_CTX, p_atr);
end;

procedure clear_log_ctx(
  p_client varchar2 default null
 ,p_atr    varchar2
) is
begin
  clear_ctx(C_PLOG_CTX, p_client, p_atr);
end;

end;
/