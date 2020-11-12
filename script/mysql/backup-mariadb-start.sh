#!/bin/bash

## 设置要备份的数据库名
backup_database_names=(test mysql)	

current=`date "+%Y-%m-%d %H:%M:%S"`
stamp_day=`date "+%Y%m%d"`
stamp_time=`date "+%H%M%S"`

echo "当前日期:$current, 日期:$stamp_day,时间:$stamp_time"


# echo "开始备份数据库"

exec_dir_root=$(pwd)
backup_dir_work=$(dirname $0)
backup_dir_sql="$backup_dir_work/$stamp_day/"
echo "backup work dir:$backup_dir_work"
echo "backup export sql file dir path:$backup_dir_sql"

if [ ! -d "$backup_dir_sql" ];then
echo "注意:创建SQL文件存放目录"
mkdir -p $backup_dir_sql
fi

for dbname in "${backup_database_names[@]}"
do
backup_file_sql="${backup_dir_sql}${stamp_day}-${dbname}.sql"
	echo "start backup $dbname export to $backup_file_sql"
	mysqldump -u root -p -h 127.0.0.1 ${dbname} > ${backup_file_sql}
	echo "end backup $dbname"
done

# mysqldump -u root -p -h 127.0.0.1 codework > dump-codework-20201112.sql
