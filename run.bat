@echo off

setlocal ENABLEDELAYEDEXPANSION
set LANG=%1
set NUM_RUNS=%2
set PROJ_PATH=%3
set EXE_PATH=%PROJ_PATH%

if %LANG%==-help (
	echo "1st arg -> language(-j, -cpp)"
	echo "2nd arg -> num runs"
	echo "3rd arg -> project path"
	echo "ex: run.bat -j 30 sample_project/"
	goto :end
)

set argC=0
for %%x in (%*) do (
	set /A argC+=1
)

if not !argC! equ 3 (
	echo Invalid number of args.
	goto :end
)

if %LANG%==-j (
	call %PROJ_PATH%\gradlew -b %PROJ_PATH%\build.gradle jar
	for /F %%i in ('where /r %PROJ_PATH%\build\libs *.jar') DO (
		set EXE_PATH=%%i
	)
)

if %LANG%==-cpp (
	rem call vcvarsall x64
	rem call msbuild %PROJ_PATH%
	for /F %%i in ('where /r %PROJ_PATH%\bin *.exe') DO (
		set EXE_PATH=%%i
	)
)

for /L %%i IN (1,1,%NUM_RUNS%) do (
	call !EXE_PATH!
)

:end
