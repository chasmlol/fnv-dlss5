# Fallout: New Vegas — Vanilla DLAA / DLSS Neural Rendering Host

This project runs Fallout: New Vegas through NVIDIA RTX Remix while preserving
the game's original raster graphics. It adds a native-resolution DLAA host that
a compatible RenoDX ReShade addon can use for DLSS Neural Rendering.

## Quick start

The **Fallout New Vegas folder** is the folder containing `FalloutNV.exe`. A
default Steam installation is usually:

```text
C:\Program Files (x86)\Steam\steamapps\common\Fallout New Vegas
```

1. Download `FNV-Vanilla-DLAA-v1.0.1.zip` from
   [Releases](https://github.com/chasmlol/fnv-dlss5/releases).
2. Extract the contents directly into the Fallout New Vegas folder.
3. Copy the following three files directly into
   `Fallout New Vegas\.trex`:

```text
nvngx_dlss.dll
nvngx_dlssnr.dll
renodx-dlss5.addon64
```

4. Double-click:

```text
PLAY-FNV-DLAA.bat
```

The ZIP does not contain the three files in step 3. Obtain compatible signed
NVIDIA copies of `nvngx_dlss.dll` and `nvngx_dlssnr.dll`, and obtain
`renodx-dlss5.addon64` from a source you trust. Do not substitute
`nvngx_dlssg.dll`; that is the Frame Generation runtime.

## Controls

- Press **Home** to open ReShade and adjust Neural Rendering.
- Press **Alt+X** to open the RTX Remix menu.

The first launch can pause while shaders are prepared. Give it a few minutes.

## Troubleshooting

### The BAT reports a missing file

Make sure all three files from quick-start step 3 are directly inside `.trex`,
not in the game folder or another subfolder.

### The game crashes or immediately closes

Remove an older `d3d9.dll`, `d3d9_remix.dll`, `NvRemixLauncher32.exe`, and
`.trex` folder before extracting the release again. Do not mix files from
different versions.

### Home does nothing

Confirm that `renodx-dlss5.addon64` is directly inside `.trex`, then launch
with `PLAY-FNV-DLAA.bat`.

### DLAA works but Neural Rendering is missing

Check that `nvngx_dlss.dll` and `nvngx_dlssnr.dll` are in `.trex` and that
`renodx-dlss5.addon64` is also directly inside `.trex`.

## Frequently asked questions

### Does this enable RTX Remix path tracing?

No. This release intentionally disables Remix path tracing and presents the
original New Vegas raster image to the DLAA and Neural Rendering path.

### Where is the proxy source?

The source is reproducible from the public upstream projects and the patches
in this repository. `scripts\Setup-Sources.ps1` checks out the pinned revisions
and applies the patches in this repository. See [PATCHES.md](PATCHES.md) for
exact revisions and hashes.

## Build from source

Everything below this point is for developers. Players do not need to compile
anything.

### Requirements

- Windows 10 or 11
- Git and PowerShell
- Visual Studio 2022 with Desktop development with C++
- Python, Meson, Ninja, and the Vulkan SDK

### Prepare the source trees

```powershell
git clone https://github.com/chasmlol/fnv-dlss5.git
cd .\fnv-dlss5
powershell -ExecutionPolicy Bypass -File .\scripts\Setup-Sources.ps1
```

This creates pinned, patched checkouts under `build\sources`.

### Build DXVK-Remix

```powershell
cd .\build\sources\dxvk-remix
. .\build_common.ps1
PerformBuild -BuildFlavour debugoptimized `
  -BuildSubDir _Comp64DebugOptimized `
  -Backend ninja `
  -EnableTracy false `
  -ConfigureOnly $true
meson compile -C .\_Comp64DebugOptimized d3d9
cd ..\..\..
```

Output:

```text
build\sources\dxvk-remix\_Comp64DebugOptimized\src\d3d9\d3d9.dll
```

### Build the matching bridge

```powershell
cmd /c .\build\sources\dxvk-remix\bridge\build_bridge_release.bat
```

Use the x86 bridge client as `d3d9_remix.dll` and the x64 server as
`.trex\NvRemixBridge.exe`. The client, server, and renderer must come from the
same source revision.

### Build the New Vegas wrapper

```powershell
cmd /c .\build\sources\Remix-Wrappers\FalloutNV-Remix-Wrapper\build.bat release
```

Install its output as the game-folder `d3d9.dll`.

### Build ReShade

```powershell
msbuild .\build\sources\reshade\ReShade.sln `
  /m /p:Configuration=Release /p:Platform="64-bit"
```

Install the output as `.trex\reshade-layer\ReShade64.dll`.

Patch bases and hashes are recorded in [PATCHES.md](PATCHES.md). Third-party
licenses and distribution boundaries are documented in
[THIRD_PARTY.md](THIRD_PARTY.md).

## License

Original project scripts and documentation are MIT licensed. Patched source and
compiled files remain subject to their upstream licenses and notices.

This project is not affiliated with Bethesda, Obsidian, NVIDIA, ReShade, or
RenoDX.
