@echo off

REM -- Step 1: ------------------------------------------------------------
::  Goto any site which generate banner.txt (if you have any prefered site)
::  Else you can search banner.txt generator in your browser
::  Choose your text and style, then download file or copy the banner text
REM -----------------------------------------------------------------------

REM -- Step 2: ------------------------------------------------------------
::  Then paste it in the batch file and add echo statement to each file 
::  If your banner contains "|" pipe or any other symbol which have special 
::           -- meaning in batch then you banner won't look as you expected 
REM -----------------------------------------------------------------------

echo Without the escape sequence "^"
echo.
echo  .-.                 .    .   .     .    
echo (   )        o      _^_   ^   ^     ^    
echo  `-.  .-..--..  .,-. ^    ^---^.  . ^.-. 
echo (   )(   ^   ^  ^   )^    ^   ^^  ^ ^   )
echo  `-'  `-'' -' `-^`-' `-'  '   '`--`-'`-' 
echo                 ^                        
echo                 '                        

REM -- Step 2: -------------------------------------------------------------
::  For example we can take "|" the pipe symbol, it have special meaning
::  It is used to take first command and redirect the output to second --
::  syntax First command | second command ..  So we need to escape it by "^"
REM ------------------------------------------------------------------------

echo With the escape sequence "^"
echo.
echo  .-.                 .    .   .     .    
echo (   )        o      _^|_   ^|   ^|     ^|    
echo  `-.  .-..--..  .,-. ^|    ^|---^|.  . ^|.-. 
echo (   )(   ^|   ^|  ^|   )^|    ^|   ^|^|  ^| ^|   )
echo  `-'  `-'' -' `-^|`-' `-'  '   '`--`-'`-' 
echo                 ^|                        
echo                 '                        

pause