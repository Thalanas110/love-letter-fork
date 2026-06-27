$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$cssPath = Join-Path $root 'love.css'
$css = Get-Content $cssPath -Raw

$expected = [ordered]@{
  '--cream' = '#fbf1d8'
  '--coral' = '#e08b67'
  '--coral-dk' = '#c96b4a'
  '--pink' = '#f4c59c'
  '--pink-lt' = '#f8dfbf'
  '--gingham' = '#f6d2b7'
  '--gingham-2' = 'rgba\(223,145,112,.26\)'
  '--red' = '#eb5c4d'
  '--red-dk' = '#c84438'
  '--paper' = '#fff4df'
  '--maroon' = '#7a2230'
  '--sel' = '#2f54d6'
}

$failures = foreach ($name in $expected.Keys) {
  $pattern = [regex]::Escape($name) + ":\s+" + $expected[$name]
  if ($css -notmatch $pattern) { $name }
}

if ($failures.Count -gt 0) {
  throw "Summer palette regression check failed: $($failures -join ', ')"
}

Write-Host 'Summer palette regression check passed.'
