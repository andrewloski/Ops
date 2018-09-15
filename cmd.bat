rem Windows command prompt
rem cmd提权
doskey su=runas /user:administrator cmd

rem U盘分区
diskpart
list disk
sel disk 1
clean
cre par pri size=8192
active
format fs=ntfs quick

rem 磁盘分区
List Disk
Select Disk 0
Clean
Create Partition Primary Size=512000
Active
Format fs=ntfs Quick
Create Partition Extended
Create Partition Logical Size=512000
Format fs=ntfs Quick
Create Partition Logical Size=512000
Format fs=ntfs Quick
Create Partition Logical
Format fs=ntfs Quick
Exit

REM 1. 查询所有存在的转发            
netsh interface portproxy show all                   
REM 2. 添加一个IPV4到IPV4的端口映射，将192.168.193.1上的22映射到192.168.191.2的22端口：          
netsh interface portproxy add v4tov4 listenaddress=192.168.193.1 listenport=22 connectaddress=192.168.191.2 connectport=22      
REM 3. 删除端口映射             
netsh interface portproxy del v4tov4 listenport=22 listenaddress=192.168.193.1

REM 添加应用到防火墙列表
netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes
REM 删除启用的程序
netsh advfirewall firewall delete rule name="My Application" program="C:\MyApp\MyApp.exe"
REM 启用端口
netsh advfirewall firewall add rule name="Open Port 80" dir=in action=allow protocol=TCP localport=80
REM 删除启用的端口
netsh advfirewall firewall delete rule name=规则名称 protocol=udp localport=500
REM 启用 Windows 防火墙
netsh advfirewall set currentprofile state on
REM 关闭 Windows 防火墙
netsh advfirewall set currentprofile state off

REM 禁用WLAN
netsh interface set interface WLAN disabled
REM 启用WLAN
netsh interface set interface WLAN enabled
REM 静态IP
netsh interface ip set address "以太网" static 192.168.1.8 255.255.255.0 192.168.1.1 1
netsh interface ip set dns name="以太网" source=static addr=8.8.8.8 register=primary
netsh interface ip add dns name="以太网" addr=8.8.4.4
REM DHCP
netsh interface ip set address "以太网" dhcp
netsh interface ip set dns name="以太网" source=dhcp

REM 根据程序名称强制杀掉进程
taskkill /F /IM app.exe >nul 2>nul
REM 根据程序名称强制杀掉进程树
taskkill /F /IM app.exe /T >nul 2>nul

REM 查看当前系统信息
dism /online /Get-CurrentEdition
REM 查看当前系统是否可升级，以及可升级版本
dism /online /Get-TargetEditions
REM 查看所有功能
dism /online /Get-Features | more
REM 禁用当前状态为“已启用”的功能
dism /online /Disable-Feature /FeatureName:XXX
REM 开启当前状态为“已禁用”的功能
dism /online /Enable-Feature /FeatureName:XXX
REM 初始备份（例如把 C 分区的系统备份到 D 分区的 Win8BF 文件夹中，备份文件名为 Win8Pro.wim）
Dism /Capture-Image /ImageFile:D:\Win8BF\Win8Pro.wim /CaptureDir:C:\ /Name:Win8Pro-1 /Description:0000-00-00
REM 命令解释
/Capture-Image - 将驱动器的映像捕获到新的 WIM 文件中，捕获的目录包含所有子文件夹和数据。
/ImageFile - 指定映像文件路径。
/CaptureDir - 指定捕获目录。
/Name - 指定名称。此项不能省略。
/Description - 指定描述。描述是为了说明这次备份的具体情况，我们这里用了时间。此项可省略。
REM 增量备份（例如把 C 分区的系统增量备份到 >D:\Win8BF\Win8Pro.wim 中）
Dism /Append-Image /ImageFile:D:\Win8BF\Win8Pro.wim /CaptureDir:C:\ /Name:Win8Pro-2 /Description:0000-00-00
REM 命令解释
/Append-Image - 将其他映像添加到 WIM 文件中
REM 从具有多个卷映像的 WIM 文件中删除指定的卷映像（例如：删除 D:\Win8BF\Win8.wim 中的第二次备份）
Dism /Delete-Image /ImageFile:\Win8BF\Win8Pro.wim /Index:2
REM 命令解释
/Delete-Image - 从具有多个卷映像的 WIM 文件删除指定的卷映像
REM 从具有多个卷映像的 WIM 文件中提取单独的卷映像（例如：从 D:\Win8\Win8Pro.wim 中提取第二次备份到 D:\Win8BF\ 中，保存为 Win8Pro-2.wim）
DISM /Export-Image /SourceImageFile:D:\Win8\Win8Pro.wim /SourceIndex:2 /DestinationImageFile: D:\Win8BF\
REM 系统还原（例如把 D:\Win8BF\Win8Pro.wim 中第二次备份还原到 C 分区）
Dism /Apply-Image /ImageFile:D:\Win8BF\Win8Pro.wim /Index:2 /ApplyDir:C:\
REM 命令解释
/Apply-Image - 应用一个映像
/ApplyDir - 指定应用目录
/Index - 指定索引。此项不能省略
REM 在 PE 中把 Win8Pro 安装到 C 分区（设 Win8ISO 用虚拟光驱加载的盘符为 E）
Dism /Apply-Image /ImageFile:E:\sources\install.wim /Index:1 /ApplyDir:C:\
REM 由于 Windows 系统原始（WIM 映像）中没有启动引导文件，需要添加启动引导：
bcdboot C:\windows /s C: /l zh-cn
REM 如果是把 Windows 8 安装到 USB 设备中作 Windows To Go，也应添加启动引导：
bcdboot X:\windows /s X: /l zh-cn /f ALL （X为 USB 设备的盘符）
REM 扫描映像来检查损坏。在管理员命令提示符下键入以下命令：
Dism /Online /Cleanup-Image /ScanHealth
REM 检查映像以查看是否有检测到损坏
Dism /Online /Cleanup-Image /CheckHealth
REM 修复映像
DISM /Online /Cleanup-image /RestoreHealth
REM 若要使用你自己的一些来源，不使用 Windows 更新来修复一个联机映像，则键入：
Dism /Online /Cleanup-Image /RestoreHealth /Source:c:\test\mount\windows /LimitAccess

REM WinPE
cd /d F:\adk\Assessment and Deployment Kit\Windows Preinstallation Environment
notepad copype.cmd
set SOURCE=F:\adk\Assessment and Deployment Kit\Windows Preinstallation Environment\%WINPE_ARCH%
set FWFILESROOT=F:\adk\Assessment and Deployment Kit\Deployment Tools\%WINPE_ARCH%\Oscdimg
notepad MakeWinPEMedia.cmd
"F:\adk\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg" -bootdata:%BOOTDATA% -u1 -udfver102 "%WORKINGDIR%\%TEMPL%" "%DEST%" >NUL
copype amd64 amd64_winpe
MakeWinPEMedia /iso amd64_winpe F:\winpe_amd64.iso

REM WDS
REM 查看可安装功能
dism /Online /Get-Features
dism /Online /Get-Features | findstr DHCP
dism /Online /Get-Features | findstr DNS
dism /Online /Get-Features | findstr Deployment
REM 安装WDS
dism /Online /Enable-feature /Featurename: /Featurename:Microsoft-Windows-Deployment-Services-ServerCore /Featurename:Microsoft-Windows-Deployment-Services-Transport-Server-Services-ServerCore
