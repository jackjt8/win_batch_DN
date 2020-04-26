# Windows Drag'n'drop Batch Denoiser
## PFM denoising using Intel Open Image Denoise.
## PNG denoising using Declan Russell's IntelOIDenoiser and/or NvidiaAIDenoiser.
---

### Setup PFM

1. Download:
      [Intel Open Image Denoise (CPU must support SSE4.1](https://openimagedenoise.github.io/downloads.html)
      
2. Edit the following line in `pfm_denoiser.bat` to reflect the actual location of `denoise.exe` on your computer:
`SET dn_path="D:\Programs\oidn-1.2.0.x64.vc14.windows\bin\denoise.exe" `

### Setup PNG

1. Download and setup one or both of following (assuming you meet the requirements):

      [IntelOIDenoiser (CPU must support SSE4.1)](https://github.com/DeclanRussell/IntelOIDenoiser)

      OR

      [NvidiaAIDenoiser (Maxwell GPU or newer architecture with 418.xx or newer driver)](https://github.com/DeclanRussell/NvidiaAIDenoiser)


2. Edit the following line in `png_denoiser.bat` to reflect the actual location of `Denoiser.exe` on your computer:
`SET dn_path="C:\Denoiser_v2.3\Denoiser.exe" `

(Optional) Uncomment both occurences and set `dn_path2` if you wish to compare both denoisers.

---

### Usage

Drag and drop one or more .png or .pfm files onto the corresponding .bat file to automatically denoise the image, producing a file with the `_dn` suffix.

Assuming you are using the PFM version, please drag an drop only the noisy images (aka hdr images). The script will find the .albedo and .normal maps if they exist in the same directory else it will fall back.
