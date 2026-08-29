param(
  [string]$Destination = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
if ([string]::IsNullOrWhiteSpace($Destination)) {
  $Destination = Join-Path $repoRoot "build\sources"
}
$Destination = [System.IO.Path]::GetFullPath($Destination)

$projects = @(
  [ordered]@{
    Name = "dxvk-remix"
    Url = "https://github.com/NVIDIAGameWorks/dxvk-remix.git"
    Base = "64fbdeb8"
    Patch = Join-Path $repoRoot "patches\dxvk-remix-fnv-raster-dlaa.patch"
    ReleasePatch = Join-Path $repoRoot "patches\dxvk-remix-release-build.patch"
  },
  [ordered]@{
    Name = "Remix-Wrappers"
    Url = "https://github.com/Kim2091/Remix-Wrappers.git"
    Base = "de44e79"
    Patch = Join-Path $repoRoot "patches\remix-wrappers-fnv-raster.patch"
    LauncherPatch = Join-Path $repoRoot "patches\remix-wrappers-launcher-passthrough.patch"
  },
  [ordered]@{
    Name = "reshade"
    Url = "https://github.com/crosire/reshade.git"
    Base = "18deaa5"
    Patch = Join-Path $repoRoot "patches\reshade-cross-process-input.patch"
  }
)

New-Item -ItemType Directory -Force -Path $Destination | Out-Null

foreach ($project in $projects) {
  $target = Join-Path $Destination $project.Name
  if (Test-Path -LiteralPath $target) {
    throw "Destination already exists; refusing to overwrite it: $target"
  }
  if (-not (Test-Path -LiteralPath $project.Patch)) {
    throw "Patch is missing: $($project.Patch)"
  }

  Write-Host "Cloning $($project.Name)..."
  & git clone --recursive $project.Url $target
  if ($LASTEXITCODE -ne 0) {
    throw "git clone failed for $($project.Name)"
  }

  & git -C $target checkout --detach $project.Base
  if ($LASTEXITCODE -ne 0) {
    throw "Could not check out $($project.Base) in $($project.Name)"
  }

  & git -C $target submodule update --init --recursive
  if ($LASTEXITCODE -ne 0) {
    throw "Submodule setup failed for $($project.Name)"
  }

  & git -C $target apply --check $project.Patch
  if ($LASTEXITCODE -ne 0) {
    throw "Patch validation failed for $($project.Name)"
  }

  & git -C $target apply $project.Patch
  if ($LASTEXITCODE -ne 0) {
    throw "Patch application failed for $($project.Name)"
  }

  if ($project.ReleasePatch) {
    if (-not (Test-Path -LiteralPath $project.ReleasePatch)) {
      throw "Patch is missing: $($project.ReleasePatch)"
    }

    & git -C $target apply --check --unidiff-zero $project.ReleasePatch
    if ($LASTEXITCODE -ne 0) {
      throw "Release patch validation failed for $($project.Name)"
    }

    & git -C $target apply --unidiff-zero $project.ReleasePatch
    if ($LASTEXITCODE -ne 0) {
      throw "Release patch application failed for $($project.Name)"
    }
  }

  if ($project.LauncherPatch) {
    if (-not (Test-Path -LiteralPath $project.LauncherPatch)) {
      throw "Patch is missing: $($project.LauncherPatch)"
    }

    & git -C $target apply --check $project.LauncherPatch
    if ($LASTEXITCODE -ne 0) {
      throw "Launcher patch validation failed for $($project.Name)"
    }

    & git -C $target apply $project.LauncherPatch
    if ($LASTEXITCODE -ne 0) {
      throw "Launcher patch application failed for $($project.Name)"
    }
  }

  Write-Host "Patched $($project.Name) at base $($project.Base)."
}

Write-Host ""
Write-Host "All source trees were created successfully under:"
Write-Host "  $Destination"
Write-Host ""
Write-Host "No runtime DLLs, game files, or RenoDX add-ons were downloaded."
