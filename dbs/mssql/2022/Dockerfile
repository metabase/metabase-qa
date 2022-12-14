FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA=Y MSSQL_SA_PASSWORD=Metasample123! MSSQL_PID=Developer

COPY dbs/mssql/data/sample_data.sql.gz /home/
USER root
RUN gzip -d /home/sample_data.sql.gz
USER mssql
RUN /opt/mssql/bin/sqlservr & /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Metasample123! -d master -i /home/sample_data.sql