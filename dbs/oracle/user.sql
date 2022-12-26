create user metabase identified externally as 'CN=metabase,C=US';
grant all privileges to metabase container = all;
grant select on dba_users to metabase container = all;
