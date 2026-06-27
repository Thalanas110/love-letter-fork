$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$index = Get-Content (Join-Path $root 'index.html') -Raw
$js = Get-Content (Join-Path $root 'love.js') -Raw

$checks = @(
  @{
    Name = 'final2 paragraph exists'
    Condition = $index -match 'id="final2"'
  }
  @{
    Name = 'final2 paragraph closes cleanly'
    Condition = $index -match '<p class="final" id="final2" hidden>[\s\S]*?</p>'
  }
  @{
    Name = 'final2 is selected in js'
    Condition = $js -match "const\s+finalText2\s*=\s*\$\('final2'\);"
  }
  @{
    Name = 'sayYes unhides final2'
    Condition = $js -match 'finalText2\.hidden\s*=\s*false;'
  }
  @{
    Name = 'sayYes animates final2'
    Condition = $js -match "finalText2\.classList\.add\('is-show'\)"
  }
  @{
    Name = 'reset hides final2 again'
    Condition = $js -match 'finalText2\.hidden\s*=\s*true;'
  }
  @{
    Name = 'reset removes final2 show class'
    Condition = $js -match "finalText2\.classList\.remove\('is-show'\)"
  }
)

$failures = $checks | Where-Object { -not $_.Condition }

if ($failures.Count -gt 0) {
  throw "Final2 visibility regression check failed: $($failures.Name -join '; ')"
}

Write-Host 'Final2 visibility regression check passed.'
