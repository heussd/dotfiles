@echo off
setlocal EnableDelayedExpansion

echo Detecting Windows version...
for /f "tokens=2 delims=[]" %%i in ('ver') do set WINVER=%%i 
echo %WINVER% | findstr "5.1" > nul && set OS=XP

if "%OS%"=="" echo Unknown Windows version. Quitting... && goto :EOF
if not "%OS%"=="XP" echo Please execute me under Windows XP only. Quitting... && goto :EOF

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" && set ISADMIN=y
if not "%ISADMIN%"=="y" echo Please execute me as admin. Quitting... && goto :EOF


echo Label the systemdrive
label %SYSTEMDRIVE% System

echo NTFS compressing system drive...
REM compact /C /S:%SYSTEMDRIVE% /F /I

echo Enable Win2k compatibility mode
regsvr32 %systemroot%\apppatch\slayerui.dll

echo Tune file system
fsutil behavior set disable8dot3 1
fsutil behavior set allowextchar 1
fsutil behavior set disablelastaccess 1

echo Disable network task search
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}" /va /f

echo Disable network printer search
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{2227A280-3AEA-1069-A2DE-08002B30309D}" /va /f

echo Disable IE precache
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SharedTaskScheduler" /va /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SharedTaskScheduler"

echo Auto hide taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects2\" /ve /t REG_BINARY /v settings /d 06

echo Disable various services
sc config ERSvc start= disabled
sc config HidServ start= disabled
sc config SSDPSRV start= disabled
sc config RemoteRegistry start= disabled
sc config cisvc start= disabled
sc config MSDTC start= disabled
sc config RemoteAccess start= disabled
sc config TlntSvr start= disabled
sc config messenger start= disabled

echo Disable Security Center
sc config wscsvc start= disabled


set /P q=Remove needless stuff? (y/*) && if "%q%"=="y" (
	rd /s /q "%ProgramFiles%\cmak"
	rd /s /q "%ProgramFiles%\Internet Explorer\Connection Wizard"
	rd /s /q "%ProgramFiles%\Internet Explorer\SIGNUP"
	rd /s /q "%windir%\Application Compatibility Scripts"
	del /s /f /q "%windir%\inf\*.pnf"
	REM rd /s /q "%windir%\Media"
	rd /s /q "%windir%\msagent"
	rd /s /q "%windir%\mui"
	rd /s /q "%windir%\Offline Web Pages"
	rd /s /q "%windir%\TPE2"
	rd /s /q "%windir%\Web"
	rd /s /q "%windir%\system32\administration"
	del /s /f /q "%windir%\clock.avi"
	del /s /f /q "%windir%\*.tmp"
	del /s /f /q "%windir%\*.log"
	del /s /f /q "%windir%\*.bak"
	del /s /f /q "%windir%\*.old"
	del /s /f /q "%windir%\*log*.txt"

	reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{44BBA840-CC51-11CF-AAFA-00AA00B6015C}" /va /f
	reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{7790769C-0471-11d2-AF11-00C04FA35D02}" /va /f
)

set reg=%TEMP%\setup.reg
>%reg% echo Windows Registry Editor Version 5.00

if "%COMPUTERNAME%"=="DOTHAN" (
	echo Patch japanese keyboard to make it more usable
	>>%reg% echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Keyboard Layout]
	>>%reg% echo "Scancode Map"=hex:00,00,00,00,00,00,00,00,02,00,00,00,56,00,73,00,00,00,00,00
)

REM echo Set places
REM >>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar]
REM >>%reg% echo "Place0"=dword:00000000

echo Disable link prefix
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
>>%reg% echo "Link"=hex:00,00,00,00

echo Disable Dr. Watson, "drwtsn32 -i" to reactivate
>>%reg% echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\AeDebug]

echo Disable desktop cleanup wizard
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\CleanupWiz]
>>%reg% echo "NoRun"=dword:00000001
>>%reg% echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
>>%reg% echo "NoDesktopCleanupWizard"=dword:00000001
>>%reg% echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
>>%reg% echo "NoDesktopCleanupWizard"=dword:00000001

echo Disable cleanup manager
>>%reg% echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\cleanuppath]
>>%reg% echo @=-

echo Disable Windows Tour
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Applets\Tour]
>>%reg% echo "RunCount"=dword:00000000
>>%reg% echo [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Applets\Tour]
>>%reg% echo "RunCount"=dword:00000000

echo Disable Internet Open With
>>%reg% echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system]
>>%reg% echo "NoInternetOpenWith"=dword:00000001

echo Move recycle bin
>>%reg% echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{645FF040-5081-101B-9F08-00AA002F954E}]
>>%reg% echo @="Recycle Bin"
>>%reg% echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{645FF040-5081-101B-9F08-00AA002F954E}]

echo Show full address path in explorer
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState]
>>%reg% echo "FullPathAddress"=dword:00000001

echo Show details in explorer
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams]
>>%reg% echo "Settings"=hex:09,00,00,00,04,00,00,00,01,00,00,00,00,77,7e,13,73,35,cf,11,ae,69,08,00,2b,2e,12,62,04,00,00,00,06,00,00,00,43,00,00,00

echo Show all file extensions
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
>>%reg% echo "HideFileExt"=dword:00000000

echo Hide icons from classic desktop
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu]
>>%reg% echo "{450D8FBA-AD25-11D0-98A8-0800361B1103}"=dword:00000001
>>%reg% echo "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"=dword:00000001
>>%reg% echo "{208D2C60-3AEA-1069-A2D7-08002B30309D}"=dword:00000001
>>%reg% echo "{871C5380-42A0-1069-A2EA-08002B30309D}"=dword:00000001


echo Disable error reporting
>>%reg% echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PCHealth\ErrorReporting]
>>%reg% echo "AllOrNone"=dword:00000002
>>%reg% echo "IncludeMicrosoftApps"=dword:00000000
>>%reg% echo "IncludeWindowsApps"=dword:00000000
>>%reg% echo "IncludeKernelFaults"=dword:00000000
>>%reg% echo "DoReport"=dword:00000000
>>%reg% echo "ShowUI"=dword:00000000

echo Disable beeps
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Sound]
>>%reg% echo "Beep"="no"
>>%reg% echo "ExtendedSounds"="no"


echo Disable system folder barricade
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
>>%reg% echo "WebViewBarricade"=dword:00000001

echo Disable accessibility features
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility]
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\Blind Access]
>>%reg% echo "On"="0"
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\HighContrast]
>>%reg% echo "On"="0"
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Preference]
>>%reg% echo "On"="0"
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response]
>>%reg% echo "On"="0"
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\MouseKeys]
>>%reg% echo "On"="0"
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\ShowSounds]
>>%reg% echo "On"="0"
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\SoundSentry]
>>%reg% echo "On"="0"
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys]
>>%reg% echo "On"="0"
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\TimeOut]
>>%reg% echo "On"="0"
>>%reg% echo [HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys]
>>%reg% echo "On"="0"

echo Remove help from start menu
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
>>%reg% echo "NoSMHelp"=dword:1

echo Remove OEM link from start menu 
>>%reg% echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
>>%reg% echo "Start_ShowOEMLink"=dword:00000000

REM echo Disable user tracking
REM >>%reg% echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
REM >>%reg% echo "NoInstrumentation"=dword:00000001

REM echo Disable recent docs
REM >>%reg% echo [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
REM >>%reg% echo "NoRecentDocsHistory"=dword:1
REM >>%reg% echo "NoRecentDocsMenu"=dword:1

echo Disable cd burning
>>%reg% echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
>>%reg% echo "NoCDBurning"=dword:00000001

echo Allow burning with user permissions
>>%reg% echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]
>>%reg% echo "allocatecdroms"="1"
>>%reg% echo "allocatedasd"="2"

echo enable NTLMv2, deny LM-NTLM.reg (restricts to Clients: XP SP1, Win2k3, RIS: Win2k3 ;DC: Win2k (SP?), Win2k3)
>>%reg% echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
>>%reg% echo "lmcompatibilitylevel"=dword:00000005

echo enable secure NTLM for SAM
>>%reg% echo [HKEY_LOCAL_MACHINE\SYSTEM\\CurrentControlSet\\Control\\Lsa]
>>%reg% echo "nolmhash"=dword:1

echo Disable Help service
>>%reg% echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\helpsvc]
>>%reg% echo "Start"=dword:00000004

echo Autostart sec logon
>>%reg% echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\seclogon]
>>%reg% echo "Start"=dword:00000002

echo Make Windows Update less pushy
>>%reg% echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]
>>%reg% echo "NoAutoRebootWithLoggedOnUsers"=dword:00000001
>>%reg% echo "AutoInstallMinorUpdates"=dword:00000001
>>%reg% echo "RebootRelaunchTimeoutEnabled"=dword:00000001
>>%reg% echo "RebootRelaunchTimeout"=dword:000005a0
>>%reg% echo "RebootWarningTimeoutEnabled"=dword:00000001
>>%reg% echo "RebootWarningTimeout"=dword:0000001e

echo Disable BSOD auto reboot
>>%reg% echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl]
>>%reg% echo "AutoReboot"=dword:00000000

echo Enable commandline prompt from context menu
>>%reg% echo [HKEY_CLASSES_ROOT\Folder\shell\cmd]
>>%reg% echo @="&Commandline prompt"
>>%reg% echo [HKEY_CLASSES_ROOT\Folder\shell\cmd\command]
>>%reg% echo @="cmd.exe %1"

echo.
findstr /R ".*" %reg%
echo.
set /P execRegistry=Apply registry patches? (y/*)
if "%execRegistry%"=="y" (
	regedit /S %reg%
	
	echo reset password to force new hash mechanism
	net user %USERNAME% ""
)

REM UNTESTED!
echo Download essential software
start http://sourceforge.net/projects/sevenzip/files/latest/download



shutdown -r -t 0
