CREATE DATABASE cmt_geoconciliacion_qageocom_20240109;
CREATE DATABASE cmt_geopos2server_qageocom_20240110;

CREATE USER 'user1'@'%' IDENTIFIED BY 'password1';
GRANT ALL PRIVILEGES ON database1.* TO 'user1'@'%';

CREATE USER 'user2'@'%' IDENTIFIED BY 'password2';
GRANT ALL PRIVILEGES ON database2.* TO 'user2'@'%';

FLUSH PRIVILEGES;