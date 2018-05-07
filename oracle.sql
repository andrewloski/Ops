--登录
sqlplus / as sysdba
sqlplus sys/password as sysdba
sqlplus user/password
sqlplus user/password@instance
--启动数据库
startup
startup nomount dbname
startup open dbname
startup nomount
alter database mount
alter database open
startup restrict
startup force
--连接数据库
conn sys/password as sysdba
conn sys/password as sysdba
conn user/password
conn user/password@instance

set linesize 500
set pagesize 800
--查询薪水排名前五的雇员
select * from (select * from emp order by sal desc) where rownum < 6;

--安装Oracle 12.2.0.1
--Centos7 minimal x86_64 cpu:4c memory:4G disk:30G swap:4G 
vi /etc/sysconfig/network-scripts/ifcfg-ens33
BOOTPROTO=static
IPADDR1=172.16.123.136
GATEWAY0=172.16.123.1
ONBOOT=yes
vi /etc/selinux/config
SELINUX=disabled
systemctl stop firewalld
systemctl disable firewalld
vi /etc/hostname
odb1
vi /etc/hosts
172.16.123.136 odb1
--安装依赖包
yum install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33.i686 glibc glibc.i686 glibc-devel glibc-devel.i686 ksh libaio libaio.i686 libaio-devel libaio-devel.i686 libX11 libX11.i686 libXau libXau.i686 libXi libXi.i686 libXtst libXtst.i686 libgcc libgcc.i686 libstdc++ libstdc++.i686 libstdc++-devel libstdc++-devel.i686 libxcb libxcb.i686 make nfs-utils net-tools smartmontools sysstat unixODBC unixODBC-devel gcc gcc-c++ libXext libXext.i686 zlib-devel zlib-devel.i686
--创建用户和组
groupadd oinstall
groupadd dba
groupadd oper
useradd -g oinstall -G dba,oper oracle
passwd oracle
--配置/etc/sysctl.conf
vi /etc/sysctl.conf
fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
--使配置生效
sysctl -p
--配置/etc/security/limits.conf
vi /etc/security/limits.conf
oracle   soft   nofile    1024
oracle   hard   nofile    65536
oracle   soft   nproc    16384
oracle   hard   nproc    16384
oracle   soft   stack    10240
oracle   hard   stack    32768
oracle   hard   memlock    134217728
oracle   soft   memlock    134217728
--创建目录
mkdir -p /u01/app/oracle/product/12.2.0.1/db_1
chown -R oracle:oinstall /u01
chmod 775 /u01
--配置环境变量
vi /home/oracle/.bash_profile
# Oracle Settings  
export TMP=/tmp  
export TMPDIR=$TMP  
  
export ORACLE_HOSTNAME=odb1  
export ORACLE_UNQNAME=cdb
export ORACLE_BASE=/u01/app/oracle  
export ORACLE_HOME=$ORACLE_BASE/product/12.2.0.1/db_1  
export ORACLE_SID=cdb1  
  
export PATH=/usr/sbin:$PATH  
export PATH=$ORACLE_HOME/bin:$PATH  
  
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib  
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
--下载解压
yum install unzip
scp linuxx64_12201_database.zip oracle@172.16.123.136:/home/oracle
su - oracle
unzip linuxx64_12201_database.zip
cd database
--编辑应答文件
vi install.rsp
oracle.install.responseFileVersion=/oracle/install/rspfmt_dbinstall_response_schema_v12.2.0
oracle.install.option=INSTALL_DB_SWONLY
UNIX_GROUP_NAME=oinstall
INVENTORY_LOCATION=/u01/app/oracle/oraInventory
ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/db_1
ORACLE_BASE=/u01/app/oracle
oracle.install.db.InstallEdition=EE
oracle.install.db.OSDBA_GROUP=dba
oracle.install.db.OSOPER_GROUP=oper
oracle.install.db.OSBACKUPDBA_GROUP=dba
oracle.install.db.OSDGDBA_GROUP=dba
oracle.install.db.OSKMDBA_GROUP=dba
oracle.install.db.OSRACDBA_GROUP=dba
oracle.install.db.config.starterdb.type=GENERAL_PURPOSE
oracle.install.db.config.starterdb.globalDBName=cdb1
oracle.install.db.config.starterdb.SID=cdb1
oracle.install.db.config.starterdb.characterSet=AL32UTF8
SECURITY_UPDATES_VIA_MYORACLESUPPORT=false
DECLINE_SECURITY_UPDATES=true
--开始安装
./runInstaller -force -silent -noconfig -responseFile /home/oracle/database/install.rsp
Starting Oracle Universal Installer...

Checking Temp space: must be greater than 500 MB.   Actual 18291 MB    Passed
Checking swap space: must be greater than 150 MB.   Actual 4095 MB    Passed
Preparing to launch Oracle Universal Installer from /tmp/OraInstall2018-03-15_05-10-52AM. Please wait ...[oracle@odb1 database]$ [WARNING] [INS-32055] The Central Inventory is located in the Oracle base.
   ACTION: Oracle recommends placing this Central Inventory in a location outside the Oracle base directory.
You can find the log of this install session at:
 /u01/app/oracle/oraInventory/logs/installActions2018-03-15_05-10-52AM.log
The installation of Oracle Database 12c was successful.
Please check '/u01/app/oracle/oraInventory/logs/silentInstall2018-03-15_05-10-52AM.log' for more details.

As a root user, execute the following script(s):
	1. /u01/app/oracle/oraInventory/orainstRoot.sh
	2. /u01/app/oracle/product/12.2.0.1/db_1/root.sh



Successfully Setup Software.
--root执行两个脚本
exit
/u01/app/oracle/oraInventory/orainstRoot.sh
Changing permissions of /u01/app/oracle/oraInventory.
Adding read,write permissions for group.
Removing read,write,execute permissions for world.

Changing groupname of /u01/app/oracle/oraInventory to oinstall.
The execution of the script is complete.
/u01/app/oracle/product/12.2.0.1/db_1/root.sh
Check /u01/app/oracle/product/12.2.0.1/db_1/install/root_odb1_2018-03-15_05-42-25-790094180.log for the output of root script
--编辑监听配置应答文件
su - oracle
cd database/response
cat netca.rsp | grep -Ev "^#|^$"
[GENERAL]
RESPONSEFILE_VERSION="12.2"
CREATE_TYPE="CUSTOM"
[oracle.net.ca]
INSTALLED_COMPONENTS={"server","net8","javavm"}
INSTALL_TYPE=""typical""
LISTENER_NUMBER=1
LISTENER_NAMES={"LISTENER"}
LISTENER_PROTOCOLS={"TCP;1521"}
LISTENER_START=""LISTENER""
NAMING_METHODS={"TNSNAMES","ONAMES","HOSTNAME"}
NSN_NUMBER=1
NSN_NAMES={"EXTPROC_CONNECTION_DATA"}
NSN_SERVICE={"PLSExtProc"}
NSN_PROTOCOLS={"TCP;HOSTNAME;1521"}
--配置，添加监听
netca -silent -responsefile /home/oracle/database/response/netca.rsp

Parsing command line arguments:
    Parameter "silent" = true
    Parameter "responsefile" = /home/oracle/database/response/netca.rsp
Done parsing command line arguments.
Oracle Net Services Configuration:
Profile configuration complete.
Oracle Net Listener Startup:
    Running Listener Control:
      /u01/app/oracle/product/12.2.0.1/db_1/bin/lsnrctl start LISTENER
    Listener Control complete.
    Listener started successfully.
Listener configuration complete.
Oracle Net Services configuration successful. The exit code is 0
lsnrctl status

LSNRCTL for Linux: Version 12.2.0.1.0 - Production on 15-MAR-2018 05:53:29

Copyright (c) 1991, 2016, Oracle.  All rights reserved.

Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=odb1)(PORT=1521)))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 12.2.0.1.0 - Production
Start Date                15-MAR-2018 05:51:43
Uptime                    0 days 0 hr. 1 min. 46 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /u01/app/oracle/product/12.2.0.1/db_1/network/admin/listener.ora
Listener Log File         /u01/app/oracle/diag/tnslsnr/odb1/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=odb1)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
The listener supports no services
The command completed successfully
--编辑创建数据库的应答文件
cd
vi dbca.rsp
responseFileVersion=/oracle/assistants/rspfmt_dbca_response_schema_v12.2.0  
gdbName=cdb1  
sid=cdb1  
databaseConfigType=SI  
RACOneNodeServiceName=  
policyManaged=false  
createServerPool=false  
serverPoolName=  
cardinality=  
force=false  
pqPoolName=  
pqCardinality=  
createAsContainerDatabase=true  
numberOfPDBs=1  
pdbName=cdb1pdb  
useLocalUndoForPDBs=true  
pdbAdminPassword=  
nodelist=  
templateName=/u01/app/oracle/product/12.2.0.1/db_1/assistants/dbca/templates/General_Purpose.dbc  
sysPassword=  
systemPassword=  
serviceUserPassword=  
emConfiguration=  
emExpressPort=5500  
runCVUChecks=false  
dbsnmpPassword=  
omsHost=  
omsPort=0  
emUser=  
emPassword=  
dvConfiguration=false  
dvUserName=  
dvUserPassword=  
dvAccountManagerName=  
dvAccountManagerPassword=  
olsConfiguration=false  
datafileJarLocation={ORACLE_HOME}/assistants/dbca/templates/  
datafileDestination={ORACLE_BASE}/oradata/{DB_UNIQUE_NAME}/  
recoveryAreaDestination={ORACLE_BASE}/fast_recovery_area/{DB_UNIQUE_NAME}  
storageType=FS  
diskGroupName=  
asmsnmpPassword=  
recoveryGroupName=  
characterSet=AL32UTF8  
nationalCharacterSet=AL16UTF16  
registerWithDirService=false  
dirServiceUserName=  
dirServicePassword=  
walletPassword=  
listeners=LISTENER  
variablesFile=  
variables=DB_UNIQUE_NAME=cdb1,ORACLE_BASE=/u01/app/oracle,PDB_NAME=,DB_NAME=cdb1,ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/db_1,SID=cdb1  
initParams=undo_tablespace=UNDOTBS1,memory_target=796MB,processes=300,db_recovery_file_dest_size=2780MB,nls_language=AMERICAN,dispatchers=(PROTOCOL=TCP) (SERVICE=cdb1XDB),db_recovery_file_dest={ORACLE_BASE}/fast_recovery_area/{DB_UNIQUE_NAME},db_block_size=8192BYTES,diagnostic_dest={ORACLE_BASE},audit_file_dest={ORACLE_BASE}/admin/{DB_UNIQUE_NAME}/adump,nls_territory=AMERICA,local_listener=LISTENER_CDB1,compatible=12.2.0,control_files=("{ORACLE_BASE}/oradata/{DB_UNIQUE_NAME}/control01.ctl", "{ORACLE_BASE}/fast_recovery_area/{DB_UNIQUE_NAME}/control02.ctl"),db_name=cdb1,audit_trail=db,remote_login_passwordfile=EXCLUSIVE,open_cursors=300  
sampleSchema=false  
memoryPercentage=40  
databaseType=MULTIPURPOSE  
automaticMemoryManagement=true  
totalMemory=0
--创建数据库
dbca -silent -createDatabase  -responseFile  /home/oracle/dbca.rsp
[WARNING] [DBT-06801] Specified Fast Recovery Area size (2,780 MB) is less than the recommended value.
   CAUSE: Fast Recovery Area size should at least be three times the database size (2,730 MB).
   ACTION: Specify Fast Recovery Area Size to be at least three times the database size.
Enter SYS user password: 

Enter SYSTEM user password: 

Enter PDBADMIN User Password: 

[WARNING] [DBT-06208] The 'SYS' password entered does not conform to the Oracle recommended standards.
   CAUSE: 
a. Oracle recommends that the password entered should be at least 8 characters in length, contain at least 1 uppercase character, 1 lower case character and 1 digit [0-9].
b.The password entered is a keyword that Oracle does not recommend to be used as password
   ACTION: Specify a strong password. If required refer Oracle documentation for guidelines.
[WARNING] [DBT-06208] The 'SYSTEM' password entered does not conform to the Oracle recommended standards.
   CAUSE: 
a. Oracle recommends that the password entered should be at least 8 characters in length, contain at least 1 uppercase character, 1 lower case character and 1 digit [0-9].
b.The password entered is a keyword that Oracle does not recommend to be used as password
   ACTION: Specify a strong password. If required refer Oracle documentation for guidelines.
[WARNING] [DBT-06208] The 'PDBADMIN' password entered does not conform to the Oracle recommended standards.
   CAUSE: 
a. Oracle recommends that the password entered should be at least 8 characters in length, contain at least 1 uppercase character, 1 lower case character and 1 digit [0-9].
b.The password entered is a keyword that Oracle does not recommend to be used as password
   ACTION: Specify a strong password. If required refer Oracle documentation for guidelines.
[WARNING] [DBT-06801] Specified Fast Recovery Area size (2,780 MB) is less than the recommended value.
   CAUSE: Fast Recovery Area size should at least be three times the database size (3,571 MB).
   ACTION: Specify Fast Recovery Area Size to be at least three times the database size.
Copying database files
1% complete
13% complete
25% complete
Creating and starting Oracle instance
26% complete
30% complete
31% complete
35% complete
38% complete
39% complete
41% complete
Completing Database Creation
42% complete
43% complete
44% complete
46% complete
49% complete
50% complete
Creating Pluggable Databases
55% complete
75% complete
Executing Post Configuration Actions
100% complete
Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/cdb1/cdb1.log" for further details.
--查看状态
sqlplus / as sysdba
SQL*Plus: Release 12.2.0.1.0 Production on Thu Mar 15 06:46:35 2018

Copyright (c) 1982, 2016, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production
select open_mode from v$database;

OPEN_MODE
--------------------
READ WRITE

select status from v$instance;

STATUS
------------
OPEN

--关闭数据库
shutdown immediate
Database closed.
Database dismounted.
ORACLE instance shut down.

shutdown normal
shutdown immediate
shutdown abort
shutdown transactional

--使用nid修改sid和数据库名
lsnrctl start
sqlplus / as sysdba
startup mount
host
nid target=sys/password dbname=odb

DBNEWID: Release 12.2.0.1.0 - Production on Thu Mar 15 09:26:54 2018

Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.

Password:
Connected to database CDB1 (DBID=944530128)

Connected to server version 12.2.0

Control Files in database:
    /u01/app/oracle/oradata/cdb1/control01.ctl
    /u01/app/oracle/fast_recovery_area/cdb1/control02.ctl

Change database ID and database name CDB1 to ODB? (Y/[N]) => y

Proceeding with operation
Changing database ID from 944530128 to 2933971559
Changing database name from CDB1 to ODB
    Control File /u01/app/oracle/oradata/cdb1/control01.ctl - modified
    Control File /u01/app/oracle/fast_recovery_area/cdb1/control02.ctl - modified
    Datafile /u01/app/oracle/oradata/cdb1/system01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/sysaux01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/undotbs01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/pdbseed/system01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/pdbseed/sysaux01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/users01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/pdbseed/undotbs01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/cdb1pdb/system01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/cdb1pdb/sysaux01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/cdb1pdb/undotbs01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/cdb1pdb/users01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/temp01.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/pdbseed/temp012018-03-15_06-13-49-067-AM.db - dbid changed, wrote new name
    Datafile /u01/app/oracle/oradata/cdb1/cdb1pdb/temp01.db - dbid changed, wrote new name
    Control File /u01/app/oracle/oradata/cdb1/control01.ctl - dbid changed, wrote new name
    Control File /u01/app/oracle/fast_recovery_area/cdb1/control02.ctl - dbid changed, wrote new name
    Instance shut down

Database name changed to ODB.
Modify parameter file and generate a new password file before restarting.
Database ID for database ODB changed to 2933971559.
All previous backups and archived redo logs for this database are unusable.
Database is not aware of previous backups and archived logs in Recovery Area.
Database has been shutdown, open database with RESETLOGS option.
Succesfully changed database name and ID.
DBNEWID - Completed succesfully.
--修改环境变量sid
vi .bash_profile
export ORACLE_UNQNAME=odb
export ORACLE_SID=odb
source .bash_profile
cp /u01/app/oracle/product/12.2.0.1/db_1/dbs/spfilecdb1.ora /u01/app/oracle/product/12.2.0.1/db_1/dbs/initodb.ora
--保留里面带*号的选项，删除有乱码的行，修改*.db_name
*.audit_file_dest='/u01/app/oracle/admin/cdb1/adump'
*.audit_trail='db'
*.control_files='/u01/app/oracle/oradata/cdb1/control01.ctl','/u01/app/oracle/fast_recovery_area/cdb1/control02.ctl'
*.db_block_size=8192
*.db_name='odb'
*.db_recovery_file_dest='/u01/app/oracle/fast_recovery_area/cdb1'
*.db_recovery_file_dest_size=2780m
*.diagnostic_dest='/u01/app/oracle'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=cdb1XDB)'
*.enable_pluggable_database=true
*.local_listener='LISTENER_CDB1'
*.memory_target=796m
*.nls_language='AMERICAN'
*.open_cursors=300
*.processes=300
*.remote_login_passwordfile='EXCLUSIVE'
*.undo_tablespace='UNDOTBS1'
--关闭数据库
sqlplus / as sysdba
shutdown immediate
ORA-01507: database not mounted


ORACLE instance shut down.
--启动挂载数据库
startup mount
ORACLE instance started.

Total System Global Area  834666496 bytes
Fixed Size		    8798264 bytes
Variable Size		  666898376 bytes
Database Buffers	  150994944 bytes
Redo Buffers		    7974912 bytes
Database mounted.
--打开数据库创建spfile
alter database open resetlogs;

Database altered.
create spfile from pfile='/u01/app/oracle/product/12.2.0.1/db_1/dbs/initodb.ora';
--修改tnsnames.ora
vi /u01/app/oracle/product/12.2.0.1/db_1/network/admin/tnsnames.ora
# tnsnames.ora Network Configuration File: /u01/app/oracle/product/12.2.0.1/db_1/network/admin/tnsnames.ora
# Generated by Oracle configuration tools.

LISTENER_CDB1 =
  (ADDRESS = (PROTOCOL = TCP)(HOST = odb1)(PORT = 1521))


ODB =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = odb1)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = odb)
    )
  )

--修改listener.ora
vi /u01/app/oracle/product/12.2.0.1/db_1/network/admin/listener.ora
# listener.ora Network Configuration File: /u01/app/oracle/product/12.2.0.1/db_1/network/admin/listener.ora
# Generated by Oracle configuration tools.

LISTENER =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = odb1)(PORT = 1521))
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
      (GLOBAL_DBNAME = odb)
      (SID_NAME = odb)
    )
  )

--使用scott用户
sqlplus sys/password as sysdba
--查询所有用户没有scott和sh
select username from dba_users;
--查看当前容器
show con_name;
CON_NAME
CDB$ROOT
--查看可插入数据库PDB的状态
select con_id, dbid, guid, name, open_mode from v$pdbs;
CON_ID DBID	  GUID				   NAME		OPEN_MODE
2      231555106  6771BF9004CE55A1E053887B10AC7F52 PDB$SEED	READ ONLY
3      4195839754 6771EC20BCBB5D3BE053887B10AC01BE CDB1PDB	MOUNTED
--将CDB切换到PDB
alter session set container=cdb1pdb;
show con_name;
CON_NAME
CDB1PDB
--打开cdb1pdb可插入数据库,此类语法只能在PDB容器下运行
alter database cdb1pdb open;
Database altered.
--在CDB下运行
alter pluggable database cdb1pdb open;
--查看scott与sh用户是否存在
SELECT username FROM dba_users WHERE username='SCOTT' OR username='SH';
no rows selected
--切换回CDB容器
ALTER SESSION SET CONTAINER=CDB$ROOT;
--关闭所有PDB
ALTER PLUGGABLE DATABASE ALL CLOSE;
--创建c##scott用户
sqlplus / as sysdba
CREATE USER c##scott IDENTIFIED BY tiger;
--为用户授权
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO c##scott CONTAINER=ALL;
--设置用户使用的表空间
ALTER USER c##scott DEFAULT TABLESPACE USERS;
ALTER USER c##scott TEMPORARY TABLESPACE TEMP;
--使用c##scott用户登录
CONNECT c##scott/tiger
--删除数据表
DROP TABLE emp PURGE;
DROP TABLE dept PURGE;
DROP TABLE bonus PURGE;
DROP TABLE salgrade PURGE;
--创建数据表
CREATE TABLE dept(
deptno NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
dname VARCHAR2(14),
loc VARCHAR2(13));
CREATE TABLE emp(
empno NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
ename VARCHAR2(10),
job VARCHAR2(9),
mgr NUMBER(4),
hiredate DATE,
sal NUMBER(7,2),
comm NUMBER(7,2),
deptno NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
CREATE TABLE bonus(
enamE VARCHAR2(10),
job VARCHAR2(9),
sal NUMBER,
comm NUMBER);
CREATE TABLE salgrade(
grade NUMBER,
losal NUMBER,
hisal NUMBER);
--插入测试数据dept
INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');
--插入测试数据emp
INSERT INTO emp VALUES (7369, 'SMITH' , 'CLERK' ,7902,to_date
( '17-12-1980' , 'dd-mm-yyyy' ),800, NULL ,20);
INSERT INTO emp VALUES (7499, 'ALLEN' , 'SALESMAN' ,7698,to_date
( '20-2-1981' , 'dd-mm-yyyy' ),1600,300,30);
INSERT INTO emp VALUES (7521, 'WARD' , 'SALESMAN' ,7698,to_date
( '22-2-1981' , 'dd-mm-yyyy' ),1250,500,30);
INSERT INTO emp VALUES (7566, 'JONES' , 'MANAGER' ,7839,to_date
( '2-4-1981' , 'dd-mm-yyyy' ),2975, NULL ,20);
INSERT INTO emp VALUES (7654, 'MARTIN' , 'SALESMAN' ,7698,to_date
( '28-9-1981' , 'dd-mm-yyyy' ),1250,1400,30);
INSERT INTO emp VALUES (7698, 'BLAKE' , 'MANAGER' ,7839,to_date
( '1-5-1981' , 'dd-mm-yyyy' ),2850, NULL ,30);
INSERT INTO emp VALUES (7782, 'CLARK' , 'MANAGER' ,7839,to_date
( '9-6-1981' , 'dd-mm-yyyy' ),2450, NULL ,10);
INSERT INTO emp VALUES (7788, 'SCOTT' , 'ANALYST' ,7566,to_date
( '19-04-1987' , 'dd-mm-yyyy' )-85,3000, NULL ,20);
INSERT INTO emp VALUES (7839, 'KING' , 'PRESIDENT' , NULL ,to_date
( '17-11-1981' , 'dd-mm-yyyy' ),5000, NULL ,10);
INSERT INTO emp VALUES (7844, 'TURNER' , 'SALESMAN' ,7698,to_date
( '8-9-1981' , 'dd-mm-yyyy' ),1500,0,30);
INSERT INTO emp VALUES (7876, 'ADAMS' , 'CLERK' ,7788,to_date
( '23-05-1987' , 'dd-mm-yyyy' )-51,1100, NULL ,20);
INSERT INTO emp VALUES (7900, 'JAMES' , 'CLERK' ,7698,to_date
( '3-12-1981' , 'dd-mm-yyyy' ),950, NULL ,30);
INSERT INTO emp VALUES (7902, 'FORD' , 'ANALYST' ,7566,to_date
( '3-12-1981' , 'dd-mm-yyyy' ),3000, NULL ,20);
INSERT INTO emp VALUES (7934, 'MILLER' , 'CLERK' ,7782,to_date
( '23-1-1982' , 'dd-mm-yyyy' ),1300, NULL ,10);
--插入测试数据salgrade
INSERT INTO salgrade VALUES (1,700,1200);
INSERT INTO salgrade VALUES (2,1201,1400);
INSERT INTO salgrade VALUES (3,1401,2000);
INSERT INTO salgrade VALUES (4,2001,3000);
INSERT INTO salgrade VALUES (5,3001,9999);
--事务提交
COMMIT;
--查看所有的表名
select table_name from user_tables;
--查询各表数据
select * from dept;
select * from emp;
select * from bonus;
select * from salgrade;

--数据库导出，导入，备份，迁移
su - oracle
--创建导出文件存放目录
mkdir backup
--system登录
sqlplus /nolog
conn system/password as sysdba
--创建逻辑目录
create directory dumpdir as '/home/oracle/backup';
--查看管理理员目录
select * from dba_directories;
--给c##scott用户赋予在指定目录的操作权限
grant read,write on directory dumpdir to c##scott;
exit
--导出表
expdp c##scott/tiger DIRECTORY=dumpdir DUMPFILE=dept.dmp TABLES=dept LOGFILE=dept.log
--导出方案（导出用户）
expdp c##scott/tiger@odb schemas=c##scott dumpfile=scott.dmp DIRECTORY=dumpdir LOGFILE=scott.log
--导出表空间
expdp system/password DIRECTORY=dumpdir DUMPFILE=tablespace.dmp TABLESPACES=users,temp LOGFILE=tablespace.log
--导出数据库
expdp system/password DIRECTORY=dumpdir DUMPFILE=full.dmp FULL=y LOGFILE=full.log
--登录
sqlplus c##scott/tiger
--查表
select table_name from user_tables;
--删除表
drop table salgrade purge;
--导入表
impdp c##scott/tiger directory=dumpdir dumpfile=dept.dmp tables=c##scott.dept logfile=imp_dept.log
--从全库备份中导入表
impdp c##scott/tiger directory=dumpdir dumpfile=full.dmp tables=c##scott.salgrade logfile=imp_salgrade.log
--导入方案（导入用户）
impdp c##scott/tiger DIRECTORY=dumpdir DUMPFILE=scott.dmp SCHEMAS=c##scott logfile=imp_scott.log
--导入表空间
impdp system/password DIRECTORY=dumpdir DUMPFILE=tablespace.dmp TABLESPACES=users logfile=imp_tbs.log
--导入数据库
impdp system/password DIRECTORY=dumpdir DUMPFILE=full.dmp FULL=y logfile=imp_full.log
--创建用户
create user c##tiger identified by scott;
--为用户授权
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO c##tiger CONTAINER=ALL;
--创建表空间
create tablespace tiger datafile '/u01/app/oracle/oradata/cdb1/tiger01.dbf' size 10M extent management local uniform size 1M;
--查看表空间的名称及大小
SELECT t.tablespace_name, SUM(bytes / (1024 * 1024)) ts_size
FROM dba_tablespaces t, dba_data_files d
WHERE t.tablespace_name = d.tablespace_name
GROUP BY t.tablespace_name;
--查看表空间物理文件的名称及大小
SELECT tablespace_name, file_id, file_name, bytes / (1024 * 1024) total_space
FROM dba_data_files
ORDER BY tablespace_name;
--分配表空间
ALTER USER c##tiger DEFAULT TABLESPACE TIGER;
ALTER USER c##tiger TEMPORARY TABLESPACE TEMP;
commit;
--登录
conn c##tiger/scott
--查看表名
select table_name from user_tables;
--导入不同方案（导入不同用户）
impdp system/password directory=dumpdir dumpfile=full.dmp tables=c##scott.salgrade remap_schema=c##scott:c##tiger logfile=imp_tiger_salgrade.log
--导入不同用户不同表空间
impdp system/password directory=dumpdir dumpfile=scott.dmp remap_tablespace=users:tiger remap_schema=c##scott:c##tiger logfile=imp_tiger.log

--DBA登录
sqlplus sys/password as sysdba
--创建逻辑目录
create directory dumpdir as '/home/oracle/backup';
--给c##tiger用户赋予在指定目录的操作权限
grant read,write on directory dumpdir to c##tiger;
--导出方案
expdp c##tiger/scott@odb schemas=c##tiger dumpfile=tiger.dmp DIRECTORY=dumpdir LOGFILE=tiger.log
--删除用户及对象
drop user c##tiger cascade;
--删除表空间和内容
drop tablespace tiger INCLUDING CONTENTS;
--查看表空间文件
select tablespace_name,file_name from dba_data_files;
--创建用户
create user c##tiger identified by scott;
--为用户授权
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO c##tiger CONTAINER=ALL;
--创建表空间，大小2M，自动扩容1M，最大无限制
create tablespace tiger datafile '/u01/app/oracle/oradata/cdb1/tiger01.dbf' size 2M autoextend on next 1M maxsize unlimited;
--查看表空间的名称及大小
SELECT t.tablespace_name, SUM(bytes / (1024 * 1024)) ts_size
FROM dba_tablespaces t, dba_data_files d
WHERE t.tablespace_name = d.tablespace_name
GROUP BY t.tablespace_name;
--查看表空间物理文件的名称及大小
SELECT tablespace_name, file_id, file_name, bytes / (1024 * 1024) total_space
FROM dba_data_files
ORDER BY tablespace_name;
--查询表空间使用率 
SELECT total.tablespace_name,  
       Round(total.MB, 2)           AS Total_MB,  
       Round(total.MB - free.MB, 2) AS Used_MB,  
       Round(( 1 - free.MB / total.MB ) * 100, 2)  
       || '%'                       AS Used_Pct  
FROM   (SELECT tablespace_name,  
               Sum(bytes) / 1024 / 1024 AS MB  
        FROM   dba_free_space  
        GROUP  BY tablespace_name) free,  
       (SELECT tablespace_name,  
               Sum(bytes) / 1024 / 1024 AS MB  
        FROM   dba_data_files  
        GROUP  BY tablespace_name) total  
WHERE  free.tablespace_name = total.tablespace_name;
--表空间扩容，改变数据文件的大小
alter database datafile '/u01/app/oracle/oradata/cdb1/tiger01.dbf' resize 5M;
--添加数据文件
alter tablespace tiger add datafile '/u01/app/oracle/oradata/cdb1/tiger02.dbf' size 2M;
--分配表空间
ALTER USER c##tiger DEFAULT TABLESPACE TIGER;
ALTER USER c##tiger TEMPORARY TABLESPACE TEMP;
commit;
--给c##tiger用户赋予在指定目录的操作权限
grant read,write on directory dumpdir to c##tiger;
--导入方案
impdp c##tiger/scott DIRECTORY=dumpdir DUMPFILE=tiger.dmp SCHEMAS=c##tiger logfile=imp_tiger.log
--登录
conn c##tiger/scott
--查看表名
select table_name from user_tables;

