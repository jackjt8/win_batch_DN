@ECHO off
REM win_batch_DN pfm_denoiser.bat v1.0.0
REM Created by jackjt8
REM https://github.com/jackjt8/win_batch_DN
REM ~~~~

REM Get and setup
REM
REM IntelOIDenoiser (CPU must support SSE4.1)
REM			https://github.com/DeclanRussell/IntelOIDenoiser
REM OR
REM NvidiaAIDenoiser (Maxwell GPU or newer architecture with 418.xx or newer driver)
REM 		https://github.com/DeclanRussell/NvidiaAIDenoiser
REM
REM Change dn_path to the location of the denoiser.exe
REM uncomment dn_path2 if you wish to compare both denoisers.
REM
REM Drag and drop one or more .pngs onto this .bat file to denoise them.


SET dn_path="D:\Programs\oidn-Denoiser_v1.2\Denoiser.exe"
REM SET dn_path2="D:\Programs\NvAIDN_v2.4\Denoiser.exe"

:Loop
IF "%1"=="" GOTO Break
	:loop
		IF NOT "%~x1"==".png" GOTO PNGerror
		ECHO ===
		ECHO Input %~n1%~x1
		ECHO Output %~n1_dn%~x1
		ECHO ===
		REM check input
		ECHO %~n1 | FINDSTR /C:".albedo" >nul && (
			ECHO ### ERROR Wrong input - expected png but got albedo
			GOTO Break
		)
		ECHO %~n1 | FINDSTR /C:".normal" >nul && (
			ECHO ### ERROR Wrong input - expected png but got normal
			GOTO Break
		)
		ECHO %~n1 | FINDSTR /C:".denoised" >nul && (
			ECHO ### ERROR Wrong input - expected png but got a denoised image
			GOTO Break
		)
		REM check input done
		
		DIR /b /a-d %~dp1%~n1*%~x1 > %temp%\pngFileList
		FIND %temp%\pngFileList ".albedo.">nul
		if errorlevel 1 (
			REM missing albedo
			FIND %temp%\pngFileList ".normal.">nul
			if errorlevel 1 (
				REM missing normal
				GOTO denoise_h
			) else (
				REM found normal
				GOTO denoise_hn			
			)
		) else (
			REM found albedo
			FIND %temp%\pngFileList ".normal.">nul
			if errorlevel 1 (
				REM missing normal
				GOTO denoise_ha
			) else (
				REM found normal
				GOTO denoise_han
			)
		)
		REM %dn_path% -i "%1" -o "%~n1_dn%~x1"
		REM %dn_path2% -i %1 -o %~n1_dn%~x1
		
		:postdenoise
		DEL %temp%\pngFileList
		SHIFT
	IF NOT "%1"=="" (GOTO loop) ELSE (GOTO Break)
REM you should not end up here. If the following message shows I messed up.
ECHO ### ERROR missed postdenoise and loop/break point
GOTO Break	

:denoise_h
ECHO Found png
%dn_path% -i "%1" -o "%~dp1%~n1.denoised%~x1"
GOTO postdenoise

:denoise_ha
ECHO Found png and Albedo
%dn_path% -i "%1" -o "%~dp1%~n1.denoised%~x1" -a "%~dp1%~n1.albedo%~x1"
GOTO postdenoise

:denoise_hn
ECHO ### ERROR %~1 Found normal but missing albedo?
PAUSE
GOTO Break	

:denoise_han
ECHO Found png, Albedo, and Normal
%dn_path% -i "%1" -o "%~dp1%~n1.denoised%~x1" -a "%~dp1%~n1.albedo%~x1" -n "%~dp1%~n1.normal%~x1"
GOTO postdenoise

:PNGerror
ECHO ### ERROR %1
ECHO ### Is not a .png (or this script broke)

:Break
ECHO .
ECHO == END ==
ECHO .
PAUSE

