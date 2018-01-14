-------------------------------------------------------------------
--
--  File : create_context_plog_ctx.sql (SQLPlus script)
--
--  Description : creation of the context PLOG_CTX
-------------------------------------------------------------------
--
-- history : who                 created     comment
--     v1    Rustam Shakirov     14-JAN-18   creation
--                                     
-------------------------------------------------------------------
/*
 * Copyright (C) LOG4PLSQL project team. All rights reserved.
 *
 * This software is published under the terms of the The LOG4PLSQL 
 * Software License, a copy of which has been included with this
 * distribution in the LICENSE.txt file.  
 * see: <http://log4plsql.sourceforge.net>  */

create context plog_ctx using plog_gctx accessed globally;