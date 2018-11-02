# powershell
# ps提权
set-alias su runas
su /user:administrator powershell
# 校验Hash值
Get-FileHash CentOS-7-x86_64-Minimal-1804.iso -Algorithm sha1 | Format-List
Get-FileHash CentOS-7-x86_64-Minimal-1804.iso | Format-List
Get-FileHash CentOS-7-x86_64-Minimal-1804.iso -Algorithm sha384 | Format-List
Get-FileHash CentOS-7-x86_64-Minimal-1804.iso -Algorithm sha512 | Format-List
Get-FileHash CentOS-7-x86_64-Minimal-1804.iso -Algorithm MACTripleDES | Format-List
Get-FileHash CentOS-7-x86_64-Minimal-1804.iso -Algorithm MD5 | Format-List
Get-FileHash CentOS-7-x86_64-Minimal-1804.iso -Algorithm RIPEMD160 | Format-List

# Windows Server 1803
# Activision Keys
https://docs.microsoft.com/en-us/windows-server/get-started/kmsclientkeys
slmgr /ipk 2HXDN-KRXHB-GPYC7-YCKFJ-7FVDG
slmgr /skms kms.chinancce.com
slmgr /ato
slmgr /xpr
# 配置服务器
sconfig
# 查看可安装功能
Import-Module ServerManager
Get-WindowsFeature
# 安装WDS服务
install-windowsfeature WDS 
install-windowsfeature WDS-Transport
install-windowsfeature DHCP
install-windowsfeature DNS
# 卸载WDS服务
uninstall-windowsfeature WDS 
# 配置WDS，获取WDS可用的命令
Get-Command –Module WDS
# wdsutil 
