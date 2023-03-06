ARG tag=latest
FROM mcr.microsoft.com/mssql/server:${tag}-latest

ENV ACCEPT_EULA=Y MSSQL_SA_PASSWORD=Metasample123! MSSQL_PID=Developer

COPY dbs/mssql/data/sample_data.sql.gz /home/
RUN gzip -d /home/sample_data.sql.gz
RUN /opt/mssql/bin/sqlservr & /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Metasample123! -d master -i /home/sample_data.sql