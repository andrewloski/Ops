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
    
# nginx安装及全站https域名部署脚本
#!/bin/sh
cat > /etc/yum.repos.d/nginx.repo << EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/
gpgcheck=0
enabled=1
EOF
yum install nginx unzip lrzsz -y
systemctl enable nginx
systemctl start nginx
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --reload
domain=/root/domain
l=$(cat /root/domain | wc -l)
for ((i=1;i<=$l;i++))
do
d=$(sed -n "$i"p $domain)
cat > /etc/nginx/conf.d/$d.conf << EOF
server {
    listen       80;
    listen       443 ssl;
    server_name  $d www.$d m.$d *.$d;
    root         /usr/share/nginx/html/$d;

    ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
    ssl_certificate /etc/ssl/$d.crt;
    ssl_certificate_key /etc/ssl/$d.key;
    ssl_prefer_server_ciphers on;

    if (\$server_port = 80) {
        rewrite ^(.*)$ https://\$host\$1 permanent;
    }

    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;

    location / {
        index index.htm index.html;
    }

    error_page 404 /404.html;
        location = /40x.html {
    }

    error_page 500 502 503 504 /50x.html;
                location = /50x.html {
    }
}
EOF
done
getenforce
firewall-cmd --list-ports	

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

# rsync 数据同步备份
# 在实际生产中，数据备份与同步是非常重要的事情！比如网站的一些重要文件，MySQL 数据库的热备等等。
# rsync配置
# rsync 是 Linux 自带的远程数据备份同步工具，使用及配置都很简单；
# 要使用 rsync，首先要配置 rsync 服务器，客户端和服务器都要安装 rsync；

## 安装 rsync
yum -y install rsync

## rsyncd.conf 主配置文件
--- /etc/rsyncd.conf ---
uid = root
gid = root
use chroot = no

# 口令文件
secrets file = /etc/rsyncd.secrets

# 默认情况下，客户端不能修改服务器的文件，除非添加 'read only = no'；

[test]
       path = /root/test
       comment = test
       auth users = root    # 认证的用户
--- /etc/rsyncd.conf ---

## rsyncd.secrets 口令文件
--- /etc/rsyncd.secrets ---
root:123456
--- /etc/rsyncd.secrets ---

## 修改口令文件的权限为 600
chmod 600 /etc/rsyncd.secrets

## 启动 rsyncd 服务
systemctl enable rsyncd     # 开机自启
systemctl start rsyncd      # 运行服务
systemctl -l status rsyncd  # 查看状态

#  rsync使用
## 命令格式
rsync [option] src dst
# -a：归档
# -z：压缩
# -v：verbose
# -P：进度等信息
# --delete：删除src没有而dst上有的文件
# --exclude：排除某些文件
# --exclude-from：从指定文件读取排除参数
# --password-file：指定密码文件（权限为 600）

## 命令举例
rsync -azvP root@192.168.255.105::test /tmp/test

# 指定密码文件
echo '123456' > /root/.rsync.passwd && chmod 600 /root/.rsync.passwd
rsync -azvP --password-file=/root/.rsync.passwd root@192.168.255.105::test /tmp/test

# 删除本地没有而服务器上有的文件
rsync -azvP --delete --password-file=/root/.rsync.passwd /tmp/test/ root@192.168.255.105::test

# 排除以 .bak 结尾的文件
rsync -azvP --exclude=*.bak --password-file=/root/.rsync.passwd root@192.168.255.105::test /tmp/test

# 从指定文件中读取排除参数
echo '*.bak' > /root/.exclude.rsync
rsync -azvP --exclude-from=/root/.exclude.rsync --password-file=/root/.rsync.passwd root@192.168.255.105::test /tmp/test

# 从本地上传数据到服务器：把 src 和 dst 互换即可

# 查看目标的所有文件
rsync -v rsync://root@192.168.255.105::test

# 内核参数调优
# 系统默认参数一般都是比较保守的，我们可以通过调整系统参数来提高系统内存、CPU、内核资源的占用，通过禁用不必要的服务、端口，来提高系统的安全性，更好的发挥系统的可用性。文件描述符
#ulimit 资源限制

### 用户限制
--- /etc/security/limits.conf ---
root soft nofile 102400
root hard nofile 102400

### 内核限制
--- /etc/sysctl.conf ---
fs.file-max = 10240000

sysctl -p   # 立即生效

### 重新登录 shell
ulimit -n                   # 查看当前shell的最大文件描述符数
sysctl -a | grep file-max   # 查看当前内核的最大文件描述符数
cat /proc/sys/fs/file-nr    # 分别表示：已分配的句柄数、已分配未使用的句柄数、file-max 值
# 关闭三键重启
# 仅针对 CentOS 6.x

--- /etc/init/control-alt-delete.conf ---
#exec /sbin/shutdown -r now "Control-Alt-Deletepressed"
# 隐藏系统信息
echo "Welcome to Server" > /etc/issue
echo "Welcome to Server" > /etc/centos-release
# 命令历史记录
--- /etc/profile ---
export HISTSIZE=10000
export HISTCONTROL=ignoredups   # 忽略重复记录
# ntp 时间同步
# ntp 时间同步（CentOS 6.x）、chrony 时间同步（CentOS 7.x）

## 常用公共ntp服务器
time.windows.com
cn.pool.ntp.org
tw.pool.ntp.org

## 手动更新时间
ntpdate -u time.windows.com

## 设置时区为上海:
CentOS 6.x：ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
CentOS 7.x：timedatectl set-timezone Asia/Shanghai
# 内核参数优化
### VPS 服务器配置（1G 内存）
--- /etc/sysctl.conf ---
net.ipv4.ip_forward = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 0
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 3
net.ipv4.ip_local_port_range = 10000 65535
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_max_syn_backlog = 10240
net.core.netdev_max_backlog = 10240
net.core.somaxconn = 10240
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_keepalive_time = 120
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 3
net.core.rmem_default = 8388608
net.core.wmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 65536 786432 2097152
net.ipv4.tcp_wmem = 65536 786432 2097152
net.ipv4.tcp_mem = 177945 216076 254208
net.ipv4.tcp_fastopen = 3
fs.file-max = 500000000

### 内核参数详解
net.ipv4.ip_forward = 1                     # 允许网卡之间的数据包转发
net.ipv4.tcp_syncookies = 1                 # 启用syncookies, 可防范少量syn攻击
net.ipv4.tcp_tw_reuse = 0                   # 重用time_wait的tcp端口(建议禁用)
net.ipv4.tcp_tw_recycle = 0                 # 启用time_wait快速回收机制(建议禁用)
net.ipv4.tcp_fin_timeout = 3                # fin_wait_2超时时间
net.ipv4.ip_local_port_range = 10000 65535  # 动态分配端口的范围
net.ipv4.tcp_max_tw_buckets = 5000          # time_wait套接字最大数量，高于该值系统会立即清理并打印警告信息
net.ipv4.tcp_max_syn_backlog = 10240        # syn队列长度
net.core.netdev_max_backlog = 10240         # 最大设备队列长度
net.core.somaxconn = 10240                  # listen()的默认参数, 等待请求的最大数量
net.ipv4.tcp_syn_retries = 2                # 放弃建立连接前内核发送syn包的数量
net.ipv4.tcp_synack_retries = 2             # 放弃连接前内核发送syn+ack包的数量
net.ipv4.tcp_max_orphans = 3276800          # 设定最多有多少个套接字不被关联到任何一个用户文件句柄上
net.ipv4.tcp_keepalive_time = 120           # keepalive idle空闲时间
net.ipv4.tcp_keepalive_intvl = 30           # keepalive intvl间隔时间
net.ipv4.tcp_keepalive_probes = 3           # keepalive probes最大探测次数
net.core.rmem_default = 8388608             # socket默认读buffer大小
net.core.wmem_default = 8388608             # socket默认写buffer大小
net.core.rmem_max = 16777216                # socket最大读buffer大小
net.core.wmem_max = 16777216                # socket最大写buffer大小
net.ipv4.tcp_rmem = 65536 786432 2097152    # tcp_socket读buffer大小
net.ipv4.tcp_wmem = 65536 786432 2097152    # tcp_socket写buffer大小
net.ipv4.tcp_mem = 177945 216076 254208     # 确定tcp栈应该如何反映内存使用
net.ipv4.tcp_fastopen = 3                   # 开启tcp_fastopen（内核 3.7 +）
fs.file-max = 500000000                     # 最大允许的文件描述符数量

## net/ipv4/tcp_mem 解释
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_mem[0]: 低于此值，TCP没有内存压力      # 80% of Memory
net.ipv4.tcp_mem[1]: 在此值下，进入内存压力阶段     # 90% of Memory
net.ipv4.tcp_mem[2]: 高于此值，TCP拒绝分配socket    # 100% of Memory
# 内存单位是页（1页=4kb），可根据物理内存大小进行调整，如果内存足够大的话，可适当往上调
