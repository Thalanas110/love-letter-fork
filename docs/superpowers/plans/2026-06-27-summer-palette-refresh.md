# Summer Palette Refresh Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Warm the page into a summer-leaning palette by changing only the shared root color tokens in `love.css`.

**Architecture:** Keep the existing layout, components, cat artwork, and behavior untouched. Add a small regression script that checks the approved token values, watch it fail first, then update only the `:root` variables in `love.css` so the whole interface warms up through existing token usage.

**Tech Stack:** Static HTML, vanilla CSS, PowerShell regression script

---

### Task 1: Add a failing regression check for the approved summer palette

**Files:**
- Create: `tests/verify-summer-palette.ps1`
- Test: `tests/verify-summer-palette.ps1`

- [ ] **Step 1: Write the failing test**

```powershell
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
```

- [ ] **Step 2: Run the test to verify it fails**

Run: `powershell -NoProfile -ExecutionPolicy Bypass -File tests/verify-summer-palette.ps1`
Expected: FAIL with `Summer palette regression check failed` because `love.css` still contains the older cooler token values.

### Task 2: Update only the root palette variables

**Files:**
- Modify: `love.css:6-18`
- Test: `tests/verify-summer-palette.ps1`

- [ ] **Step 1: Replace only the approved root token values**

```css
:root{
  --cream:      #fbf1d8;   /* page background          */
  --coral:      #e08b67;   /* window frame / borders   */
  --coral-dk:   #c96b4a;   /* darker frame line        */
  --pink:       #f4c59c;   /* title bar                */
  --pink-lt:    #f8dfbf;   /* heart-row bar            */
  --gingham:    #f6d2b7;   /* content base             */
  --gingham-2:  rgba(223,145,112,.26);
  --maroon:     #7a2230;   /* dark pixel text          */
  --red:        #eb5c4d;   /* hearts                   */
  --red-dk:     #c84438;
  --paper:      #fff4df;   /* buttons / envelope body  */
  --sel:        #2f54d6;   /* "selection" highlight    */
```

- [ ] **Step 2: Run the regression check to verify it passes**

Run: `powershell -NoProfile -ExecutionPolicy Bypass -File tests/verify-summer-palette.ps1`
Expected: PASS with `Summer palette regression check passed.`

### Task 3: Verify the token-only scope

**Files:**
- Modify: none
- Test: `tests/verify-summer-palette.ps1`

- [ ] **Step 1: Re-run the regression check**

Run: `powershell -NoProfile -ExecutionPolicy Bypass -File tests/verify-summer-palette.ps1`
Expected: PASS with `Summer palette regression check passed.`

- [ ] **Step 2: Inspect the diff to confirm only root tokens changed for this feature**

Run: `git -c safe.directory='C:/Users/Adriaan M. Dimate/Desktop/love-letter' diff -- love.css tests/verify-summer-palette.ps1 docs/superpowers/plans/2026-06-27-summer-palette-refresh.md`
Expected: a diff limited to the new regression script, the new plan file, and the root color variables in `love.css`.
