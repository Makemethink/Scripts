@echo off

setlocal enabledelayedexpansion

REM @author   : Anonymous
REM @usecase  : This will enumerate necessary registry hive/path and retrive the user accounts for you

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
echo Printing the Logged-in User accounts
echo ------------------------------------

REM Looping through HKEY_USERS 
for /f "tokens=*" %%i in ('reg query HKEY_USERS ^| findstr /r /c:"HKEY_USERS\\S-1-5-21-"') do (
    set "UserProfile=%%i"
    
    REM Extract the SID
    set "SID=!UserProfile:HKEY_USERS\=!"
    
    REM Excluding system profiles (S-1-5-20 -> NetworkService)
	REM and (S-1-5-18 -> LocalSystem) and (S-1-5-21 -> User account)

	for /f "tokens=2,*" %%a in ('reg query "!UserProfile!\Volatile Environment" /v USERNAME 2^>nul ^| find "USERNAME"') do (
		set "UserName=%%b"
		
		echo # UserName : !UserName! and SID : !SID!		
	)
)
echo.
echo Printing User accounts (Logged-in / Logged-out User accounts)
echo -------------------------------------------------------------

REM Looping through HKEY_LOCAL_MACHINE
for /f "tokens=*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" ^| findstr /r /c:"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList\\S-1-5-21-"') do (
    set "UserProfile=%%i"
	
	REM Excluding system profiles (S-1-5-20 -> NetworkService)
	REM and (S-1-5-18 -> LocalSystem) and (S-1-5-21 -> User account)

	for /f "tokens=2,*" %%a in ('reg query "!UserProfile!" /v ProfileImagePath 2^>nul ^| find "ProfileImagePath"') do (
		set "ProfileImagePath=%%b"
		
		REM C:\Users\Swami
		for /f "tokens=3 delims=\" %%A in ("!ProfileImagePath!") do (
			set keyword=%%A
		)			
		echo # UserName : !keyword!
	)
)

endlocal