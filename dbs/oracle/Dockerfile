FROM gvenzl/oracle-xe:21.3.0-slim

COPY --chown=oracle:dba listener.ora sqlnet.ora /opt/oracle/homes/OraDBHome21cXE/network/admin/
COPY --chown=oracle:dba server /opt/oracle/server
COPY --chown=oracle:dba user.sql /container-entrypoint-initdb.d/
