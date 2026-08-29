FALLOUT: NEW VEGAS - VANILLA DLAA / DLSS NEURAL RENDERING HOST
==============================================================

INSTALL
-------

1. Extract everything in this ZIP directly into the Fallout New Vegas folder
   containing FalloutNV.exe.

2. Copy these files directly into the .trex folder:

   nvngx_dlss.dll
   nvngx_dlssnr.dll
   renodx-dlss5.addon64

   The ZIP does not contain these three files. Obtain compatible signed NVIDIA
   copies of the two DLLs and obtain the addon from a source you trust.
   nvngx_dlssg.dll is not a substitute.

PLAY
----

Double-click PLAY-FNV-DLAA.bat.

Home  = ReShade / Neural Rendering controls
Alt+X = RTX Remix menu

The first launch can pause while shaders are prepared. Give it a few minutes.

SECURITY
--------

ReShade add-ons are native executable code. Only use an addon from a source
you trust. NVIDIA runtime DLLs should show NVIDIA Corporation on the Digital
Signatures tab in Windows file properties.

Full instructions and troubleshooting:
https://github.com/chasmlol/fnv-dlss5
