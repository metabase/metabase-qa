FROM mcr.microsoft.com/mssql/server:2017-latest

ENV ACCEPT_EULA=Y SA_PASSWORD=Metasample123 MSSQL_PID=Standard

COPY dbs/mssql/data/sample_data.sql.gz /home/
RUN gzip -d /home/sample_data.sql.gz
RUN /opt/mssql/bin/sqlservr & /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Metasample123 -d master -i /home/sample_data.sql