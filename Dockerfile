FROM postgres

RUN apt-get update && apt-get install -y python3 python3-pip
RUN apt-get install -y python3.7-dev python
RUN apt-get install -y postgresql-server-dev-10 gcc python3-dev musl-dev
RUN apt-get install -y wget
RUN mkdir /manager
RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /
RUN chmod +x /wait-for-it.sh
RUN pip3 install psycopg2

USER postgres

COPY ./manager ./manager

EXPOSE 5432

ENTRYPOINT ["/wait-for-it.sh", "db:5432", "--"]
RUN python -m manager
