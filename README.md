# Windows Drag'n'drop Batch Denoiser
## Using Declan Russell's IntelOIDenoiser and/or NvidiaAIDenoiser to achieve Denoising.


### Setup

Download and setup either of the following:

[IntelOIDenoiser (CPU must support SSE4.1)](https://github.com/DeclanRussell/IntelOIDenoiser)

OR

[NvidiaAIDenoiser (Maxwell GPU or newer architecture with 418.xx or newer driver)](https://github.com/DeclanRussell/NvidiaAIDenoiser)


Edit the following line to reflect the actual location on your computer: ` SET dn_path="C:\Denoiser_v2.3\Denoiser.exe" `

Uncomment both occurences and set `dn_path2` if you wish to compare both denoisers.


### Usage
Drag and drop one or more .pngs onto this .bat file to denoise them.
