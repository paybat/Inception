#!/bin/bash

set -e

mysqld_safe --skip-grant-tables &

while ! mysqladmin  ping --silent; do
    sleep 1 
done;

mariadb -u root <<SQL
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOTPASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${DATABASENAME}\`;
CREATE USER IF NOT EXISTS '${DATABASEUSER}'@'%' IDENTIFIED BY '${USERPASSWORD}';
GRANT ALL PRIVILEGES ON \`${DATABASENAME}\`.* TO '${DATABASEUSER}'@'%';
FLUSH PRIVILEGES;
SQL

mysqladmin -u root -p"${ROOTPASSWORD}" shutdown


exec mysqld_safe --bind-address=0.0.0.0

