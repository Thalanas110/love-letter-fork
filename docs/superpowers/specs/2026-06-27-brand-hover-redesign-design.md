# Brand Hover Redesign

## Goal

Redesign the lower-right `Code & Chill` brand watermark so that it expands on hover and focus to reveal the phrase `original from that`.

## Scope

This change is limited to the existing fixed `.brand` link in `index.html` and its styling in `love.css`.
No JavaScript behavior changes are required.

## Interaction Design

The brand link stays as a compact circular watermark by default.
On hover and keyboard focus, it expands horizontally into a pill-shaped badge.
The logo remains visible on the left, while the text `original from that` appears to the right with a short fade and slide transition.

## Visual Direction

The expanded state should feel consistent with the page's retro-romantic UI:
- keep the existing fixed corner placement
- preserve the logo as the anchor element
- use a soft framed badge treatment rather than a browser-style tooltip
- keep motion subtle and short

## Accessibility

The same reveal should work for `:hover` and `:focus-visible`.
The interaction must not depend on JavaScript.
Reduced-motion users should not get exaggerated animation.

## Constraints

The change should avoid affecting page layout because the brand element is fixed-positioned.
Touch devices may never show hover, so the default state must remain acceptable on its own.
The existing external link destination should remain unchanged.

## Testing

Verify that:
- the logo remains visible at rest
- the badge expands and reveals `original from that` on hover
- keyboard focus triggers the same reveal
- mobile sizing still fits the corner without clipping
