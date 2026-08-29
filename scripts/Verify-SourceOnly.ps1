$ErrorActionPreference = "Stop"

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$forbiddenExtensions = @(
  ".dll", ".exe", ".addon32", ".addon64", ".pdb", ".lib", ".bin",
  ".sys", ".zip", ".7z", ".rar"
)
$forbiddenText = @(
  "BEGIN PRIVATE KEY",
  "github_pat_",
  "gho_",
  "ghp_",
  "ghs_"
)
$userProfile = [Environment]::GetFolderPath("UserProfile")
if (-not [string]::IsNullOrWhiteSpace($userProfile)) {
  $forbiddenText += $userProfile
}

$files = Get-ChildItem -LiteralPath $repoRoot -Recurse -Force -File |
  Where-Object {
    $_.FullName -notmatch "[\\/]\.git[\\/]" -and
    $_.FullName -notmatch "[\\/]dist[\\/]"
  }

$problems = [System.Collections.Generic.List[string]]::new()

foreach ($file in $files) {
  if ($forbiddenExtensions -contains $file.Extension.ToLowerInvariant()) {
    $problems.Add("Forbidden binary/archive extension: $($file.FullName)")
  }
  if ($file.Length -gt 10MB) {
    $problems.Add("Unexpected file larger than 10 MiB: $($file.FullName)")
  }
}

foreach ($needle in $forbiddenText) {
  $textFiles = $files | Where-Object {
    $_.FullName -ne [System.IO.Path]::GetFullPath($PSCommandPath)
  }
  $matches = Select-String -LiteralPath $textFiles.FullName -SimpleMatch $needle `
    -ErrorAction SilentlyContinue
  foreach ($match in $matches) {
    $problems.Add("Forbidden text '$needle': $($match.Path):$($match.LineNumber)")
  }
}

if ($problems.Count -gt 0) {
  $problems | ForEach-Object { Write-Error $_ }
  throw "Source-only verification failed with $($problems.Count) problem(s)."
}

Write-Host "Source-only verification passed for $($files.Count) files."
