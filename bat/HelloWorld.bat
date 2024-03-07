@echo off

REM @echo off will turn off Command Echo in Batch Scripting
REM if this is not present then each and every command which is getting execuated will display in console
REM So, to prevent this we initialize this @echo off

::  The double colon "::" was used for comment 
REM  The "REM" also used to comment

echo Program Starts ...

REM The echo command will display / print the words we specify with it
echo Hello, World! 

REM This timeout command will pause the flow of execution for specified time here it was 5 seconds
timeout /t 5

echo Changing the title of current console window
TITLE My First Script

echo Listing the files/subdirectory of you current directory which cmd prompt pointing out now ..
dir

echo Displaying the version of windows
VER

echo Opening Notepad via Script
start notepad

echo Display the current time : %TIME%
echo Display the current data : %DATE%

echo Now sleep is happening but you cann't bypass it .. for 5 seconds
REM This timeout command is same as above but user cann't bypass this
timeout /t 5 /nobreak

echo Is this useful?
echo Enter Y for yes - Enter N for no
choice /c YN /m "Yes or No"

echo If you want more info about command line then type "help" in command prompt

echo Program Ends ...

REM This pause command stops the flow and wait for user intervention. If you double click and run a .bat file, 
REM this will prevent it from closing ..
pause 

