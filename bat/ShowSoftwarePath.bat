@echo off

setlocal enabledelayedexpansion

REM @author   : Anonymous
REM @usecase  : This will enumerate and search necessary registry hive/path and retrives uninstallation string of the mentioned software
REM             The key will be searched under HKEY_LOCAL_MACHINE / HKEY_USERS (both normal and WOW6432Node)

REM --------------------------------------------------------------------------------------------------
echo.
echo  .-.                 .    .   .     .    
echo (   )        o      _^|_   ^|   ^|     ^|    
echo  `-.  .-..--..  .,-. ^|    ^|---^|.  . ^|.-. 
echo (   )(   ^|   ^|  ^|   )^|    ^|   ^|^|  ^| ^|   )
echo  `-'  `-'' -' `-^|`-' `-'  '   '`--`-'`-' 
echo                 ^|                        
echo                 '                        
REM --------------------------------------------------------------------------------------------------

echo.
echo Printing the Uninstallation string 
echo ----------------------------------

REM Get input of the software name from user
set /p SOFTWARE= Type any software(case sensitive) : 

REM System wide installed software 
set "TargetRegistryKey=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

echo.
echo -----------------------------------------------------------------------------------
REM Get uninstall information from the registry
FOR /f "tokens=*" %%i IN ('reg query "!TargetRegistryKey!" /s ^| find "!SOFTWARE!"') DO (
	SET "RegKey=%%i"

	echo !RegKey! | find "HKEY_LOCAL_MACHINE" > nul

	if !errorlevel! equ 0 (
		rem Get the DisplayName and UninstallString values
		FOR /f "tokens=2,* delims= " %%a IN ('reg query "!RegKey!" /v DisplayName ^| find "DisplayName"') DO SET "DisplayName=%%b"
		FOR /f "tokens=2,* delims= " %%a IN ('reg query "!RegKey!" /v UninstallString ^| find "UninstallString"') DO SET "UninstallString=%%b"

		if NOT "!UninstallString!"=="" (
			echo.
			echo Uninstall String of "!DisplayName!" found under HKEY_LOCAL_MACHINE 
			echo !UninstallString!
			
			set "DisplayName="
			set "UninstallString="
		)
	)
)

REM System wide installed software under WOW6432Node
set "TargetRegistryKey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

REM Get uninstall information from the registry
FOR /f "tokens=*" %%i IN ('reg query "!TargetRegistryKey!" /s ^| find "!SOFTWARE!"') DO (
	SET "RegKey=%%i"
	
	echo !RegKey! | find "HKEY_LOCAL_MACHINE" > nul
	
	if !errorlevel! equ 0 (
		rem Get the DisplayName and UninstallString values
		FOR /f "tokens=2,* delims= " %%a IN ('reg query "!RegKey!" /v DisplayName ^| find "DisplayName"') DO SET "DisplayName=%%b"
		FOR /f "tokens=2,* delims= " %%a IN ('reg query "!RegKey!" /v UninstallString ^| find "UninstallString"') DO SET "UninstallString=%%b"

		if NOT "!UninstallString!"=="" (
			echo.
			echo Uninstall String of "!DisplayName!" found under HKEY_LOCAL_MACHINE 
			echo !UninstallString!
			
			set "DisplayName="
			set "UninstallString="
		)
	)
)

REM Looping through HKEY_USERS
for /f "tokens=*" %%i in ('reg query HKEY_USERS ^| findstr /r /c:"HKEY_USERS\\S-1-5-21-"') do (
    set "UserProfile=%%i"
    
    REM Extract the SID
    set "SID=!UserProfile:HKEY_USERS\=!"
    
    REM Excluding system profiles (S-1-5-20 -> NetworkService)
	REM Need to retain (S-1-5-18 -> LocalSystem) and (S-1-5-21 -> User account)

	for /f "tokens=2,*" %%a in ('reg query "!UserProfile!\Volatile Environment" /v USERNAME 2^>nul ^| find "USERNAME"') do (
		set "UserName=%%b"		
		
		REM Constructing the registry path for the current user under HKEY_USERS
		set "CurrentUserRegistryPath=HKEY_USERS\!SID!"
		
		REM User specific installed software 
		set "TargetRegistryKey=!CurrentUserRegistryPath!\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
		
		REM Get uninstall information from the registry
		FOR /f "tokens=*" %%i IN ('reg query "!TargetRegistryKey!" /s ^| find "!SOFTWARE!"') DO (
			SET "RegKey=%%i"
			
			echo !RegKey! | find "HKEY_USERS" > nul
			if !errorlevel! equ 0 (
				rem Get the DisplayName and UninstallString values
				FOR /f "tokens=2,* delims= " %%a IN ('reg query "!RegKey!" /v DisplayName ^| find "DisplayName"') DO SET "DisplayName=%%b"
				FOR /f "tokens=2,* delims= " %%a IN ('reg query "!RegKey!" /v UninstallString ^| find "UninstallString"') DO SET "UninstallString=%%b"
		
				if NOT "!UninstallString!"=="" (
					echo.
					echo Uninstall String of "!DisplayName!" found under the user : !UserName!
					echo !UninstallString!
					
					set "DisplayName="
					set "UninstallString="
				)
			)
		)
		
		REM User specific installed software path under WOW6432Node
		set "TargetRegistryKey=!CurrentUserRegistryPath!\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

		FOR /f "tokens=*" %%i IN ('reg query "!TargetRegistryKey!" /s ^| find "!SOFTWARE!"') DO (
			SET "RegKey=%%i"
			
			echo !RegKey! | find "HKEY_USERS" > nul
			if !errorlevel! equ 0 (
				rem Get the DisplayName and UninstallString values
				FOR /f "tokens=2,* delims= " %%a IN ('reg query "!RegKey!" /v DisplayName ^| find "DisplayName"') DO SET "DisplayName=%%b"
				FOR /f "tokens=2,* delims= " %%a IN ('reg query "!RegKey!" /v UninstallString ^| find "UninstallString"') DO SET "UninstallString=%%b"

				if NOT "!UninstallString!"=="" (
					echo.
					echo Uninstall String of "!DisplayName!" found under the user : !UserName!
					echo !UninstallString!
					
					set "DisplayName="
					set "UninstallString="
				)
			)
		)

	)
)
echo.
echo -----------------------------------------------------------------------------------
echo.

endlocal