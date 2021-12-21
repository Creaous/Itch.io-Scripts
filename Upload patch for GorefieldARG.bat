@echo off
set basepath=F:\Unreal Projects\GorefieldARG\Built
set winpath=%basepath%\WindowsNoEditor
set linuxpath=%basepath%\LinuxNoEditor
set butlerpath=butler.lnk
set zippath="C:\Program Files\7-Zip\7z.exe"
set user=creaous
set game=security-guard-for-jon-arbuckle
set upload=%user%/%game%

title itch.io Patcher

echo.
echo Base Path: %basepath%
echo Windows Path: %winpath%
echo Linux Path: %linuxpath%
echo Butler Path: %butlerpath%
echo 7-Zip Path: %zippath%
echo Upload Path: %upload%
echo.

echo Please check the above to make sure they are all correct.

echo.
pause
echo.
echo Do you want to create zip files for Windows and Linux?
set /P archive=
echo.

IF "%archive%"=="y" (
	goto createzip
) ELSE (
	goto loginandpush
)

:createzip
echo Creating archive for Windows...
del "%basepath%\Windows.zip"
%zippath% a -mm=Deflate -mfb=258 -mpass=15 -mx=9 -r "%basepath%\Windows.zip" "%winpath%/*"
echo.

echo Creating archive for Linux...
del "%basepath%\Linux.zip"
%zippath% a -mm=Deflate -mfb=258 -mpass=15 -mx=9 -r "%basepath%\Linux.zip" "%linuxpath%/*"
echo.

:loginandpush
echo Attempting to login to itch.io...
%butlerpath% login

echo.

echo Attempting to push builds...
%butlerpath% push "%basepath%\Windows.zip" %upload%:windows
%butlerpath% push "%basepath%\Linux.zip" %upload%:linux
echo.

ping localhost > nul
ping localhost > nul
ping localhost > nul
ping localhost > nul
ping localhost > nul

start "" "https://%user%.itch.io/%game%"