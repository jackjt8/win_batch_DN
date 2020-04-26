@ECHO off

REM Get and setup
REM
REM Intel Open Image Denoise Binary Packages (CPU must support SSE4.1)
REM			https://github.com/DeclanRussell/IntelOIDenoiser
REM
REM Change dn_path to the location of denoise.exe
REM 	ie ...\oidn-1.2.0.x64.vc14.windows\bin\denoise.exe
REM
REM Drag and drop one or more .pfm files onto this .bat file to denoise them.

set dn_path="D:\Programs\oidn-1.2.0.x64.vc14.windows\bin\denoise.exe"

:Loop
IF "%1"=="" GOTO Continue
	:loop
		IF NOT "%~x1"==".pfm" GOTO PFMerror
		REM %~x1 for filename
		ECHO ===
		ECHO Input %~n1
		ECHO Output %~n1_dn%~x1
		ECHO ===
		DIR /b /a-d %~dp1%~n1*%~x1 > %temp%\pfmFileList
		FIND %temp%\pfmFileList ".albedo.">nul
		REM notfound else found
		if errorlevel 1 (GOTO denoise_h) else (
			FIND %temp%\pfmFileList ".normal.">nul
			if errorlevel 1 (GOTO denoise_ha) else (GOTO denoise_han)
		)

		:postdenoise
		DEL %temp%\pfmFileList
		SHIFT
	IF NOT "%1"=="" GOTO loop
SHIFT
GOTO loop	

:denoise_h
ECHO Found hdr
%dn_path% -hdr %1 -o %~dp1%~n1_dn%~x1
GOTO postdenoise

:denoise_ha
ECHO Found HDR and Albedo
%dn_path% -hdr %1 -o %~dp1%~n1_dn%~x1 -alb %~dp1%~n1.albedo%~x1
GOTO postdenoise

:denoise_han
ECHO Found HDR, Albedo, and Normal
%dn_path% -hdr %1 -o %~dp1%~n1_dn%~x1 -alb %~dp1%~n1.albedo%~x1 -nrm %~dp1%~n1.normal%~x1
GOTO postdenoise


:PFMerror
ECHO ### ERROR %1
ECHO ### Is not a .pfm (or this script broke)

:Continue
ECHO .
ECHO == END ==
ECHO .
PAUSE