create or replace package plog_gctx is

--******************************************************************************
-- NAME: PLOG_GCTX (specification)
--
-- DESCRIPTION: 
-- Context management package.
-- Created to manage the global context of the PLOG module.
-- Allows you to write and read the attribute value.
--
-- HISTORY:
-- 13.01.2018  Rustam Shakirov       Created
--******************************************************************************

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

-- Global context name for the PLOG module
C_PLOG_CTX constant varchar2(30) := 'plog_ctx';

-- Set the value of the context attribute
-- @param p_ns      The name of the context (namespace)
-- @param p_atr     The name of the attribute
-- @param p_val     Value
-- @param p_user    User
-- @param p_client  Client ID
procedure set_ctx(
  p_ns     varchar2 default C_PLOG_CTX
 ,p_atr    varchar2
 ,p_val    varchar2
 ,p_user   varchar2 default null
 ,p_client varchar2 default null
);

-- Get the value of the context attribute. Returns text value
-- @param p_ns      The name of the context (namespace)
-- @param p_atr     The name of the attribute
function get_ctx(
  p_ns     varchar2 default C_PLOG_CTX
 ,p_atr    varchar2
) return varchar2;

-- Clear the value of the context attribute
-- @param p_ns      The name of the context (namespace)
-- @param p_client  Client ID
-- @param p_atr     The name of the attribute
procedure clear_ctx(
  p_ns     varchar2 default C_PLOG_CTX
 ,p_client varchar2 default null
 ,p_atr    varchar2
);

-- Set the value of the context attribute of the PLOG module
-- @param p_atr     The name of the attribute
-- @param p_val     Value
-- @param p_user    User
-- @param p_client  Client ID
procedure set_log_ctx(
  p_atr    varchar2
 ,p_val    varchar2
 ,p_user   varchar2 default null
 ,p_client varchar2 default null
);

-- Get the value of the context attribute of the PLOG module. Returns text value
-- @param p_atr     The name of the attribute
function get_log_ctx(
  p_atr    varchar2
) return varchar2;

-- Clear the value of the context attribute of the PLOG module
-- @param p_client  Client ID
-- @param p_atr     The name of the attribute
procedure clear_log_ctx(
  p_client varchar2 default null
 ,p_atr    varchar2
);

end;
/