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
