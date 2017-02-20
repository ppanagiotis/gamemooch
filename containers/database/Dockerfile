# vim:set ft=dockerfile:
FROM debian:stretch

# Install system dependencies
RUN apt-get -qq update --fix-missing

ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_ROOT_PASS gamemooch
ENV APP_DATABASE gamemooch
ENV APP_PASSWORD gamemooch
ENV APP_USER gamemooch

RUN bash -c '/usr/bin/debconf-set-selections <<< "mariadb-server mysql-server/root_password password $MYSQL_ROOT_PASS"'
RUN bash -c '/usr/bin/debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $MYSQL_ROOT_PASS"'

RUN apt-get -y install mariadb-server

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i -e"s/utf8mb4/utf8/g" /etc/mysql/mariadb.conf.d/50-server.cnf

ADD ./mysql.sh /opt/mysql.sh
RUN chmod 755 /opt/mysql.sh
RUN /opt/mysql.sh

EXPOSE 3306

CMD ["/usr/sbin/mysqld"]
