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
    final SuperButtonTone effectiveTone =
        style.variant == SuperButtonVariant.destructive
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

    if (!state.enabled) {
      return _forDisabled(r, scheme);
    }
    if (state.selected) {
      return _forSelected(
        r,
        scheme,
        style.variant,
        effectiveTone,
      );
    }
    return r;
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

/// Outlined / text / link: no button fill, so the label sits on the page
/// [ColorScheme.surface]. Use chromatic *ink* (e.g. [ColorScheme.primary]), not
/// the *on* role (e.g. [ColorScheme.onPrimary]) meant for text on a solid
/// [ColorScheme.primary] bar — otherwise in light mode label and background read
/// the same.
Color _inkOnPageSurfaceForBorderless(
  _TonePair p,
  SuperButtonTone effectiveTone,
) {
  switch (effectiveTone) {
    case SuperButtonTone.neutral:
      return p.foreground;
    case SuperButtonTone.primary:
    case SuperButtonTone.success:
    case SuperButtonTone.warning:
    case SuperButtonTone.danger:
      return p.background;
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
        foreground: _inkOnPageSurfaceForBorderless(p, effectiveTone),
        outline: style.borderOverride?.color ?? scheme.outline,
        shadow: null,
        elevation: 0.0,
      );
    case SuperButtonVariant.text:
    case SuperButtonVariant.link:
      return SuperButtonColorResolution(
        background: null,
        foreground: _inkOnPageSurfaceForBorderless(p, effectiveTone),
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

/// Selected (e.g. filter chip, pressed segment) state: role-based emphasis on [ColorScheme].
SuperButtonColorResolution _forSelected(
  SuperButtonColorResolution base,
  ColorScheme scheme,
  SuperButtonVariant variant,
  SuperButtonTone effectiveTone,
) {
  // Danger tone: keep error-tinted selection
  if (effectiveTone == SuperButtonTone.danger) {
    return SuperButtonColorResolution(
      background: scheme.errorContainer,
      foreground: scheme.onErrorContainer,
      outline: base.outline,
      shadow: base.shadow,
      elevation: base.elevation,
    );
  }

  // Default: "chip selected" look using container roles
  final Color fill = scheme.secondaryContainer;
  final Color onFill = scheme.onSecondaryContainer;
  const double subtleAlpha = 0.35;

  switch (variant) {
    case SuperButtonVariant.outlined:
      return SuperButtonColorResolution(
        background: fill.withValues(alpha: fill.a * subtleAlpha * 1.2),
        foreground: onFill,
        outline: base.outline ?? scheme.outline,
        shadow: null,
        elevation: 0.0,
      );
    case SuperButtonVariant.text:
    case SuperButtonVariant.link:
      return SuperButtonColorResolution(
        background: fill.withValues(alpha: fill.a * subtleAlpha),
        foreground: onFill,
        outline: null,
        shadow: null,
        elevation: 0.0,
      );
    case SuperButtonVariant.tonal:
    case SuperButtonVariant.filled:
    case SuperButtonVariant.destructive:
    case SuperButtonVariant.icon:
    case SuperButtonVariant.fab:
    case SuperButtonVariant.elevated:
    case SuperButtonVariant.gradient:
    case SuperButtonVariant.glass:
    case SuperButtonVariant.neumorphic:
      return SuperButtonColorResolution(
        background: fill,
        foreground: onFill,
        outline: null,
        shadow: base.shadow,
        elevation: variant == SuperButtonVariant.elevated
            ? base.elevation + 0.5
            : base.elevation,
      );
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
