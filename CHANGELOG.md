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
