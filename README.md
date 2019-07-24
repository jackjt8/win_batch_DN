# Windows Drag'n'drop Batch Denoiser
## Using Declan Russell's IntelOIDenoiser and/or NvidiaAIDenoiser to achieve Denoising.
---

### Setup

1. Download and setup one or both of following (assuming you meet the requirements):

      [IntelOIDenoiser (CPU must support SSE4.1)](https://github.com/DeclanRussell/IntelOIDenoiser)

      OR

      [NvidiaAIDenoiser (Maxwell GPU or newer architecture with 418.xx or newer driver)](https://github.com/DeclanRussell/NvidiaAIDenoiser)


2. Edit the following line to reflect the actual location on your computer: ` SET dn_path="C:\Denoiser_v2.3\Denoiser.exe" `

(Optional) Uncomment both occurences and set `dn_path2` if you wish to compare both denoisers.

---

### Usage

1. Ensure there are **no** spaces in the image file name.

2. Drag and drop one or more .pngs onto this .bat file to denoise them.
