---
name: button-package-workflow
description: Maintains a Flutter button package with comprehensive variants (including toggle/segmented) plus composable effects and a showcase example app. Use when adding a new button type, state, effect, or when preparing for pub.dev publishing.
---

# Button Package Workflow

## When to use

Use this workflow when:

- A new button type/variant is added (filled/outlined/icon/toggle/segmented/chip-like/etc.)
- A new effect is added (ripple/scale/elevation/glow/shimmer/progress/haptics)
- The example showcase app needs to reflect new features
- Preparing a release/publish to pub.dev

## Core workflow

### 1) Update the Phase 1 analysis docs

In `doc/PHASE_1_SETUP.md`:

- Add the button type to the **Button types (catalog)** diagram if it is new
- Confirm it is covered by the **capabilities contract** (states/content/sizes/shapes/theming/a11y/effects)
- Add or update the **per-button checklist** section for that button type

### 2) Update the Phase 2 implementation + example plan

In `doc/PHASE_2_PACKAGE_AND_EXAMPLES.md`:

- Confirm the public API surface (widget/style/effect) for the new capability
- Ensure the `example/` app has a screen/section that demonstrates it
- Ensure the example includes a matrix view (variants × sizes/tones) where applicable

### 3) Update package + example code (when implementation is requested)

- Keep public exports minimal (`lib/super_button_package.dart`)
- Keep implementation under `lib/src/`
- Add tests for:
  - disabled and loading behavior
  - visual/state resolution logic (where testable)
  - toggle selection semantics (for toggle/segmented/chip-like)

### 4) Pre-publish checklist (Phase 3)

In `doc/PHASE_3_PUBLISHING.md`, follow the command flow:

- `flutter analyze`
- `flutter test`
- `flutter pub publish --dry-run`
- `flutter pub publish`

Confirm:

- `publish_to: 'none'` removed
- `LICENSE` + `CHANGELOG.md` updated
- `example/` runs and demonstrates new feature

