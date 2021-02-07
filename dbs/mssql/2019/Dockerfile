FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Y SA_PASSWORD=Metasample123 MSSQL_PID=Standard

COPY sample_data.sql.gz /home/
USER root
RUN gzip -d /home/sample_data.sql.gz
USER mssql
RUN /opt/mssql/bin/sqlservr & /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Metasample123 -d master -i /home/sample_data.sql