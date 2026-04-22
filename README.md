## super_button_package

[![pub package](https://img.shields.io/pub/v/super_button_package.svg)](https://pub.dev/packages/super_button_package)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/NurhayatYurtaslan/super_button_package/blob/main/LICENSE)

Composable **SuperButton** API with **SuperButtonStyle** (variant, size, shape, tone) and a stack of **SuperButtonEffect** hooks. Out of the box: **theme resolution** via `SuperButtonColorResolver` (per tone / variant / state), and built-in effects (scale, focus ring, ink tint, elevation, loading overlay). The repository includes a full **example** gallery (filterable matrix on Gallery, effects playground, combinations, basic accessibility).

> **Status — pre-1.0:** the public API and visuals will evolve. Follow [SemVer](https://semver.org) and the [CHANGELOG](CHANGELOG.md); lock to a specific version in apps.
>
> **Pub.dev version:** the published version is the `version` field in [`pubspec.yaml`](https://github.com/NurhayatYurtaslan/super_button_package/blob/main/pubspec.yaml) at the release tag. Current line release: **0.2.1** (`super_button_package: ^0.2.1`).

## Install

Add to your `pubspec.yaml`:

```yaml
dependencies:
  super_button_package: ^0.2.1
```

Run:

```bash
flutter pub get
```

## Usage

```dart
import 'package:super_button_package/super_button_package.dart';

SuperButton(
  onPressed: () {},
  label: const Text('Continue'),
  leading: const Icon(Icons.check),
  style: const SuperButtonStyle(
    variant: SuperButtonVariant.filled,
    size: SuperButtonSize.md,
    shape: SuperButtonShape.pill,
    tone: SuperButtonTone.primary,
  ),
  effects: const [SuperIdentityEffect()],
  loading: false,
);
```

## Example app (showcase)

From the package repository:

```bash
cd example
flutter run
# Web: flutter run -d chrome
```

## Documentation

* API reference: [pub.dev documentation tab](https://pub.dev/packages/super_button_package) (generated after publish).
* Design and release process: [doc/PHASE_1_SETUP.md](doc/PHASE_1_SETUP.md), [doc/PHASE_2_PACKAGE_AND_EXAMPLES.md](doc/PHASE_2_PACKAGE_AND_EXAMPLES.md), [doc/PHASE_3_PUBLISHING.md](doc/PHASE_3_PUBLISHING.md).

## License

[MIT](LICENSE)
