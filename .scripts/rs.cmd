@echo off
setlocal
REM [ tiny || secure || rsync-based || fast ] redundant storage handler
REM This is rather a technology demo to see what a native CMD 5.1 shell can do

REM Make sure %HOME% is set
if not exist "%HOME%" (
	echo HOME unset - can't continue.
	goto :EOF
)

REM Selfcall for delayed var extension
if not "%1"=="delayedVarExt" (
	cmd /V:ON /C "%0 delayedVarExt %*"
	goto :EOF
)

set sync_options=-auvz -F
set defaultExcludes=%HOME%\.rsync-filter

for %%p in (%*) do (
	if "%%p"=="M" (
		set sync_options=!mirror_options!
		if "!direction!"=="" set direction="DOWN"
	) else if "%%p"=="UP" (
		set direction=UP
	) else if "%%p"=="DOWN" (
		set direction=DOWN
	) else if "%%p"=="DRY" (
		set sync_options=%sync_options% -n
	) else (
		if not "%%p"=="delayedVarExt" (
			set param=%%p
			if "!param:~0,1!"=="-" (
				set sync_options=!sync_options! !param!
			) else (
				set hosts=!hosts!%%p 
			)
		)
	)
)
if "%direction%"=="" set direction=UP DOWN
if "%CD%"=="%HOMEDRIVE%%HOMEPATH%" set sync_options=!sync_options! --exclude=/*

REM Sync each host with localhost
for %%h in (!hosts!) do (
	set h=%%h
	
	REM # Skip myself
	if not "%%h" == "%COMPUTERNAME%" (
		REM Aaaand... ACTION!
		call :doRsync %direction%
	)
)
goto :EOF


:doRsync
	set source=%CD%
	set target=!h!
	
	REM Syncing to remote host? 
	if not exist !h! (
		REM Tunnel via ssh
		set sync_options=!sync_options! -e ssh
		
		REM Sync remote home (absolute path may differ)
		REM local target=$target":~${PWD##~}"
		set target=!target!:~!CD:%home%=/!
		
		set source=!source:\=/!
		set source='/cygdrive/!source::=!'
	)

	for %%d in (%*) do (
		if "%%d"=="DOWN" (
			set source=!target!
			set target=%CD%
		)
		
		echo call :findFilter "!target!" "!source!"
		call :findFilter "!target!" "!source!"
		if not "%ERRORLEVEL%"=="0" exit
		
		set source1=!source!
		set target1=!target!
		if exist !h! (
		REM Path convertions
		set source1=!source:\=/!
		set source1=/cygdrive/!source::=!
		
		set target1=!target:\=/!
		set target1=/cygdrive/!target::=!
		)
		
		set target1=!target1:'=!
		set source1=!source1:'=!
		set target1=!target1:\=/!
		set source1=!source1:\=/!
		
		
		echo rsync -F --filter='. !defaultExcludes!' --filter='. !profile!' !sync_options! '!source1!/' '!target1!'
		if not "%ERRORLEVEL%"=="0" exit
			
	)
goto :EOF

:findFilter
	for %%p in (%*) do (
		set profile=%%p
	
		set profile=!profile:"=!
		set profile=!profile:'=!

		echo !profile! | findstr "~" > nul && (
			set profile=!profile::= !
			for /F "delims= " %%s in ("!profile!") do set profile=%%s
			set profile=!profile:@= !
		)
		
		REM Catch localhost paths
		if !profile!=="%CD%" set profile=%COMPUTERNAME%
		
		set profile=!profile:\= !
		set profile=!profile:/= !
		for %%s in (!profile!) do set profile=%%s
		
		set profile=%HOME%\.!profile!-filter

		set profile=!profile::=!
		
		if exist '!profile!' goto :EOF
		
		echo !profile!
	)
	echo No Filter found
exit






REM Parameter processing


for %%h in (!hosts!) do (
	REM Cygwin path conversation
	set local=%CD%
	set local=!local:\=/!
	set local=/cygdrive/!local::=!

	set remote=%%h:%CD%
	set remote=!remote:%HOMEDRIVE%%HOMEPATH%=~/!
	if "%HOMEDRIVE%%HOMEPATH%"=="%CD%" (
		set local=!local:~0,-1!
		set remote=!remote:~0,-1!
	)
	
	echo %direction% | findstr UP > nul && (
		echo "%COMPUTERNAME% => %%h"
		call :findProfile %%h %COMPUTERNAME%
		call :Rsync !local! !remote!
	)
	echo %direction% | findstr DOWN > nul && (
		echo "%%h => %COMPUTERNAME%"
		call :findProfile %COMPUTERNAME% %%h
		call :Rsync !remote! !local!
	)
)
goto :EOF

:findProfile
	for %%i in (%*) do (
		set profile=%%i
		set profile=%HOMEDRIVE%%HOMEPATH%\.!profile!-filter
		
		if exist !profile! (
			REM set profile=!profile:\=/!
			REM set profile=/cygdrive/!profile::=!
			goto :EOF
		)
	)
	echo "No profile found, quitting..."
	exit

:Rsync
	rsync -F --filter='. '%defaultExcludes% --filter='. '!profile! !sync_options! -e ssh %1/ %2
	if not "%ERRORLEVEL%"=="0" exit %ERRORLEVEL%
	goto :EOF
