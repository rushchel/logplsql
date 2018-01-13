set verify off

ACCEPT V_USER CHAR PROMPT 'Enter the user name:'

GRANT EXECUTE ON &V_USER..PLOG_OUT_AQ TO PUBLIC;
GRANT EXECUTE ON &V_USER..PLOGPARAM TO PUBLIC;
GRANT EXECUTE ON &V_USER..PLOG TO PUBLIC;

create public synonym plog_out_aq for &V_USER..plog_out_aq;
create public synonym plogparam for &V_USER..plogparam;
create public synonym plog for &V_USER..plog;
create public synonym tlog for &V_USER..tlog;
create public synonym vlog for &V_USER..vlog;

set verify on


