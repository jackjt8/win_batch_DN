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
			ECHO ### ERROR Wrong input - expected hdr but got albedo
			GOTO Break
		)
		ECHO %~n1 | FINDSTR /C:".normal" >nul && (
			ECHO ### ERROR Wrong input - expected hdr but got normal
			GOTO Break
		)
		ECHO %~n1 | FINDSTR /C:".denoised" >nul && (
			ECHO ### ERROR Wrong input - expected hdr but got a denoised image
			GOTO Break
		)
		REM check input done
		
		%dn_path% -i "%1" -o "%~n1_dn%~x1"
		REM %dn_path2% -i %1 -o %~n1_dn%~x1
		SHIFT
	IF NOT "%1"=="" (GOTO loop) ELSE (GOTO Break)
REM you should not end up here. If the following message shows I messed up.
ECHO ### ERROR missed postdenoise and loop/break point
GOTO Break	


:PNGerror
ECHO ### ERROR %1
ECHO ### Is not a .png (or this script broke)

:Break
ECHO .
ECHO == END ==
ECHO .
PAUSE

