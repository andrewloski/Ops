--登录
mysql
--带密码登录
mysql -u root -h 127.0.0.1 -p password
--查询当前用户
select user();
--显示所有数据库
show databases;
--切换数据库
use mysql;
--显示所有数据表
show tables;
--查看表结构
describe user;
--查询
select * from user;
--建库
create database aaa;
--建表
create table students(
    name varchar(60),
    course varchar(120),
    score int(3)
    );
--插入数据
insert into students (name, course, score) values ('ada', 'math', 86);
--查询
select * from students;
--查询出每门课程的成绩都大于80的学生姓名
select distinct name from students where name not in (select name from students where score <= 80);
--备份
mysqldump -u root -ppasswd dbname >/home/dbname.sql     	 --备份库
mysqldump -u root -ppasswd dbname tablename>/home/tablename.sql  --备份表
mysqldump -u root -ppasswd --all-databases >/home/full.sql    	 --备份全库
--配置主从复制
--修改主服务器配置文件
vim /etc/my.cnf
[mysqld]
innodb_file_per_table=NO
log-bin=/var/lib/mysql/master-bin
binlog_format=mixed
server-id=130
--如果指定需要同步的数据库添加以下参数
replicate-do-db=dbname
--如果是双主模型需要解决自动增长列的问题
auto_increment_increment=2        #自动增长的步长
auto_increment_offset=1           #自动增长的起始数值
--修改从服务器配置文件
[mysqld]
innodb_file_per_table=NO
server-id=131
relay-log=/var/lib/mysql/relay-bin
--如果设置log_slave_updates，slave可以是其它slave的master，从而扩散master的更新
log_slave_updates=on
--如果是双主模型需要解决自动增长列的问题
auto_increment_increment=2        #自动增长的步长
auto_increment_offset=2	          #自动增长的起始数值
--按表复制
replicate_wild_do_table=table_name.%
--重启mariadb
systemctl restart mariadb
--登录主服务器
mysql -u root -padmin
--创建帐号并赋予replication的权限
GRANT REPLICATION SLAVE ON *.* TO 'root'@'172.16.123.131' IDENTIFIED BY 'admin';
--查看主库状态
show master status;
+-------------------+----------+--------------+------------------+
| File              | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+-------------------+----------+--------------+------------------+
| master-bin.000001 |      395 |              |                  |
+-------------------+----------+--------------+------------------+
--防火墙打开数据库连接端口
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --reload
--备份主数据库数据，用于导入到从数据库中
--加锁
FLUSH TABLES WITH READ LOCK;
--备份主库
mysqldump -uroot -ppasswd --all-databases > /root/db.sql
--按库导出
mysqldump -uroot -ppasswd database_name >database_name.sql
--解锁主库
UNLOCK TABLES;
--导入主库数据到从库
mysql -uroot -p < db.sql
--按库导入
create database database_name;
use database_name;
source database_name.sql;
--登录
mysql -u root -padmin
--设置主从复制
change master to master_host='172.16.123.130',master_user='root',master_password='admin',master_log_file='master-bin.000002',master_log_pos= 245;
--开启主从复制
START SLAVE;
--查看从库状态
show slave status\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 172.16.123.130
                  Master_User: root
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: master-bin.000011
          Read_Master_Log_Pos: 465
               Relay_Log_File: relay-bin.000014
                Relay_Log_Pos: 750
        Relay_Master_Log_File: master-bin.000011
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 465
              Relay_Log_Space: 1323
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 130
1 row in set (0.00 sec)

--解决mysql无法连接的问题
ERROR 1524 (HY000): Plugin 'unix_socket' is not loaded
--进入安全模式，并设置为后台进程
/usr/bin/mysqld_safe --skip-grant-tables &
--解决报错：mysqld_safe Directory '/var/run/mysqld' for UNIX socket file don't exists.
mkdir -p /var/run/mysqld
chown mysql:mysql /var/run/mysqld
--进入安全模式，并设置为后台进程
/usr/bin/mysqld_safe --skip-grant-tables &
--root登录
mysql -u root
--查询用户
select Host,User,plugin from mysql.user where User='root';
+-----------+------+-------------+
| Host      | User | plugin      |
+-----------+------+-------------+
| localhost | root | unix_socket |
+-----------+------+-------------+
--重置加密模式
update mysql.user set plugin='mysql_native_password' where User='root';
--查询用户
select Host,User,plugin from mysql.user where User='root';
+-----------+------+-----------------------+
| Host      | User | plugin                |
+-----------+------+-----------------------+
| localhost | root | mysql_native_password |
+-----------+------+-----------------------+
--重置密码
update mysql.user set password=PASSWORD("newpassword") where User='root';
--刷新权限信息
flush privileges;
--退出
exit
--杀掉mysql进程
kill -9 $(pgrep mysql)
--重新启动mysql服务
service mysql start
--登陆mysql
mysql -u root -p
--安装unix_soket
install plugin unix_socket soname 'auth_socket';
--无法安装放弃unix_socket认证方式

--负载均衡
haproxy+keepalived
--安装
yum install keepalived
--创建haproxy账号并授权
mysql
grant all on *.* to 'haproxy'@'192.168.217.%' identified by 'password';
--刷新权限
flush privileges;
--主机名互相解析
vi /etc/hosts
192.168.217.129 haproxy-01
192.168.217.134 haproxy-02
192.168.217.135 haproxy-03
--主机互信
ssh-keygen -t rsa -P ''
ssh-copy-id haproxy-02
ssh-copy-id haproxy-03
--验证互信
ssh haproxy-02
ssh haproxy-03
--安装时间同步工具并同步时间
yum install ntp
ntpdate s2c.time.edu.cn
--安装 haproxy+keepalived
yum install keepalived haproxy -y
haproxy -v
keepalived -v
--配置 haproxy
vi /etc/haproxy/haproxy.cfg
defaults
    mode                    http
    log                     global
    option                  tcplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

listen mysql
    bind :3306
    mode   tcp
    option tcpka
    balance     roundrobin
    server mysql_01 192.168.217.129:3306 check inter 3000 rise 1 maxconn 4000 fall 3
    server mysql_02 192.168.217.134:3306 check inter 3000 rise 1 maxconn 4000 fall 3

listen state
    bind :8080
    mode http

    stats enable
    stats hide-version
    stats uri /haproxyadmin?stats
    stats auth admin:admin
    stats admin if TRUE
    acl num1 src 192.168.0.0/16
    tcp-request content accept if num1
    tcp-request content reject

--打开ipv4非本地绑定，非必需
echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind
sysctl -p
--修改SELinux布尔值为haproxy放行,否则无法绑定3306端口
setsebool -P haproxy_connect_any=1
getsebool -a | grep haproxy
haproxy_connect_any --> on
--启动haproxy
systemctl start haproxy
systemctl status haproxy
--验证负载均衡
mysql -uhaproxy -ppassword -h 192.168.217.135
show slave status \G
exit
mysql -uhaproxy -ppassword -h 192.168.217.135
show slave status \G
exit


