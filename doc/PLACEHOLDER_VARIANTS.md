# Placeholder variants (`gradient`, `glass`, `neumorphic`)

As of the current release, [`SuperButtonVariant.gradient`](../lib/src/style/super_button_enums.dart), `glass`, and `neumorphic` are **enumerated for forward compatibility** but use the same **Material `FilledButton` fallback** as a filled button in [`super_button.dart`](../lib/src/super_button.dart) and [`SuperButtonColorResolver`](../lib/src/style/resolver/super_button_color_resolver.dart) until:

- **Gradient** — a dedicated gradient decoration (and optional shift effect) with documented contrast rules.
- **Glass** — backdrop blur strategy (including web/fallback), border, and performance notes.
- **Neumorphic** — light-source tokens, inner/outer shadows, and dark-theme constraints.

Track API and behavior in [`PHASE_2_PACKAGE_AND_EXAMPLES.md`](PHASE_2_PACKAGE_AND_EXAMPLES.md) and the [CHANGELOG](../CHANGELOG.md).
