#!/bin/bash

MYSQL=`which mysql`
APP_DATABASE=$APP_DATABASE
APP_PASSWORD=$APP_PASSWORD
APP_USER=$APP_USER

/usr/bin/mysqld_safe &
WAIT_TIME=0
while ! mysqladmin ping -h127.0.0.1 --silent; do
	sleep 1
done
mysql -uroot -p$MYSQL_ROOT_PASS -e "create database $APP_DATABASE"
mysql -uroot -p$MYSQL_ROOT_PASS -e "GRANT ALL PRIVILEGES ON $APP_DATABASE.* To \"$APP_USER\"@'localhost' IDENTIFIED BY \"$APP_PASSWORD\"";
mysql -uroot -p$MYSQL_ROOT_PASS -e "GRANT ALL PRIVILEGES ON $APP_DATABASE.* To \"$APP_USER\"@'%' IDENTIFIED BY \"$APP_PASSWORD\"";
mysql -uroot -p$MYSQL_ROOT_PASS -e "FLUSH PRIVILEGES";
mysql -uroot -p$MYSQL_ROOT_PASS -e "set GLOBAL storage_engine='InnoDb'";
