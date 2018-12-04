#!/bin/bash
# 上传下载文件 
yum install lrzsz
# 上传
rz 
# 下载
sz 
# 编写shell脚本循环创建100个用户（user_[0-99])
#!/bin/bash
for((i = 0; i < 100; i++));
do
useradd user_$i;
done
# 统计shell.sh文件的行数
wc -l shell.sh
# 查看版本信息
uname -a
cat /proc/version
lsb_release -a
ls /boot
# 统计cpu占用前十的进程
ps aux | sort -k3 | head -10
# 查看物理CPU个数
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l
# 查看每个物理CPU中core的个数(即核数)
cat /proc/cpuinfo| grep "cpu cores"| uniq
# 查看逻辑CPU的个数
cat /proc/cpuinfo| grep "processor"| wc -l
# 查看CPU型号
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
# 查看内存条数
dmidecode | grep -A16 "Memory Device$"
# 内存使用情况
free -h
# 将所有正在内存中的缓冲区写到磁盘中
sync
# 释放页缓存
echo 1 > /proc/sys/vm/drop_caches
# 释放dentries和inodes
echo 2 > /proc/sys/vm/drop_caches
# 释放所有缓存
echo 3 > /proc/sys/vm/drop_caches
# 让操作系统重新分配内存
echo 0 > /proc/sys/vm/drop_caches
# 开机启动mysql
chkconfig mysqld on
# centos7
systemctl enable mariadb
# 查看磁盘空间
df -h
# 压缩
tar -cvf file.tar path/dir
tar -czvf file.tar.gz path/dir
tar -cjvf file.tar.bz2 path/dir
# 解压
tar -xvf file.tar
tar -xzvf file.tar.gz
tar -xjvf file.tar.bz2
tar -xjvf file.tar.bz2 
tar -xjvf file.tar.bz2 -C dir
# 批量解压unzip
unzip "*.zip"
ls *.zip | xargs -n1 unzip
# 查看22端口现在运行的情况
lsof -i :22
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
ssh     4169 root    3u  IPv4 127672      0t0  TCP 172.16.123.1:52650->172.16.123.128:ssh (ESTABLISHED)
ssh     4172 root    3u  IPv4 130231      0t0  TCP 172.16.123.1:59818->172.16.123.129:ssh (ESTABLISHED)
# ss已淘汰netstatus
ss -s           #列出当前socket详细信息
ss -atr | wc    #统计连接数
ss -l           #显示所有打开的端口(监听状态)
ss -pl     #查看进程使用的sock
ss -lnp |grep 80    #根据端口找出进程
ss -t -a            #显示所有TCP socket
ss -o state established '( dport = :http or sport = :http )'  #显示所有已建立HTTP连接（established状态）
ss dst 192.168.0.81        #显示所有连接到远程服务器192.168.0.81的端口
ss src 192.168.0.103:ssh   #匹配本地地址和端口号
# 配置防火墙只允许远程主机访问本机的80端口
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/etc/rc.d/init.d/iptables save
/etc/init.d/iptables status
# centos7 firewall
1、firewalld的基本使用
启动： systemctl start firewalld
查看状态： systemctl status firewalld
停止： systemctl disable firewalld
禁用： systemctl stop firewalld

2.systemctl是CentOS7的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。
启动一个服务：systemctl start firewalld.service
关闭一个服务：systemctl stop firewalld.service
重启一个服务：systemctl restart firewalld.service
显示一个服务的状态：systemctl status firewalld.service
在开机时启用一个服务：systemctl enable firewalld.service
在开机时禁用一个服务：systemctl disable firewalld.service
查看服务是否开机启动：systemctl is-enabled firewalld.service
查看已启动的服务列表：systemctl list-unit-files|grep enabled
查看启动失败的服务列表：systemctl --failed

3.配置firewalld-cmd
查看版本： firewall-cmd --version
查看帮助： firewall-cmd --help
显示状态： firewall-cmd --state
查看所有打开的端口： firewall-cmd --zone=public --list-ports
更新防火墙规则： firewall-cmd --reload
查看区域信息:  firewall-cmd --get-active-zones
查看指定接口所属区域： firewall-cmd --get-zone-of-interface=eth0
拒绝所有包：firewall-cmd --panic-on
取消拒绝状态： firewall-cmd --panic-off
查看是否拒绝： firewall-cmd --query-panic
那怎么开启一个端口呢
添加
firewall-cmd --zone=public --add-port=80/tcp --permanent    （--permanent永久生效，没有此参数重启后失效）
重新载入
firewall-cmd --reload
查看
firewall-cmd --zone= public --query-port=80/tcp
删除
firewall-cmd --zone= public --remove-port=80/tcp --permanent

# 将/opt目录下包含'hellohhhhh'的文件替换成'hi'
sed -i 's/hellohhhhh/hi/g' `grep -rl 'hellohhhhh' /opt`
# 将shell.sh中/var/log 替换成/usr/local
sed -i 's/\/var\/log/\/usr\/local/g' shell.sh
# 在多个目录及子目录中替换多个字符串
sed -i 's/str1/str2/g;s/str3/str4/' `egrep -rl 'str1|str2' /opt /mnt`
# awk
awk 'BEGIN{for(i=1; i<=10; i++) print i}'
# kill某个用户的所有进程
pkill -u user
killall -u user
pgrep -u user | xargs kill -9
# xargs用法，将管道符前命令的所有结果依次作为xargs后命令的参数
ls | xargs ls
# 计划任务：分 时 日 月 周
crontab -l
crontab -e
vim /etc/crontab
# wget下载整个页面
wget -l 1 -p -np -k https://origin.com/
# 可以抓取整站
wget -c -r -nd -np -k -L -p http://www.domain.com

# 配置mailx通过Gmail发送邮件
# 安装mailx
yum install mailx
# 打开防火墙端口
firewall-cmd --zone=public --add-port=465/tcp --permanent
firewall-cmd --zone=public --add-port=587/tcp --permanent
firewall-cmd --reload
firewall-cmd --list-ports
# 创建目录，用来存放证
mkdir -p /root/.certs/
# 向Gmail请求证书
echo -n | openssl s_client -connect smtp.gmail.com:465 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /root/.certs/gmail.crt
depth=2 OU = GlobalSign Root CA - R2, O = GlobalSign, CN = GlobalSign
verify return:1
depth=1 C = US, O = Google Trust Services, CN = Google Internet Authority G3
verify return:1
depth=0 C = US, ST = California, L = Mountain View, O = Google Inc, CN = smtp.gmail.com
verify return:1
DONE
# 添加一个证书到证书数据库中
certutil -A -n "GeoTrust SSL CA" -t "C,," -d ~/.certs -i ~/.certs/gmail.crt
certutil -A -n "GeoTrust Global CA" -t "C,," -d ~/.certs -i ~/.certs/gmail.crt
# 列出目录下的证书
certutil -L -d /root/.certs
Certificate Nickname                                         Trust Attributes
                                                             SSL,S/MIME,JAR/XPI

							     GeoTrust SSL CA                                              C,, 
cd .certs/
certutil -A -n "GeoTrust SSL CA - G3" -t "Pu,Pu,Pu"  -d ./ -i gmail.crt
Notice: Trust flag u is set automatically if the private key is present.
# 编辑mailx配置文件
vi /etc/mail.rc
set from=user@gmail.com
set smtp=smtps://smtp.gmail.com:465
set smtp=smtp://smtp.gmail.com:587
set smtp-use-starttls=yes
set nss-config-dir=/root/.certs/
set ssl-verify=ignore
set smtp-auth-user=user@gmail.com
set smtp-auth-password=password
set smtp-auth=login
# gmail启用POP/IMAP并允许不够安全的应用：已启用
https://myaccount.google.com/lesssecureapps
#发送测试邮件
echo "Send successfully" | mail -s "test" user@mail.com

# PHP
# composer
curl -sS https://getcomposer.org/installer | php71
php71 composer.phar install

# Apache
# 网页报错：HTTP ERROR 500，猜测是SELinux引起的问题
getenforce
Enforcing
setenforce 0
# 网页能正常访问
setenforce 1
# 网页无法访问，查看系统审计日志找到如下：avc:  denied
tail /var/log/audit/audit.log
type=AVC msg=audit(1543856777.173:324): avc:  denied  { write } for  pid=1870 comm="php-fpm" name="cacheconfig" dev="dm-0" ino=50971264 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:httpd_sys_content_t:s0 tclass=dir
type=SYSCALL msg=audit(1543856777.173:324): arch=c000003e syscall=21 success=no exit=-13 a0=7fd72466d308 a1=2 a2=0 a3=e5593773b56a4580 items=0 ppid=1101 pid=1870 auid=4294967295 uid=48 gid=48 euid=48 suid=48 fsuid=48 egid=48 sgid=48 fsgid=48 tty=(none) ses=4294967295 comm="php-fpm" exe="/opt/remi/php71/root/usr/sbin/php-fpm" subj=system_u:system_r:httpd_t:s0 key=(null)
type=PROCTITLE msg=audit(1543856777.173:324): proctitle=7068702D66706D3A20706F6F6C20777777
# 查看SELinux avc denied访问权限
audit2allow -w -a
type=AVC msg=audit(1543866684.962:473): avc:  denied  { write } for  pid=1612 comm="php-fpm" name="cacheconfig" dev="dm-0" ino=50971264 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:httpd_sys_content_t:s0 tclass=dir
	Was caused by:
	The boolean httpd_unified was set incorrectly. 
	Description:
	Allow httpd to unified

	Allow access by executing:
	# setsebool -P httpd_unified 1
# 修改SELinux布尔值
setsebool -P httpd_unified 1
getsebool -a | grep httpd | grep httpd_unified
httpd_unified --> on
# 网页报错连接数据库失败（Cannot connect to database），再次查看SELinux avc denied访问权限
audit2allow -w -a
type=AVC msg=audit(1543866141.159:391): avc:  denied  { name_connect } for  pid=1960 comm="php-fpm" dest=3306 scontext=system_u:system_r:httpd_t:s0 tcontext=system_u:object_r:mysqld_port_t:s0 tclass=tcp_socket
	Was caused by:
	One of the following booleans was set incorrectly.
	Description:
	Allow httpd to can network connect

	Allow access by executing:
	# setsebool -P httpd_can_network_connect 1
	Description:
	Allow httpd to can network connect db

	Allow access by executing:
	# setsebool -P httpd_can_network_connect_db 1
# 修改SELinux布尔值为Apache连接数据库放行
setsebool -P httpd_can_network_connect_db=1
getsebool -a | grep httpd | grep httpd_can_network_connect_db
httpd_can_network_connect_db --> on
# apache php-fpm https
yum install mod_ssl
vi /etc/httpd/conf.modules.d/php-fpm.conf
<FilesMatch \.php$>
  SetHandler "proxy:fcgi://127.0.0.1:9000"
</FilesMatch>
vi /etc/httpd/conf.d/webapp.conf
<VirtualHost *:80>
    ServerAdmin admin@example.com
    ServerName domain.com
    RewriteEngine On
    RewriteCond %{SERVER_PORT} 80
    RewriteRule ^(.*)$ https://%{HTTP_HOST}/$1 [R,L]
</VirtualHost>
<VirtualHost *:80>
	ServerAdmin admin@example.com
    ServerName domain.com
	RewriteEngine On
	RewriteCond %{HTTPS} !=on
	RewriteRule ^(.*) https://%{SERVER_NAME}/$1 [R,L]
</VirtualHost>
# 在相应的网站根目录新建 .htaccess
# 强制301重定向 HTTPS
<IfModule mod_rewrite.c>
RewriteEngine on
RewriteBase /
RewriteCond %{SERVER_PORT} !^443$
RewriteRule (.*) https://%{SERVER_NAME}/$1 [R=301,L]
</IfModule>
# 只允许www.domain.com 跳转
RewriteEngine On
RewriteCond %{SERVER_PORT} 80
RewriteCond %{HTTP_HOST} ^domain.com [NC,OR]
RewriteCond %{HTTP_HOST} ^www.domain.com [NC]
RewriteRule ^(.*)$ https://%{HTTP_HOST}/$1 [R,L]
# 高级用法 (可选）
RewriteEngine on
# 强制HTTPS
RewriteCond %{HTTPS} !=on [OR]
RewriteCond %{SERVER_PORT} 80
# 某些页面强制
RewriteCond %{REQUEST_URI} ^something_secure [OR]
RewriteCond %{REQUEST_URI} ^something_else_secure
RewriteRule .* https://%{SERVER_NAME}%{REQUEST_URI} [R=301,L]
# 强制HTTP
RewriteCond %{HTTPS} =on [OR]
RewriteCond %{SERVER_PORT} 443
# 某些页面强制
RewriteCond %{REQUEST_URI} ^something_public [OR]
RewriteCond %{REQUEST_URI} ^something_else_public
RewriteRule .* http://%{SERVER_NAME}%{REQUEST_URI} [R=301,L]
vi /etc/httpd/conf.d/ssl.conf
<VirtualHost *:443>
    ServerName www.domain.com
    ServerAlias domain.com
    DocumentRoot "/var/www/html/webapp"
    DirectoryIndex index.php
    ErrorLog "/var/log/httpd/webapp-error_log"
    CustomLog "/var/log/httpd/webapp-access_log" combined
    SSLEngine on
    SSLProtocol all -SSLv2 -SSLv3
    SSLCertificateFile /etc/ssl/domain.com.crt
    SSLCertificateKeyFile /etc/ssl/domain.com.key
    SSLCertificateChainFile /etc/ssl/domain.com.ca-bundle
</VirtualHost>
# http
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot "/var/www/html/webapp"
    ServerName domain.com
    DirectoryIndex index.php
    ErrorLog "/var/log/httpd/webapp-error_log"
    CustomLog "/var/log/httpd/webapp-access_log" combined
</VirtualHost>
vi /etc/httpd/conf/httpd.conf
Listen 80
Listen 443
LoadModule ssl_module modules/mod_ssl.so
Include conf.modules.d/*.conf
IncludeOptional conf.d/*.conf

# nginx
# nginx代理php-fpm
vi /etc/nginx/nginx.conf
	server {
        listen       80;
        server_name  localhost;     
            root   /opt/app;
        location / {
            #proxy_pass   http://127.0.0.1:8000;
            index index.php  index.html index.htm;
        }
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1:8080;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        location ~ \.php$ {
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }
	
# https代理http
vi /etc/nginx/nginx.conf
server {
        listen       80;
        listen       443 ssl;
        listen       [::]:80 default_server;
        server_name  domain.com;
        root         /usr/share/nginx/html;

        ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
        ssl_certificate /opt/ssl/domain.com.crt;
        ssl_certificate_key /opt/ssl/domain.com.key;
        ssl_prefer_server_ciphers on;

        if ($server_port = 80) {
                rewrite ^(.*)$ https://$host$1 permanent;
        }

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
                        proxy_pass http://127.0.0.1;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
	

# git
# 生成公钥
ssh-keygen
# 查看并复制公钥
cat /root/.ssh/id_rsa.pub
# 克隆远程仓库到本地
git clone git@github.com:username/repository.git
# 添加远程仓库
git remote add origin git@github.com:username/repository.git
# 添加修改后的文件
git add shell.sh
# 提交修改
git commit -m "second commit"
# 第一次提交到远程仓库
git push -u origin master
# 后续提交远程仓库
git push origin
# 回退到上个版本
git reset --hard HEAD^
# 查询commit id
git reflog
# 解决冲突直接修改文件

# vim
# 解决 Windows vim 乱码
vim C:\Program Files (x86)\Vim\_vimrc
set encoding=utf-8
set fileencodings=utf-8

# maven
mvn clean
mvn package -Pqa -DskipTests

# OA
# Webviews
/opt/odoo/odoo/addons/web/views
# ico
/usr/local/lib/python3.6/site-packages/odoo-11.0.post20180515-py3.6.egg/odoo/addons/web/static/src/img/favicon.ico
/opt/odoo/odoo/addons/web/static/src/img/favicon.ico
/opt/odoo/build/lib/odoo/addons/web/static/src/img/favicon.ico
# Powered by
/opt/odoo/odoo/addons/website/README.md
/opt/odoo/odoo/addons/website/views/website_templates.xml
/opt/odoo/build/lib/odoo/addons/website/README.md
/opt/odoo/build/lib/odoo/addons/website/views/website_templates.xml
/usr/local/lib/python3.6/site-packages/odoo-11.0.post20180515-py3.6.egg/odoo/addons/website/README.md
/usr/local/lib/python3.6/site-packages/odoo-11.0.post20180515-py3.6.egg/odoo/addons/website/views/website_templates.xml

# title
/usr/local/lib/python3.6/site-packages/odoo-11.0.post20180515-py3.6.egg/odoo/addons/web/static/src/xml/base.xml
js/apps.js
js/chrome/abstract_web_client.js
# link
http://172.16.10.247/web?#
# Odoo.com
cd /usr/local/lib/python3.6/site-packages/odoo-11.0.post20180515-py3.6.egg
sed -i 's/Odoo.com/Andrew.com/g;s/odoo.com/andrew.com/' `egrep -rl 'Odoo.com|odoo.com' /opt ./odoo`
# Powered by
Login Layout
web.menu_secondary
# Handle in Odoo
sed -i 's/Handle in Odoo/Handle in Andrew/g' `grep -rl 'Handle in Odoo' /opt ./odoo`

# trafficserver
wget http://archive.apache.org/dist/trafficserver/trafficserver-7.1.3.tar.bz2
wget http://mirror.bit.edu.cn/apache/trafficserver/trafficserver-7.1.3.tar.bz2
sha512sum trafficserver-7.1.3.tar.bz2 
1ddb23a1c0564929d2246ff3cd97595a9d0b1891736a9d0ef8ca56f52a7b86159b657bbc22f2e64aaccee13009ceff2a47c92b8b25121d65c7ccfdedf8b084ea  trafficserver-7.1.3.tar.bz2
yum install bzip2 bzip2-devel
tar -xvjf trafficserver-7.1.3.tar.bz2
yum install gcc gcc-c++
yum install openssl openssl-devel
yum install tcl tcl-devel
yum install bzip2 bzip2-devel gcc gcc-c++ openssl openssl-devel tcl tcl-devel
./configure --prefix=/usr/local/trafficserver --enable-example-plugins --enable-experimental-plugins
make && make install
/usr/local/ats/bin/trafficserver start
/usr/local/ats/bin/trafficserver stop
/usr/local/trafficserver/bin/trafficserver start
/usr/local/trafficserver/bin/trafficserver stop
vi /usr/local/trafficserver/etc/trafficserver/records.config
CONFIG proxy.config.http.server_ports STRING 80
vi /usr/local/trafficserver/etc/trafficserver/remap.config
map          http://www.cdn.com/      http://www.target.com/

# Linux安全加固
# 修改ssh默认端口
vi /etc/ssh/sshd_config
Port 28922
firewall-cmd --zone=public --add-port=28922/tcp --permanent
firewall-cmd --reload
yum provides /usr/sbin/semanage
yum whatprovides /usr/sbin/semanage
yum -y install policycoreutils-python
semanage port -a -t ssh_port_t -p tcp 28922
semanage port -l | grep ssh
# 修改root密码为随机密码
openssl rand 14 -base64
9FyOhqkmU8lo7EYgEVU
echo "9FyOhqkmU8" | passwd --stdin "root"
echo "root:9FyOhqkmU8" | chpasswd
# 开启ssh公钥免密登录
vi /etc/ssh/sshd_config
PasswordAuthentication no
PubkeyAuthentication yes
# 客户机生成ssh密钥对
ssh-keygen -t rsa -b 8192
ssh-copy-id serverip
ssh serverip
# xshell生成密钥对
cd /root/.ssh/
rz
cat my.pub >> authorized_keys
chmod 600 authorized_keys
systemctl restart sshd

# 单用户模式启动centos7
# 开机按进入选择启动内核的界面，按上下键停留按下e键进入编辑模式
# 在kernel 引导行所在参数行尾添加init=/bin/sh，按Ctrl+x启动到shell引导进入单用户模式
# 挂载根分区为可读写模式
mount -o remount,rw /
# 此时就可以通过passwd修改密码，不过此处需要注意两点：
# 主机如果开启有selinux，需在根分区创建autorelabel 文件，否则无法正常启动系统，操作命令如下：
touch /.autorelabel
# 修改完成后，像之前的版本中一样执行reboot命令已经无效，需要输入全路径命令，如下
exec /sbin/init
exec /sbin/reboot

# redis 备份恢复
redis-cli
bgsave
config get dir
# 将dump.rdb拷贝到config get dir得到的目录
systemctl start redis
redis-cli
keys *
lrange key 0 1
hgetall key
hset key field value

# docker
# 查看docker磁盘占用
docker system df
# 删除container
docker rm id
# 清理磁盘，删除关闭的容器、无用的数据卷和网络，以及无tag的镜像
docker system prune
# 删除images
docker rmi id 

# laradock
git clone https://github.com/Laradock/laradock.git
cd laradock
cp env-example .env
vi .env
DB_HOST=mysql
REDIS_HOST=redis
QUEUE_HOST=beanstalkd
docker-compose up -d nginx mysql phpmyadmin redis workspace
docker-compose exec workspace bash
vi laradock/nginx/sites/default.conf
mkdir public
vi public/index.html

# kali
docker pull kalilinux/kali-linux-docker
docker run -t -i kalilinux/kali-linux-docker /bin/bash
apt-get update && apt-get install metasploit-framework
passwd
apt-get install openssh-server --fix-missing -y
vi /etc/ssh/sshd_config
PermitRootLogin yes
apt-get install sqlmap
apt-get install kali-linux-all
exit
docker commit id ssh:kali
docker images
docker run -p 22:22 -it ssh:kali
service ssh start

# ssh-tunnel：本地端口转发、远程端口转发、动态端口转发
# 本地端口转发
ssh -L [listen_ip:]listen_port:target_ip:target_port user@ssh_server
# -L 选项：本地端口转发
# listen_ip：本地监听地址，默认为127.0.0.1和[::1]
# listen_port：本地监听端口
# target_ip：目的主机地址，即要转发给谁
# target_port：目的主机端口

# 通常我们使用端口转发时，是不需要登录远程主机的，因此可以使用 -CNf 选项
# -C 选项：启用压缩，节省带宽资源
# -N 选项：不登陆shell，即不会打开 shell 进程
# -f 选项：后台运行，即守护进程模式

# 命令举例：
ssh -CNf -L 192.168.1.101:80:ip.cn:80 root@zfl9.com
ssh -CNf -L 80:ip.cn:80 root@zfl9.com        # 监听127.0.0.1 [::1]
ssh -CNf -L :80:ip.cn:80 root@zfl9.com       # 监听0.0.0.0 [::]
ssh -CNf -L *:80:ip.cn:80 root@zfl9.com      # 同上
ssh -CNf -L 0.0.0.0:ip.cn:80 root@zfl9.com   # 监听0.0.0.0
ssh -CNf -L \[::\]:80:ip.cn:80 root@zfl9.com # 监听[::]

# 应用举例：
ssh -CNf -L 8080:ip.cn:80 root@zfl9.com
# 执行完毕后，ssh会在本地监听 127.0.0.1:8080 地址
# 任何发往 127.0.0.1:8080 的数据包都会通过 ssh 隧道被 ssh_server 转发给 ip.cn:80
# 当 ip.cn:80 响应后，ssh_server 会将响应数据包通过 ssh 隧道转发给本地主机
# 因此下面的命令会打印出 ssh 服务器的 IP 地址信息
curl -x 127.0.0.1:8080 ip.cn

# 远程端口转发
ssh -R server_listen_port:target_ip:target_port user@ssh_server
# -R 选项：远程端口转发
# server_listen_port：ssh_server 监听端口，这里不能指定监听地址，默认是 127.0.0.1 和 [::1]
# target_ip：目的主机地址，一般这个地址是当前主机可访问的
# target_port：目的主机端口

# 应用举例：
ssh -CNf -R 8080:ip.cn:80 root@zfl9.com
# 执行完毕后，ssh_server 会在服务器上监听 127.0.0.1:8080 地址
# 任何发往 ssh_server 127.0.0.1:8080 的数据包都会通过 ssh 隧道被本地主机转发给 ip.cn:80
# 当 ip.cn:80 响应后，本地主机会将响应数据包通过 ssh 隧道转发给 ssh_server 主机
# 可以看出，远程端口转发和本地端口转发是一个相反的流程。
# 所以，在 ssh_server 上执行下面的命令会打印出本地主机的 IP 地址信息
curl -x 127.0.0.1:8080 ip.cn

# 最典型的应用 - 穿透 NAT
# 比如我在自己家里搭建了一台内网 http 服务器，
# 平时我都是在内网环境中进行访问的，完全没问题。
# 但是，我现在想在公网环境下访问我的内网 http 服务器，该怎么做？
# 因为在内网环境中上网都是要经过路由器网关的，均做了 NAT 转换。
# 出去容易，但是进来就比较难了，被路由器挡住了。
# 这时就可以利用远程端口转发进行NAT穿透：
# 首先在本地主机执行 ssh 命令，假设内网 http 服务器地址为 192.168.1.100:80
ssh -CNf -R 8080:192.168.1.100:80 root@zfl9.com
# 然后登录 ssh_server 服务器，执行以下命令就可以访问网页了
curl -x 127.0.0.1:8080 192.168.1.100

# 动态端口转发
ssh -D listen_ip:listen_port user@ssh_server
# -D 选项：动态端口转发，其实应该说是 socks5 代理
# listen_ip：监听地址
# listen_port：监听端口

# 应用举例：
ssh -CNf -D 0.0.0.0:9999 root@zfl9.com
# 执行完毕后，ssh 会监听地址 0.0.0.0:9999，该地址提供 socks5 代理
# socks 协议估计大家都比较熟悉，最大的用途就是 FQ 科学上网了
# 这时候只要在 Chrome/Firefox 上配置 socks5 代理就可以畅游互联网了！
# 不过前提是你的服务器不在大陆，比如可以是香港的、日本的，速度都比较快！
