@echo off 
setlocal enabledelayedexpansion

set projectname=MyApp

echo Node 
cmd /c node --version 
if %errorlevel% == 1 goto end

echo Grunt 
cmd /c grunt --version
if %errorlevel% == 1 goto end

echo Bower 
cmd /c bower --version
if %errorlevel% == 1 goto end

echo Yeoman 
cmd /c yo --version
rem if %errorlevel% == 1 goto end

echo Shutdown currently running instance....
taskkill /F /IM node.exe
echo.
rem update bower packages 
cmd /c bower update
echo Updated Bower Dependency
rem update npm packages
cmd /c npm update  
echo Update NPM Dependency

rem build and deploy 
echo.
echo Build Type: %1
rem grunt clean build:%1
rem cmd /c "grunt clean build:%1"
cmd /c "start grunt serve:%1"

echo.
echo Error %errorlevel%
if  %errorlevel% == 0 (
rem	goto loop
	echo Looks everything going fine...	
) else (
	goto failed
)

rem check periodically server stated 
set /A count = 1
:loop
	echo Waiting for server......
	FOR /F "tokens=5 delims= " %%P IN ('netstat -ano ^| findstr 3000') DO (
		echo Server Started Successfully.... 
		goto pass
	)
	
	if %count% == 15 (
		echo Error: Server not started....
		goto failed
	) else (
		ping localhost -n 11 > nul
		set /A count = %count% + 1
		goto loop
	)
	

:pass
echo Success....
goto end

:failed
echo Error:.....Failed.......

:end
echo.
echo Task Finished.....
exit
