@echo off

REM @author   : Anonymous
REM @usecase  : This will loop current directory recursivly and get mentioned file format 
REM             inside the subfolders and insert those names into index.txt 

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

REM Creating new text file named index 
type nul > index.txt

REM looping current directory recursivly to get files inside the subfolders too
for /R "%cd%" %%G IN (*.bat) do (
	REM using ~nx to get only filename with extension and storing it into the file
    echo %%~nxG >> index.txt
	echo. >> index.txt
)

echo The index file created successfully ...

REM These are the batch modifiers ..

:: %~f - expands a variable or parameter to the fully qualified path.
:: %~d - expands a variable or parameter to the drive letter only.
:: %~p - expands a variable or parameter to the path only.
:: %~n - expands a variable or parameter to the file name only.
:: %~x - expands a variable or parameter to the file extension only.
:: %~s - expands a variable or parameter to the short 8.3 format.
:: %~a - expands a variable or parameter to the file attributes.
:: %~t - expands a variable or parameter to the file date and time.
:: %~z - expands a variable or parameter to the file size.
:: %~dp - expands a variable or parameter to the drive letter and path.
:: %~nx - expands a variable or parameter to the file name with extension.
