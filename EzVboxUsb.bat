@echo off & CLS & ECHO.
NET FILE 1>NUL 2>NUL & IF ERRORLEVEL 1 (
ECHO You must right-click and select
ECHO "RUN AS ADMINISTRATOR"  to run this batch. Exiting... 
ECHO.
PAUSE 
EXIT
)
REM ... proceed here with admin rights ...
if not exist C:\Users\%username%\Documents\vmdk_files mkdir C:\Users\%username%\Documents\vmdk_files
echo ---- Make a bootable usb for vbox ---
echo EzVboxUsb v0.2
echo.

:User_input
set /p filename_vmdk=Type a name for it : 
if exist C:\Users\%username%\Documents\vmdk_files\%filename_vmdk%.vmdk (
echo file already existed 
goto User_input
)
goto Disk_num

:Disk_num
start "" diskmgmt.msc
set /p USBnum=Usb disk number or removable disk : 
echo vmdk file can be found at C:\Users\%username%\Documents\vmdk_files
goto Vbox_util

:Vbox_util
cd %programfiles%\Oracle\VirtualBox
start "" VirtualBox.exe
echo VBoxmanage createmedium disk --filename=C:\Users\%username%\Documents\vmdk_files\%filename_vmdk%.vmdk --variant=RawDisk --format=VMDK --property RawDrive=\\.\PhysicalDrive%USBnum%> "%cd%\temp_vbox_createrawvmdk.bat"
timeout /t 5
call "%cd%\temp_vbox_createrawvmdk.bat"
timeout /t 3
del "%cd%\temp_vbox_createrawvmdk.bat"
echo done . . . 
PAUSE
goto eof
rem this command deprecated : VBoxManage internalcommands createrawvmdk -filename C:users\%username%\documents\vmdk_files\%filename% -rawdisk \\.\PhysicalDrive%USBnum%

:eof