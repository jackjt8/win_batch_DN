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
IF "%1"=="" GOTO Continue
	:loop
		IF NOT "%~x1"==".png" GOTO PNGerror
		ECHO Input %~n1
		ECHO Output %~n1_dn%~x1
		REM %dn_path% -i "%1" -o "%~n1_dn%~x1"
		REM %dn_path2% -i %1 -o %~n1_dn%~x1
		SHIFT
	IF NOT "%1"=="" GOTO loop

SHIFT
GOTO Loop

:PNGerror
ECHO ### ERROR %1
ECHO ### Is not a .png (or this script broke)

:Continue
ECHO .
ECHO == END ==
ECHO .
PAUSE

