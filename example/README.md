# super_button_package example

Showcase app for **super_button_package**: **Gallery** (filters + code snippet), **Combinations** (variant × size/tone matrix), **Effects** playground, and **A11y** samples.

## Run

```bash
cd example
flutter pub get
flutter run
# Web: flutter run -d chrome
```

Wider viewports use a `NavigationRail`; narrow layouts use a bottom `NavigationBar`. Use the app bar to cycle the theme **seed color** and toggle **light / dark / system** theme.

## Screenshots (repository root)

Preview images for the *Combinations* screen live next to the package README:

- [`../assets/example-combinations-by-size.png`](../assets/example-combinations-by-size.png) — matrix with columns **By size** (xs–xl)
- [`../assets/example-combinations-by-tone.png`](../assets/example-combinations-by-tone.png) — matrix with columns **By tone** (primary, neutral, success, …)

For the [screenshot section in the package README on GitHub](https://github.com/NurhayatYurtaslan/super_button_package#screenshots), use the `assets/` image paths in the main project.
