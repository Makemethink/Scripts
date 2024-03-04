@echo off

REM @echo off will turn off Command Echo in Batch Scripting
REM if this is not present then each and every command which is getting execuated will display in console
REM So, to prevent this we initialize this @echo off

echo Program Starts ...

REM The echo command will display / print the words we specify with it
echo Hello, World! 

REM This timeout command will pause the flow of execution for specified time here it was 5 seconds
timeout /t 5

echo Changing the title of current console window
TITLE My First Script

REM This timeout command is same as above but user cann't bypass this
timeout /t 5 /nobreak

echo Displaying the version of windows
VER

echo Opening Notepad via Script
start notepad

echo Display the current time : %TIME%

echo Program Ends ...

REM This pause command stops the flow and wait for user intervention. If you double click and run a .bat file, 
REM this will prevent it from closing ..
pause 

