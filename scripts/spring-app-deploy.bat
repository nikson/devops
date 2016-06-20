@echo off 

REM set project name 
set projectname=MyProject
REM create temporary build folder 
set buildpath=%temp%\%projectname%
REM ports in use
set ports=80
REM project's source directory
set srcdir=C:\source\%projectname%

rem create deploy directory 
mkdir %buildpath%
rem change root dir 
pushd %buildpath%

REM if required stop previous running instance by checking the ports 
echo Searching open ports: %ports%
FOR /F "tokens=5 delims= " %%P IN ('netstat -ano ^| findstr %ports%') DO taskkill /F /PID %%P

REM wait few seconds
timeout /t 5 >nul

REM Delete old copy of build, build  echo.
echo Clear old build....
del /F /Q "%buildpath%\%projectname%.jar"

echo.
echo Copy new build...
copy /Y "%srcdir%\target\%projectname%.jar" "%projectname%.jar"

echo.
echo Starting server.......
cmd /c "start java -jar %projectname%.jar"

REM server started asynchronously, check periodically server started successfully
set /A count = 1

:loop
	echo Waiting for server......
	FOR /F "tokens=5 delims= " %%P IN ('netstat -ano ^| findstr %ports%') DO (
		echo Server Started Successfully.... 
		goto pass 
	)
	
REM wait 10*12=120 seconds
	if %count% == 12 (
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
exit /B 1 

:end
echo.
echo Task Finished.....
exit

