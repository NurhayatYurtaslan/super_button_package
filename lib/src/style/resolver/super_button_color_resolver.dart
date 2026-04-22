import 'package:flutter/material.dart';

import '../../super_button_interaction_state.dart';
import '../../utils/super_color_utils.dart';
import '../super_button_enums.dart';
import '../super_button_style.dart';

/// Theme-derived paint tokens (variant, tone, interaction) for [SuperButton].
///
/// See [doc/PHASE_2_PACKAGE_AND_EXAMPLES.md]: style resolvers and tokens.
@immutable
class SuperButtonColorResolution {
  const SuperButtonColorResolution({
    this.background,
    this.foreground,
    this.outline,
    this.shadow,
    this.elevation = 0.0,
  });

  final Color? background;
  final Color? foreground;
  final Color? outline;
  final Color? shadow;
  final double elevation;
}

/// Maps [SuperButtonStyle] and [SuperButtonInteractionState] into [ColorScheme] roles.
class SuperButtonColorResolver {
  const SuperButtonColorResolver._();

  static SuperButtonColorResolution resolve(
    BuildContext context,
    SuperButtonStyle style,
    SuperButtonInteractionState state,
  ) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final SuperButtonTone effectiveTone = style.variant == SuperButtonVariant.destructive
        ? SuperButtonTone.danger
        : style.tone;
    final _TonePair pair = _mapTone(effectiveTone, scheme);

    SuperButtonColorResolution r = _resolveForVariant(
      style.variant,
      pair,
      scheme,
      style,
      effectiveTone,
    );

    if (style.backgroundColorOverride != null) {
      r = SuperButtonColorResolution(
        background: style.backgroundColorOverride,
        foreground: r.foreground,
        outline: r.outline,
        shadow: r.shadow,
        elevation: r.elevation,
      );
    }
    if (style.foregroundColorOverride != null) {
      r = SuperButtonColorResolution(
        background: r.background,
        foreground: style.foregroundColorOverride,
        outline: r.outline,
        shadow: r.shadow,
        elevation: r.elevation,
      );
    }

    if (state.enabled) {
      return r;
    }
    return _forDisabled(r, scheme);
  }
}

class _TonePair {
  const _TonePair(this.background, this.foreground);

  final Color background;
  final Color foreground;
}

_TonePair _mapTone(SuperButtonTone tone, ColorScheme s) {
  switch (tone) {
    case SuperButtonTone.primary:
      return _TonePair(s.primary, s.onPrimary);
    case SuperButtonTone.neutral:
      return _TonePair(s.surfaceContainerHighest, s.onSurface);
    case SuperButtonTone.success:
      return _TonePair(s.tertiary, s.onTertiary);
    case SuperButtonTone.warning:
      return _TonePair(s.secondary, s.onSecondary);
    case SuperButtonTone.danger:
      return _TonePair(s.error, s.onError);
  }
}

SuperButtonColorResolution _resolveForVariant(
  SuperButtonVariant variant,
  _TonePair p,
  ColorScheme scheme,
  SuperButtonStyle style,
  SuperButtonTone effectiveTone,
) {
  switch (variant) {
    case SuperButtonVariant.filled:
    case SuperButtonVariant.destructive:
    case SuperButtonVariant.icon:
    case SuperButtonVariant.fab:
    case SuperButtonVariant.gradient:
    case SuperButtonVariant.glass:
    case SuperButtonVariant.neumorphic:
      return SuperButtonColorResolution(
        background: p.background,
        foreground: p.foreground,
        outline: null,
        shadow: scheme.shadow,
        elevation: 0.0,
      );
    case SuperButtonVariant.tonal:
      final _TonePair t = _tonalContainers(effectiveTone, scheme);
      return SuperButtonColorResolution(
        background: t.background,
        foreground: t.foreground,
        outline: null,
        shadow: scheme.shadow,
        elevation: 0.0,
      );
    case SuperButtonVariant.outlined:
      return SuperButtonColorResolution(
        background: null,
        foreground: p.foreground,
        outline: style.borderOverride?.color ?? scheme.outline,
        shadow: null,
        elevation: 0.0,
      );
    case SuperButtonVariant.text:
    case SuperButtonVariant.link:
      return SuperButtonColorResolution(
        background: null,
        foreground: p.foreground,
        outline: null,
        shadow: null,
        elevation: 0.0,
      );
    case SuperButtonVariant.elevated:
      return SuperButtonColorResolution(
        background: p.background,
        foreground: p.foreground,
        outline: null,
        shadow: scheme.shadow,
        elevation: 1.0,
      );
  }
}

_TonePair _tonalContainers(SuperButtonTone tone, ColorScheme s) {
  switch (tone) {
    case SuperButtonTone.primary:
      return _TonePair(s.primaryContainer, s.onPrimaryContainer);
    case SuperButtonTone.neutral:
      return _TonePair(s.surfaceContainer, s.onSurface);
    case SuperButtonTone.success:
      return _TonePair(s.tertiaryContainer, s.onTertiaryContainer);
    case SuperButtonTone.warning:
      return _TonePair(s.secondaryContainer, s.onSecondaryContainer);
    case SuperButtonTone.danger:
      return _TonePair(s.errorContainer, s.onErrorContainer);
  }
}

SuperButtonColorResolution _forDisabled(
  SuperButtonColorResolution r,
  ColorScheme scheme,
) {
  final Color? fg = r.foreground != null
      ? SuperColorUtils.applyDisabledForeground(r.foreground!)
      : null;
  final Color? bg = r.background == null
      ? null
      : scheme.onSurface.withValues(
          alpha: 0.12 * scheme.onSurface.a,
        );
  return SuperButtonColorResolution(
    background: bg,
    foreground: fg,
    outline: r.outline?.withValues(
      alpha: r.outline!.a * SuperColorUtils.disabledForegroundOpacity,
    ),
    shadow: r.shadow,
    elevation: 0.0,
  );
}
