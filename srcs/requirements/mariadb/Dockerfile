FROM alpine:3.19

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-common

RUN mkdir -p /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/init.sql /init.sql

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

RUN mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking --socket=/run/mysqld/mysqld.sock & \
    sleep 5 && \
    mysql --protocol=socket -u root < /init.sql && \
    killall mysqld

EXPOSE 3306

USER mysql

CMD ["mysqld", "--datadir=/var/lib/mysql"]
