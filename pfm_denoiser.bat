@ECHO off
REM win_batch_DN pfm_denoiser.bat v1.0.0
REM Created by jackjt8
REM https://github.com/jackjt8/win_batch_DN
REM ~~~~

REM Get and setup
REM
REM Intel Open Image Denoise Binary Packages (CPU must support SSE4.1)
REM			https://github.com/DeclanRussell/IntelOIDenoiser
REM
REM Change dn_path to the location of denoise.exe
REM 	ie ...\oidn-1.2.0.x64.vc14.windows\bin\denoise.exe
REM
REM Drag and drop one or more .pfm files onto this .bat file to denoise them.

SET dn_path="D:\Programs\oidn-1.2.0.x64.vc14.windows\bin\denoise.exe"

:Loop
IF "%1"=="" GOTO Break
	:loop
		IF NOT "%~x1"==".pfm" GOTO PFMerror
		ECHO ===
		ECHO Input %~n1%~x1
		ECHO Output %~n1.denoised%~x1
		ECHO ===
		REM check input
		ECHO %~n1 | FINDSTR /C:".albedo" >nul && (
			ECHO ### ERROR Wrong input - expected hdr but got albedo
			GOTO Break
		)
		ECHO %~n1 | FINDSTR /C:".normal" >nul && (
			ECHO ### ERROR Wrong input - expected hdr but got normal
			GOTO BREAK
		)
		ECHO %~n1 | FINDSTR /C:".denoised" >nul && (
			ECHO ### ERROR Wrong input - expected hdr but got a denoised image
			GOTO BREAK
		)
		REM check input done
		
		DIR /b /a-d %~dp1%~n1*%~x1 > %temp%\pfmFileList
		FIND %temp%\pfmFileList ".albedo.">nul
		if errorlevel 1 (
			REM missing albedo
			FIND %temp%\pfmFileList ".normal.">nul
			if errorlevel 1 (
				REM missing normal
				GOTO denoise_h
			) else (
				REM found normal
				GOTO denoise_hn			
			)
		) else (
			REM found albedo
			FIND %temp%\pfmFileList ".normal.">nul
			if errorlevel 1 (
				REM missing normal
				GOTO denoise_ha
			) else (
				REM found normal
				GOTO denoise_han
			)
		)

		:postdenoise
		DEL %temp%\pfmFileList
		SHIFT
	IF NOT "%1"=="" (GOTO loop) ELSE (GOTO Break)
	
REM you should not end up here. If the following message shows I messed up.
ECHO ### ERROR missed postdenoise and loop/break point
GOTO Break	

:denoise_h
ECHO Found hdr
%dn_path% -hdr "%1" -o "%~dp1%~n1.denoised%~x1"
GOTO postdenoise

:denoise_ha
ECHO Found HDR and Albedo
%dn_path% -hdr "%1" -o "%~dp1%~n1.denoised%~x1" -alb "%~dp1%~n1.albedo%~x1"
GOTO postdenoise

:denoise_hn
ECHO ### ERROR %~1 Found normal but missing albedo?
PAUSE
GOTO Break	

:denoise_han
ECHO Found HDR, Albedo, and Normal
%dn_path% -hdr "%1" -o "%~dp1%~n1.denoised%~x1" -alb "%~dp1%~n1.albedo%~x1" -nrm "%~dp1%~n1.normal%~x1"
GOTO postdenoise

:PFMerror
ECHO ### ERROR %1
ECHO ### Is not a .pfm (or this script broke)

:Break
ECHO .
ECHO == END ==
ECHO .
PAUSE


