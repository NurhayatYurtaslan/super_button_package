import 'package:flutter/material.dart';

import 'effects/super_button_effect.dart';
import 'style/super_button_enums.dart';
import 'style/super_button_style.dart';
import 'super_button_interaction_state.dart';
import 'tokens/super_button_tokens.dart';

/// Primary API widget for the package.
///
/// Phase 1: Material-based placeholder that respects [SuperButtonStyle] shape/size
/// and runs the [effects] stack with a static interaction state. Full resolvers
/// and state-complete visuals arrive in Phase 2.
class SuperButton extends StatelessWidget {
  const SuperButton({
    super.key,
    required this.onPressed,
    this.label,
    this.leading,
    this.trailing,
    this.style = const SuperButtonStyle(),
    this.effects = const [],
    this.loading = false,
    this.enabled = true,
  });

  final VoidCallback? onPressed;
  final Widget? label;
  final Widget? leading;
  final Widget? trailing;
  final SuperButtonStyle style;
  final List<SuperButtonEffect> effects;
  final bool loading;
  final bool enabled;

  static const SuperButtonInteractionState _placeholderInteraction =
      SuperButtonInteractionState(
    pressed: false,
    hovered: false,
    focused: false,
    enabled: true,
    loading: false,
    selected: false,
  );

  @override
  Widget build(BuildContext context) {
    final bool interactive =
        enabled && onPressed != null && !loading;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final SuperButtonTokens tokens = SuperButtonTokens.of(style);
    final double minSize = tokens.minTapTarget;
    const double defaultRadius = 8;
    final BorderRadius radius = tokens.borderRadiusFor(defaultRadius);

    final Widget? content = _buildContent(context);
    assert(
      content != null || style.variant == SuperButtonVariant.icon,
      'SuperButton requires a label unless variant is icon (Phase 2).',
    );

    return _wrapEffects(
      context,
      ConstrainedBox(
        constraints: BoxConstraints(minWidth: minSize, minHeight: minSize),
        child: _buildButton(
          context: context,
          scheme: scheme,
          tokens: tokens,
          radius: radius,
          onPressed: interactive ? onPressed : null,
          child: content ?? const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget? _buildContent(BuildContext context) {
    if (label == null && leading == null && trailing == null) {
      return null;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (leading != null) ...<Widget>[leading!, const SizedBox(width: 8)],
        if (label != null) Flexible(child: label!),
        if (trailing != null) ...<Widget>[
          const SizedBox(width: 8),
          trailing!,
        ],
        if (loading) ...<Widget>[
          const SizedBox(width: 8),
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ],
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required ColorScheme scheme,
    required SuperButtonTokens tokens,
    required BorderRadius radius,
    required VoidCallback? onPressed,
    required Widget child,
  }) {
    switch (style.variant) {
      case SuperButtonVariant.filled:
      case SuperButtonVariant.destructive:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: style.tone == SuperButtonTone.danger
                ? scheme.error
                : null,
            foregroundColor: style.tone == SuperButtonTone.danger
                ? scheme.onError
                : null,
            padding: tokens.contentPadding,
            shape: RoundedRectangleBorder(borderRadius: radius),
            textStyle: style.textStyleOverride,
          ),
          child: child,
        );
      case SuperButtonVariant.tonal:
        return FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: tokens.contentPadding,
            shape: RoundedRectangleBorder(borderRadius: radius),
            textStyle: style.textStyleOverride,
          ),
          child: child,
        );
      case SuperButtonVariant.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: tokens.contentPadding,
            shape: RoundedRectangleBorder(borderRadius: radius),
            textStyle: style.textStyleOverride,
            side: style.borderOverride,
          ),
          child: child,
        );
      case SuperButtonVariant.text:
      case SuperButtonVariant.link:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: tokens.contentPadding,
            shape: RoundedRectangleBorder(borderRadius: radius),
            textStyle: style.textStyleOverride,
          ),
          child: child,
        );
      case SuperButtonVariant.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: tokens.contentPadding,
            shape: RoundedRectangleBorder(borderRadius: radius),
            textStyle: style.textStyleOverride,
          ),
          child: child,
        );
      case SuperButtonVariant.icon:
      case SuperButtonVariant.fab:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: tokens.contentPadding,
            shape: RoundedRectangleBorder(borderRadius: radius),
            textStyle: style.textStyleOverride,
          ),
          child: child,
        );
      case SuperButtonVariant.gradient:
      case SuperButtonVariant.glass:
      case SuperButtonVariant.neumorphic:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: tokens.contentPadding,
            shape: RoundedRectangleBorder(borderRadius: radius),
            textStyle: style.textStyleOverride,
          ),
          child: child,
        );
    }
  }

  Widget _wrapEffects(BuildContext context, Widget child) {
    Widget out = child;
    for (final SuperButtonEffect e in effects) {
      out = e.apply(
        context,
        loading
            ? _placeholderInteraction.copyWith(loading: true, enabled: enabled)
            : _placeholderInteraction.copyWith(enabled: enabled),
        out,
      );
    }
    return out;
  }
}
