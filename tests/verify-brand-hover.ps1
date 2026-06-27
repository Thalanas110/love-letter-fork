$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $root 'index.html'
$cssPath = Join-Path $root 'love.css'

$index = Get-Content $indexPath -Raw
$css = Get-Content $cssPath -Raw

$checks = @(
  @{
    Name = 'brand text exists in markup'
    Condition = $index -match 'class="brand__text"'
  }
  @{
    Name = 'brand hover reveals text'
    Condition = $css -match '\.brand:hover\s+\.brand__text,\s*\.brand:focus-visible\s+\.brand__text'
  }
  @{
    Name = 'brand has expandable hover shell'
    Condition = $css -match '\.brand:hover,\s*\.brand:focus-visible'
  }
)

$failures = $checks | Where-Object { -not $_.Condition }

if ($failures.Count -gt 0) {
  $names = $failures.Name -join '; '
  throw "Brand hover regression check failed: $names"
}

Write-Host 'Brand hover regression check passed.'
