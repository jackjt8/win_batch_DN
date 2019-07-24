@ECHO off

REM Get and setupL
REM
REM IntelOIDenoiser (CPU must support SSE4.1)
REM			https://github.com/DeclanRussell/IntelOIDenoiser
REM OR
REM NvidiaAIDenoiser (Maxwell GPU or newer architecture with 418.xx or newer driver)
REM 		https://github.com/DeclanRussell/NvidiaAIDenoiser
REM
REM Change dn_path to location of denoiser on your computer
REM uncomment dn_path2 if you wish to compare both denoisers.
REM
REM Drag and drop one or more .pngs onto this .bat file to denoise them.


SET dn_path="C:\Denoiser_v2.3\Denoiser.exe"
REM SET dn_path2="C:\Denoiser_v1.1\Denoiser.exe"

:Loop
IF "%1"=="" GOTO Continue

	FOR /F "tokens=1,2 delims=." %%a IN ("%1") DO (
		ECHO Input %1
		ECHO Output %%a_dn.%%b
		%dn_path% -i %1 -o %%a_dn.%%b
		REM %dn_path2% -i %1 -o %%a_dn2.%%b   		
	)

SHIFT
GOTO Loop
:Continue

ECHO .
ECHO == END ==
ECHO .
PAUSE

