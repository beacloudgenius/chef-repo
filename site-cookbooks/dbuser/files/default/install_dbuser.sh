#!/bin/sh
# This is a comment
mysql -t --user=root --password=123 <<STOP
-- This is a comment inside an sql-command-stream.

CREATE DATABASE IF NOT EXISTS wordpress;

SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ANSI';

USE wordpress ;

DROP PROCEDURE IF EXISTS wordpress.drop_user_if_exists ;

DELIMITER $$

CREATE PROCEDURE wordpress.drop_user_if_exists()
BEGIN
  DECLARE foo BIGINT DEFAULT 0 ;
  SELECT COUNT(*)
  INTO foo
    FROM mysql.user
      WHERE User = 'username' and  Host = 'localhost';
   IF foo > 0 THEN
         DROP USER 'username'@'localhost' ;
  END IF;
END ;$$
DELIMITER ;

CALL wordpress.drop_user_if_exists() ;

DROP PROCEDURE IF EXISTS wordpress.drop_users_if_exists ;

SET SQL_MODE=@OLD_SQL_MODE ;


CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
GRANT USAGE ON *.* to username@localhost identified by 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'username'@'localhost' WITH GRANT OPTION ;
FLUSH PRIVILEGES;
\q
STOP
test $? = 0 && echo "Your mysql batch job completed gracefully"
