## 0.3.1

* **Fixed** — `SuperButton` merges `DefaultTextStyle` and `IconTheme` with the resolver foreground so label and icons stay legible in light mode (notably on web) when `ButtonStyle` does not reach nested `Row` / `Flexible` content.
* **Fixed** — `SuperButtonColorResolver` for `outlined`, `text`, and `link`: non-neutral tones use chromatic *ink* (`ColorScheme.primary`, `error`, etc.) for text on the page surface; `onPrimary`-style colors remain for *filled* surfaces only, fixing low-contrast labels in light mode.
* **Fixed** (example) — Combinations matrix `Table` in horizontal `SingleChildScrollView`: fixed column widths and `ConstrainedBox` so layout is bounded on web (avoids `Table` / `IntrinsicColumnWidth` failures under unbounded horizontal constraints).
* **Tests** — resolver case for `outlined` + `primary` ink; `CombinationsScreen` layout smoke test.

## 0.3.0

* **API** — `SuperButton.selected` and `Semantics.selected`; `SuperButtonColorResolver` applies selected “chip” colors (`secondaryContainer` / `onSecondaryContainer`, danger uses `errorContainer`).
* **Effects** — `SuperScaleEffect` uses animated scale via `Matrix4` + `duration` / `curve`.
* **Example** — Gallery: `CustomScrollView`, **Selected** filter, improved snippet. Combinations: **matrix** (min v1 variants × size or tone) + `SegmentedButton` axis. Effects playground: all built-ins with **toggles and sliders**. Accessibility: `FocusScope`, `TextField`, semantics/tooltip samples.
* **Docs** — `doc/PLACEHOLDER_VARIANTS.md`, `doc/PHASE_1_FUTURE_CATALOG.md`; `PHASE_2` §2.9 updated. README: pub follow-ups (pana, screenshots).
* **Tests** — resolver (selected, outlined), widget label+icon.

## 0.2.1

* **Pub.dev** — release metadata: README install pin, `doc/PHASE_3_PUBLISHING.md` version/tag examples, and `pubspec` together list **0.2.1** as the current publish. No public API or behavior change.

## 0.2.0

* **Style** — `SuperButtonColorResolver` and `SuperButtonColorResolution` (variant / tone / disabled → `ColorScheme` roles) under `lib/src/style/resolver/`.
* **Utils** — `SuperColorUtils` for disabled foreground alpha.
* **Effects** — built-ins: `SuperInkRippleEffect`, `SuperScaleEffect`, `SuperElevationEffect`, `SuperFocusRingEffect`, `SuperLoadingSpinnerEffect` (replaces or complements inline row spinner when used).
* **SuperButton** — stateful: hover, press, shared `FocusNode` for Material buttons, optional `tooltip` / `semanticsLabel`.
* **Example** — Gallery: filters + effect toggles + copyable snippet; wide layout: `NavigationRail`; seed color cycle; effects playground: scale slider.
* **Docs** — `doc/PHASE_2_PACKAGE_AND_EXAMPLES.md` §2.9 implementation status.
* **Tests** — resolver + loading tap.

## 0.1.0

* First release prepared for [pub.dev](https://pub.dev).
* Replaced placeholder `LICENSE` with MIT.
* README: installation and usage; `documentation` and `.pubignore` for publishing.
* Renamed top-level `docs/` to `doc/` (pub package layout; links updated across the repo).

## 0.0.1

* Initial pub package layout with `lib/super_button_package.dart` and `lib/src/`.
* Public API scaffold: `SuperButton`, `SuperButtonStyle`, enums, `SuperButtonEffect`, `SuperIdentityEffect`, `SuperButtonTokens`.
* `example/` showcase app with Gallery, Combinations, Effects, and Accessibility tabs.
