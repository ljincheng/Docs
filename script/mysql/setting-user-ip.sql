update mysql.user set host='%' where user='dev';
update mysql.db set host='%' where user='dev';
update mysql.tables_priv set host='%' where user='dev';
flush privileges;
