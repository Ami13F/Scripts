@echo off
setlocal ENABLEDELAYEDEXPANSION
SET LEN=%1
SET LANG=%2
SET "EXE_PATH=%3"

IF "%LANG%" == "-c" (
	SET IS_EXE="0"
	FOR /F %%i in ('where /r %EXE_PATH%\bin *.exe') DO (
		SET IS_EXE="1"						
		FOR /L %%A IN (1,1,%LEN%) DO (
			call %%i
		)
	)
)					
			
IF "%LANG%" == "-j" (	
	call %EXE_PATH%\gradlew -b %EXE_PATH%\build.gradle jar
	
	FOR /F %%i in ('where /r %EXE_PATH%\build\libs *.jar') DO (
		SET IS_EXE="1"						
		FOR /L %%A IN (1,1,%LEN%) DO (
			call %%i
		)
	)	
)