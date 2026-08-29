# Third-party projects and runtime boundary

This repository contains source patches. Its GitHub player release combines
the official RTX Remix Runtime 1.5.2 distribution with the compiled files that
differ for Fallout: New Vegas. It does not relicense upstream code or grant
rights to separately obtained proprietary runtimes.

## NVIDIA DXVK-Remix

- Upstream: https://github.com/NVIDIAGameWorks/dxvk-remix
- The repository carries MIT, zlib, and third-party notices.
- NVIDIA states that modders may build and share mods using binaries from the
  RTX Remix and DXVK-Remix GitHub projects.
- Preserve the upstream `LICENSE`, `LICENSE-MIT`, and
  `ThirdPartyLicenses.txt` files in every patched checkout and binary
  distribution.

## Remix-Wrappers

- Upstream: https://github.com/Kim2091/Remix-Wrappers
- The patch must be used under the terms and notices present in that upstream
  repository.

## ReShade

- Upstream: https://github.com/crosire/reshade
- License: BSD 3-Clause, with individually marked MIT dual-licensed files.
- Binary redistribution requires reproducing the BSD notice in documentation
  or accompanying materials.

## RenoDX

- Upstream framework: https://github.com/clshortfuse/renodx
- Public framework license: MIT.
- RenoDX add-on binaries are not distributed by this repository. Obtain a
  compatible add-on from a source that grants permission to use it, and verify
  its provenance before loading it.

## NVIDIA DLSS / NGX / Neural Rendering

GitHub Releases do not contain separately distributed NVIDIA DLSS/NGX,
Streamline, or Neural Rendering runtime files. Users obtain those directly
from an authorized source.

## Fallout: New Vegas

No Bethesda, Obsidian, Steam, GOG, Epic, or Nexus-hosted game/mod binary is
included. Users must own the game and obtain dependencies from their original
publishers.
