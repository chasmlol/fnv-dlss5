# Patch manifest

All patches are unified source diffs without bundled build outputs.

| Component | Upstream | Base | Patch SHA-256 |
|---|---|---|---|
| DXVK-Remix raster DLAA | `https://github.com/NVIDIAGameWorks/dxvk-remix.git` | `64fbdeb8` | `8678E8F88A2670993CDD3091491C1700D9FD2D7F333C1A56E96912C502599913` |
| DXVK-Remix release build | `https://github.com/NVIDIAGameWorks/dxvk-remix.git` | `64fbdeb8` | `FA9F25270B9563E8E68A289259771EBF96BA997CF45492EAF3DCC8F69D0FE1A7` |
| Remix-Wrappers | `https://github.com/Kim2091/Remix-Wrappers.git` | `de44e79` | `B2E57E56B82B1E0F906E9F9F0580DDE7FD67BAC2E746EC524BFD8B5BE6BB16F4` |
| Remix-Wrappers launcher passthrough | `https://github.com/Kim2091/Remix-Wrappers.git` | patched `de44e79` tree | `E9A32FF1BC691701791B514B9B2A44EB97D4A8FF61AC1C40A31A3B48348BB02C` |
| ReShade | `https://github.com/crosire/reshade.git` | `18deaa5` (`v6.8.0`) | `A28B294765A5FFD607ED76825F74C8B611F88A46B5A320CF248CF5622AC06F4D` |

To verify the recorded hashes:

```powershell
Get-FileHash .\patches\* -Algorithm SHA256
```
