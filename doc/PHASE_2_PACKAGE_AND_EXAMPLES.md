## Phase 2 — Package Implementation and Examples (Showcase App)

This document describes how to implement the package API, structure the code, and build the `example/` app that demonstrates **all** button types and effects.

### Diagram — Package architecture (recommended)

```mermaid
flowchart TB
  subgraph PublicAPI["Public API"]
    Entry["lib/super_button_package.dart\n(exports)"]
    SuperButton["SuperButton"]
    Style["SuperButtonStyle"]
    Effect["SuperButtonEffect"]
  end

  subgraph Internal["Internal implementation (lib/src)"]
    Core["super_button.dart\n(layout + state)"]
    Resolver["style/resolvers\n(variant/tone/state -> paint tokens)"]
    Tokens["tokens/\n(sizes, radii, padding, min tap target)"]
    Effects["effects/\n(ink, scale, elevation, focus ring, shimmer...)"]
    Utils["utils/\n(color, lerp, platform helpers)"]
  end

  subgraph Example["example/ (Showcase App)"]
    ExMain["example/lib/main.dart\n(routes, theme toggles)"]
    Gallery["Gallery Screen\n(variants grid + filters)"]
    Matrix["Combinations Screen\n(matrix view)"]
    Playground["Effects Playground\n(toggles + sliders)"]
    A11y["Accessibility Screen\n(focus + keyboard)"]
  end

  Entry --> SuperButton
  Entry --> Style
  Entry --> Effect

  SuperButton --> Core
  Style --> Resolver
  Resolver --> Tokens
  Effect --> Effects
  Core --> Effects
  Core --> Resolver
  Core --> Utils

  ExMain --> Gallery
  ExMain --> Matrix
  ExMain --> Playground
  ExMain --> A11y
  Gallery -->|uses| Entry
  Matrix -->|uses| Entry
  Playground -->|uses| Entry
  A11y -->|uses| Entry
```

### Diagram — Showcase app navigation

```mermaid
stateDiagram-v2
  [*] --> Gallery
  Gallery --> Combinations
  Gallery --> EffectsPlayground
  Gallery --> Accessibility
  Combinations --> Gallery
  EffectsPlayground --> Gallery
  Accessibility --> Gallery
```

### 2.1 Convert the repo to a publishable package layout

Target structure:

- `lib/`
  - `super_button_package.dart`
  - `src/`
    - `super_button.dart`
    - `style/` (style model + resolvers)
    - `effects/` (effect interface + built-in effects)
    - `tokens/` (sizes, radii, padding, min tap target)
    - `utils/` (helpers)
- `example/`
  - `lib/main.dart` (gallery app)
  - `lib/screens/`
  - `lib/components/`

Notes:

- Keep `lib/super_button_package.dart` as the **only** public entrypoint (export curated APIs).
- Keep implementation in `lib/src/` to avoid exposing internal details.

### 2.2 Public API design (recommended)

#### Core widget

- `SuperButton`
  - `VoidCallback? onPressed`
  - `Widget label` (required for non-icon variants)
  - `Widget? leading`
  - `Widget? trailing`
  - `bool loading`
  - `bool enabled` (optional; usually derived from `onPressed != null`)
  - `SuperButtonStyle style`
  - `List<SuperButtonEffect> effects`

#### Style model

- `SuperButtonStyle`
  - `SuperButtonVariant variant`
  - `SuperButtonSize size`
  - `SuperButtonShape shape`
  - `SuperButtonTone tone` (primary/neutral/success/warning/danger)
  - `EdgeInsets? paddingOverride`
  - `TextStyle? textStyleOverride`
  - `Color? backgroundColorOverride`
  - `Color? foregroundColorOverride`
  - `BorderSide? borderOverride`

#### Effects

- `SuperButtonEffect` (interface)
  - Should be composable and stateless where possible
  - Reads an interaction state model (pressed/hovered/focused/disabled/loading)

### 2.3 Interaction state model

Define a single internal state object (example shape):

- `pressed: bool`
- `hovered: bool`
- `focused: bool`
- `enabled: bool`
- `loading: bool`
- `selected: bool`

This state is the input for:

- style resolution (colors, shadows, border)
- effects (scale, glow, ripple, shimmer)

### 2.4 Built-in button variants (what to implement)

Minimum set for v1:

- `filled`, `tonal`, `outlined`, `text`, `elevated`
- `icon`
- `destructive` (can be `filled` + danger tone)

Optional “modern” variants (ship when stable):

- `gradient`
- `glass`
- `neumorphic`
- `link`
- `fab`

### 2.5 Built-in effects (what to implement)

Minimum set for v1:

- `SuperInkRippleEffect` (Material `InkWell`-based)
- `SuperScaleEffect` (press scale)
- `SuperElevationEffect` (hover/press elevation)
- `SuperFocusRingEffect` (focus outline)
- `SuperLoadingSpinnerEffect` (inline spinner + disabled interaction)

Optional:

- shimmer overlay (`SuperShimmerEffect`)
- gradient shift (`SuperGradientShiftEffect`)
- haptics (`SuperHapticsEffect`)

### 2.6 The `example/` showcase app (must-have)

The `example/` app should be the “living documentation”:

#### Screens

- **Gallery**
  - grid/list of buttons
  - filter panel:
    - variant
    - tone
    - size
    - shape
    - state (enabled/disabled/loading/selected)
    - effects toggles
  - code snippet panel (copy button)

- **Combinations**
  - automated matrix: rows = variants, columns = sizes or tones

- **Effects Playground**
  - interactive toggles for each effect
  - sliders for effect parameters (scale factor, duration, glow intensity)

- **Accessibility**
  - focus traversal
  - keyboard activation (Enter/Space)
  - semantics labels

#### UX recommendations

- Use `NavigationRail` (desktop/web) + `BottomNavigationBar` (mobile) with responsive layout.
- Provide dark/light toggle and seed color control.
- Keep scrolling smooth (use slivers for large lists).

### 2.7 Testing strategy

Minimum tests:

- `SuperButton` renders label and icons correctly.
- Disabled state blocks taps.
- Loading state shows spinner and blocks taps.
- Style resolver produces expected colors for each variant/tone/state.

### 2.8 Definition of Done (Phase 2)

Phase 2 is done when:

- The package exposes a stable API entrypoint in `lib/super_button_package.dart`.
- At least the minimum variant/effect set is implemented.
- The `example/` app demonstrates all variants, sizes, shapes, states, and effects.
- Analyzer and tests pass locally.

### 2.9 Current implementation status (as of package 0.3.x)

- **Layout / API** — [doc/PHASE_1_SETUP.md](PHASE_1_SETUP.md) public surface: `SuperButton` (+ `selected`), `SuperButtonStyle`, `SuperButtonEffect`, `SuperButtonTokens`, and **interaction** state.
- **Style resolution** — `SuperButtonColorResolver` + `SuperButtonColorResolution` map [variant + tone + enabled + **selected**] to `ColorScheme` roles; optional **style overrides** apply first, then **selected** (chip-like `secondaryContainer` / `onSecondaryContainer` except danger), then disabled.
- **Utilities** — `SuperColorUtils` (disabled foreground opacity) for resolvers and tests.
- **Effects (built-in)** — `SuperInkRippleEffect`, `SuperScaleEffect` (animated `Matrix4` scale + duration), `SuperElevationEffect`, `SuperFocusRingEffect`, `SuperLoadingSpinnerEffect`, `SuperIdentityEffect`.
- **Widget** — `SuperButton` is stateful: hover, press, `FocusNode` on M3 buttons, `Semantics.selected`; loading disables press.
- **Example** — Gallery: `CustomScrollView` + filters including **Selected**, effect toggles, copyable snippet, `VariantGrid`. Combinations: **matrix** (v1 min variants × size or tone) with horizontal scroll. Effects playground: per-effect **toggles and sliders** (scale, duration, ring width, elevation, spinner). Accessibility: `FocusScope` + `TextField` + buttons with `semanticLabel` / `tooltip`. Main: `NavigationRail` (wide) + **seed** + theme. Placeholder doc: [PLACEHOLDER_VARIANTS.md](PLACEHOLDER_VARIANTS.md). Toggle/segmented/chip: [PHASE_1_FUTURE_CATALOG.md](PHASE_1_FUTURE_CATALOG.md).
- **Still evolving (toward v1.0)** — true `gradient` / `glass` / `neumorphic` paint paths; optional `SuperShimmerEffect` / haptics; gallery code snippet could emit exact non-`const` effect lists.

