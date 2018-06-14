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

# nginx

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
sed -i 's/Odoo.com/Marquis.com/g;s/odoo.com/marquis.com/' `egrep -rl 'Odoo.com|odoo.com' /opt ./odoo`
# Powered by
Login Layout
web.menu_secondary
# Handle in Odoo
sed -i 's/Handle in Odoo/Handle in Marquis/g' `grep -rl 'Handle in Odoo' /opt ./odoo`

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


