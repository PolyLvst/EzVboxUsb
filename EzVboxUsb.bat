@echo off
if not exist C:\Users\%username%\Documents\vmdk_files mkdir C:\Users\%username%\Documents\vmdk_files
echo ---- Make a bootable usb for vbox ---
echo Warning ! this script need admin privelages
echo It's recommended to close VirtualBox first :D
echo.
:User_input
set /p filename_vmdk=Type a name for it : 
if exist C:\Users\%username%\Documents\vmdk_files\%filename_vmdk%.vmdk (
echo file already existed 
goto User_input
)
start "" diskmgmt.msc
set /p USBnum=Search for your usb disk number or removable disk : 
echo vmdk file can be found at C:\Users\%username%\Documents\vmdk_files
goto Vbox_util

:Vbox_util
cd %programfiles%\Oracle\VirtualBox
echo VBoxmanage createmedium disk --filename=C:\Users\%username%\Documents\vmdk_files\%filename_vmdk%.vmdk --variant=RawDisk --format=VMDK --property RawDrive=\\.\PhysicalDrive%USBnum%> "%cd%\temp_vbox_createrawvmdk.bat"
call "%cd%\temp_vbox_createrawvmdk.bat"
timeout /t 3
del "%cd%\temp_vbox_createrawvmdk.bat"
rem this command deprecated : VBoxManage internalcommands createmedium -filename C:users\%username%\documents\vmdk_files\%filename% -rawdisk \\.\PhysicalDrive%USBnum%
echo Done my friend XD
echo open folder?
pause
echo okay . . .
start C:\Users\%username%\Documents\vmdk_files
pause