@echo off
setlocal ENABLEDELAYEDEXPANSION
rem call %vcvarsall x64
SET LEN=%1
SET LANG=%2
SET "EXE_PATH=%3"

IF "%LANG%" == "-c" (
	SET IS_EXE="0"
	:exe
	FOR /F %%i in ('where /r %EXE_PATH%\x64 *.exe') DO (
		SET IS_EXE="1"							
		FOR /L %%A IN (1,1,%LEN%) DO (
			call %%i
		)
	)
	IF "%IS_EXE%" == "0" (
		msbuild %3 rem daca nu exista obj il facem
		GOTO exe
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