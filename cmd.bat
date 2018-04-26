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
