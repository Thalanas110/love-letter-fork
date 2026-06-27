# Summer Palette Refresh

## Goal

Shift the page toward a warm summer mood while keeping the existing UI, layout, and interactions effectively unchanged.

## Scope

This change is limited to the shared color tokens in the `:root` block of `love.css`.
It should not introduce component-specific restyling, layout edits, animation changes, or JavaScript changes.

## Design Direction

The current look is soft and romantic.
The refresh should keep that same identity, but move it slightly warmer:
- cream should lean more sunlit than neutral
- coral and pink should lean more peach/apricot than rosy
- paper tones should feel a little warmer
- heart reds should stay readable and romantic, not become neon

## Constraints

Keep CSS churn minimal by changing only the root palette variables already used across the page.
Do not change the cat styling.
Do not change spacing, typography, shadows, borders, or component structure unless a token dependency naturally updates them.

## Implementation Notes

Update only these variables in `love.css`:
- `--cream`
- `--coral`
- `--coral-dk`
- `--pink`
- `--pink-lt`
- `--gingham`
- `--gingham-2`
- `--red`
- `--red-dk`
- `--paper`

Leave `--maroon` and `--sel` unchanged unless verification shows a readability issue.

## Verification

Verify that:
- the page still reads as the same design
- the palette feels warmer overall
- the window, envelope, buttons, and hearts remain readable
- the cat remains visually unchanged
