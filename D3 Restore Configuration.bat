@echo off
c:
cls

set NASIP=192.168.1.254
set NASPATH=Product QC\d3\PRG
set MSPATH=PRG
set INSTPATH=Software Releases
set RESTPATH=Restore_v5.0

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!!!IMPORTANT!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~ SET LANGUAGE in Control Panel to ENGLISH ~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Run As Administrator ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~ BEFORE running this script or it will FAIL ~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PAUSE
CLS

echo Is this a "4x2" "4x4" "VX4" or "GX2"?
set /p type=
IF '%type%'=='2.5' SET DRV=D
IF '%type%'=='4x2' SET DRV=D
IF '%type%'=='4X2' SET DRV=D
IF '%type%'=='4x4' SET DRV=D
IF '%type%'=='4X4' SET DRV=D
IF '%type%'=='gx2' SET DRV=D
IF '%type%'=='GX2' SET DRV=D
IF '%type%'=='vx4' SET DRV=D
IF '%type%'=='VX4' SET DRV=D
IF '%type%'=='2.5' GOTO :netcheckask
IF '%type%'=='4x2' GOTO :netcheckask
IF '%type%'=='4X2' GOTO :netcheckask
IF '%type%'=='4x4' GOTO :netcheckask
IF '%type%'=='4X4' GOTO :netcheckask
IF '%type%'=='gx2' GOTO :netcheckask
IF '%type%'=='GX2' GOTO :netcheckask
IF '%type%'=='vx4' GOTO :netcheckask
IF '%type%'=='VX4' GOTO :netcheckask
IF '%type%'=='shares' GOTO :SHARES
IF '%type%'=='SHARES' GOTO :SHARES
GOTO :END

:netcheckask
cls
echo Please connect to the Media Network and ensure the IP is set to a 192.168.0.xxx.
echo DO YOU WANT TO PROCESS NETWORK COPY "Y" YES OR "N" NO?
set /p skip=
if '%skip%'=='n' goto :continue
if '%skip%'=='N' goto :continue

:netcheck
for /f %%a IN ('ping %NASIP% -n 2 ^| find /c "TTL"') DO set one=%%a
IF '%one%'=='2' CALL :xcopy
IF '%one%'=='0' GOTO :please

:continue
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Desktop Icons ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu /v {59031a47-3f72-44a7-89c5-5595fe6b30ee} /t REG_DWORD /D 00000000 /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /D 00000000 /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu /v {645FF040-5081-101B-9F08-00AA002F954E} /t REG_DWORD /D 00000000 /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu /v {F02C1A0D-BE21-4350-88B0-7367FC96EF3C} /t REG_DWORD /D 00000000 /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu /v {5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0} /t REG_DWORD /D 00000000 /f

REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {59031a47-3f72-44a7-89c5-5595fe6b30ee} /t REG_DWORD /D 00000000 /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /D 00000000 /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {645FF040-5081-101B-9F08-00AA002F954E} /t REG_DWORD /D 00000000 /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {F02C1A0D-BE21-4350-88B0-7367FC96EF3C} /t REG_DWORD /D 00000000 /f
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0} /t REG_DWORD /D 00000000 /f

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\d3 Tools.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "D:\PRG" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\d3 projects.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "D:\d3 projects" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

%DRV%:
MD %DRV%:\PRG
attrib +H "%DRV%:\PRG"
CALL :NETCNFG

:d3install
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ d3 Software Install ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%DRV%:
cd "%DRV%:\%MSPATH%\PRG - D3 Software\%INSTPATH%\"
IF '%type%'=='2.5' GOTO :inst2.5
IF '%type%'=='4x2' GOTO :instx64
IF '%type%'=='4X2' GOTO :instx64
IF '%type%'=='4x4' GOTO :instx64
IF '%type%'=='4X4' GOTO :instx64
IF '%type%'=='gx2' GOTO :instx64
IF '%type%'=='GX2' GOTO :instx64
IF '%type%'=='vx4' GOTO :instx64
IF '%type%'=='VX4' GOTO :instx64
:inst2.5
for /f "tokens=5" %%a IN ('dir ^| find /I "win32"') DO if not defined d3 SET d3=%%a
goto :inst
:instx64
for /f "tokens=5" %%a IN ('dir ^| find /I "x64"') DO if not defined d3 SET d3=%%a
:inst
echo Installing D3 Software %d3%...
%d3%

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Taskbar Icons ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
xcopy /d /e /c /i /h /q /k /y "%DRV%:\%MSPATH%\PRG - D3 Software\%RESTPATH%\TaskBar_4x4" "C:\Users\d3\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
regedit /s "%DRV%:\%MSPATH%\PRG - D3 Software\%RESTPATH%\TaskBar_4x4.reg"
pause
:SHARES
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Network Shares ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
MD %DRV%:\DROP
c:
cd c:\users\%username%\desktop
net share "d3 projects_%computername%"="%DRV%:\d3 projects" /grant:everyone,FULL
net share "d3 Projects" /delete
icacls "d:\d3 projects" /grant Everyone:(OI)(CI)F

net share "DROP_%computername%"="%DRV%:\DROP" /grant:everyone,FULL
icacls "d:\DROP" /grant Everyone:(OI)(CI)F
GOTO :FIN


:xcopy
explorer \\%NASIP%
%DRV%:
cd "%DRV%:\%MSPATH%"
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~ Please Login to run network copy ~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pause
MD %DRV%:\PRG
pause
xcopy /d /e /c /i /h /k /y "\\%NASIP%\%NASPATH%" "%DRV%:\%MSPATH%\"
xcopy /d /c /i /k /y "\\%NASIP%\Working\- Media Server Files\PRG MEDIA SERVERS\PRG Quick Support.exe" "%DRV%:\PRG\"
xcopy /d /e /c /i /h /k /y "%DRV%:\%MSPATH%\d3 Projects" "%DRV%:\d3 Projects"
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Copy Complete ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pause
set /p clear=Do you want to clean the d3 Projects folder "Y" or "N"?
IF '%clear%'=='n' GOTO :skip
IF '%clear%'=='N' GOTO :skip
robocopy "%DRV%:\%MSPATH%\PRG - D3 Software\d3 Projects" "%DRV%:\d3 Projects" /MIR
:skip
robocopy /"\%NASIP%\%NASPATH%/" "%DRV%:\%MSPATH%" /MIR
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Mirroring complete ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pause 
GOTO :END

:please
cls
echo ~~~~~~~~~~~~~~~~ Network connection not configured correctly ~~~~~~~~~~~~~~~~
echo Please connect to the Media Network and ensure the IP is set to a 192.168.0.xxx.
echo DO YOU WANT TO PROCESS NETWORK COPY "Y" YES OR "N" NO?
set /p skip=
if '%skip%'=='n' GOTO :continue
if '%skip%'=='N' GOTO :continue
if '%skip%'=='y' GOTO :netcheck
if '%skip%'=='Y' GOTO :netcheck
GOTO :END

:FIN
pause
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~ You will be logged off ~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~ Please log back on by clicking the D3 user to finish setup ~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pause
logoff
exit

:NETCNFG
IF '%type%'=='vx4' GOTO :SKIPNETCNFG
IF '%type%'=='VX4' GOTO :SKIPNETCNFG
IF '%type%'=='4x2' GOTO :SKIPNETCNFG
IF '%type%'=='4X2' GOTO :SKIPNETCNFG
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~ Configuring 10GBE NICS, ~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~ Please wait for network connectivity before continuing ~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%DRV%:
powershell.exe -ExecutionPolicy Bypass -command "& '%DRV%:\%MSPATH%\PRG - D3 Software\%RESTPATH%\NetworkConfig.ps1'"
pause
:SKIPNETCNFG

:END

