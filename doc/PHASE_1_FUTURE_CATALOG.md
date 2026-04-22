# PHASE_1 extended catalog (future milestones)

This file scopes work that is **documented** in [`PHASE_1_SETUP.md`](PHASE_1_SETUP.md) but **not** part of the current `SuperButton`-only release. Implement as one or more **minor/major** versions with CHANGELOG entries and example app screens.

## Planned widgets (naming per [`.cursor/rules/flutter-button-api-conventions.mdc`](../.cursor/rules/flutter-button-api-conventions.mdc))

| Area | Widget / feature | Notes |
|------|------------------|--------|
| Toggle | `SuperToggleButton` (or single `SuperButton` + `toggled` semantics) | `Semantics` `toggled`, keyboard, disabled/loading |
| Segmented | `SuperSegmentedControl` | Single vs multi-select, arrow-key focus in `example/` |
| Chip | Chip-like row | Selected/unselected, optional remove icon, `Wrap` in example |
| FAB | Extended FAB | Optional; may stay as `SuperButton` + `fab` + layout tokens |

## Deliverables per feature

- Public types in [`lib/super_button_package.dart`](../lib/super_button_package.dart) exports.
- Implementation under `lib/src/`.
- Tests: selection semantics, disabled/loading, basic layout.
- `example/` screen or section in Gallery.
- Update diagram in [`PHASE_2_PACKAGE_AND_EXAMPLES.md`](PHASE_2_PACKAGE_AND_EXAMPLES.md).

## Relationship to current API

Today, [`SuperButton`](https://pub.dev/documentation/super_button_package/latest/super_button_package/SuperButton-class.html) covers **action** buttons with `selected` for chip-like **visual** state only. Full toggle/segmented behavior is **not** implied until this milestone ships.
