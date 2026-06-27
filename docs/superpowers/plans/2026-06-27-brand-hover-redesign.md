# Brand Hover Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Redesign the lower-right brand watermark so it expands on hover and focus to reveal the phrase `original from that`.

**Architecture:** Keep the existing fixed external link and add one inline text node inside it. Implement the reveal entirely in CSS by changing the link from a simple circular watermark into an expandable retro pill on hover and `:focus-visible`, while preserving the logo in the resting state.

**Tech Stack:** Static HTML, vanilla CSS, PowerShell regression script

---

### Task 1: Add a failing regression check

**Files:**
- Create: `tests/verify-brand-hover.ps1`
- Test: `tests/verify-brand-hover.ps1`

- [ ] **Step 1: Write the failing test**

```powershell
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
```

- [ ] **Step 2: Run test to verify it fails**

Run: `powershell -NoProfile -ExecutionPolicy Bypass -File tests/verify-brand-hover.ps1`
Expected: FAIL with `Brand hover regression check failed` because the current markup has no `.brand__text` element and the CSS has no text-reveal selectors.

### Task 2: Implement the expandable brand badge

**Files:**
- Modify: `index.html`
- Modify: `love.css`
- Test: `tests/verify-brand-hover.ps1`

- [ ] **Step 1: Update the brand markup**

```html
<a class="brand" id="brand" href="https://www.youtube.com/@CodeChill_a"
   target="_blank" rel="noopener noreferrer" aria-label="Code &amp; Chill on YouTube">
  <span class="brand__icon">
    <img src="./logo.png" alt="Code &amp; Chill" width="48" height="48" />
  </span>
  <span class="brand__text">original from that</span>
</a>
```

- [ ] **Step 2: Update the brand CSS**

```css
.brand{
  position:fixed; right:18px; bottom:16px; z-index:50;
  display:flex; align-items:center; gap:12px;
  width:48px; height:48px;
  padding:0;
  border:3px solid rgba(122,34,48,.18);
  border-radius:999px; overflow:hidden;
  background:rgba(253,244,239,.88);
  opacity:.62;
  box-shadow:0 4px 14px rgba(0,0,0,.28), 0 0 16px rgba(70,205,255,.18);
  text-decoration:none;
  transition:width .35s var(--ease), padding .35s var(--ease), opacity .35s ease,
             transform .35s var(--ease), box-shadow .35s ease, border-color .35s ease,
             background-color .35s ease;
  -webkit-tap-highlight-color:transparent;
}
.brand__icon{
  flex:0 0 48px;
  width:48px; height:48px;
  border-radius:50%;
  overflow:hidden;
  box-shadow:inset 0 0 0 2px rgba(255,255,255,.35);
}
.brand img{
  display:block; width:100%; height:100%;
  object-fit:cover; transform:scale(1.08);
}
.brand__text{
  min-width:max-content;
  padding-right:16px;
  font-family:var(--font-pix);
  font-size:.58rem;
  line-height:1;
  letter-spacing:.08em;
  color:var(--maroon);
  text-transform:uppercase;
  white-space:nowrap;
  opacity:0;
  transform:translateX(-10px);
  transition:opacity .22s ease, transform .32s var(--ease);
}
.brand:hover, .brand:focus-visible{
  width:226px;
  padding-right:2px;
  opacity:1;
  transform:translateY(-2px) scale(1.03);
  border-color:rgba(122,34,48,.38);
  background:rgba(253,244,239,.98);
  box-shadow:0 10px 24px rgba(122,34,48,.24), 0 0 0 3px rgba(255,255,255,.32);
  outline:none;
}
.brand:hover .brand__text, .brand:focus-visible .brand__text{
  opacity:1;
  transform:translateX(0);
}
@media (max-width:480px){
  .brand{ right:12px; bottom:12px; }
  .brand:hover, .brand:focus-visible{ width:198px; }
  .brand__text{ font-size:.5rem; padding-right:14px; }
}
```

- [ ] **Step 3: Run the regression check to verify it passes**

Run: `powershell -NoProfile -ExecutionPolicy Bypass -File tests/verify-brand-hover.ps1`
Expected: PASS with `Brand hover regression check passed.`

### Task 3: Verify the final behavior and record the change

**Files:**
- Test: `tests/verify-brand-hover.ps1`
- Modify: none

- [ ] **Step 1: Re-run the regression check**

Run: `powershell -NoProfile -ExecutionPolicy Bypass -File tests/verify-brand-hover.ps1`
Expected: PASS with `Brand hover regression check passed.`

- [ ] **Step 2: Manually verify the UI behavior**

Run: open `index.html` in a browser and verify the lower-right logo stays circular at rest, expands into a pill on hover/focus, and reveals `original from that` without clipping on desktop or mobile widths.
Expected: visible logo at rest, visible text on hover and keyboard focus.

- [ ] **Step 3: Commit**

```bash
git add index.html love.css tests/verify-brand-hover.ps1 docs/superpowers/plans/2026-06-27-brand-hover-redesign.md
git commit -m "feat: redesign brand hover badge"
```
