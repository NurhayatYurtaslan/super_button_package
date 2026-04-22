import 'package:flutter/material.dart';

import 'effects/super_button_builtin_effects.dart';
import 'effects/super_button_effect.dart';
import 'style/resolver/super_button_color_resolver.dart';
import 'style/super_button_enums.dart';
import 'style/super_button_style.dart';
import 'super_button_interaction_state.dart';
import 'tokens/super_button_tokens.dart';

/// Primary API widget for the package.
///
/// Uses [SuperButtonColorResolver] for theme mapping and a stack of
/// [SuperButtonEffect]s for feedback. See [doc/PHASE_2_PACKAGE_AND_EXAMPLES.md].
class SuperButton extends StatefulWidget {
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
    this.selected = false,
    this.semanticLabel,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final Widget? label;
  final Widget? leading;
  final Widget? trailing;
  final SuperButtonStyle style;
  final List<SuperButtonEffect> effects;
  final bool loading;
  final bool enabled;

  /// Visual / semantic "on" state (e.g. filter, segment). Drives [SuperButtonColorResolver] and [Semantics.selected].
  final bool selected;

  /// [Semantics] label; falls back to the widget’s [tooltip] if non-null.
  final String? semanticLabel;

  /// Shown on long-press / hover; optional.
  final String? tooltip;

  @override
  State<SuperButton> createState() => _SuperButtonState();
}

class _SuperButtonState extends State<SuperButton> {
  bool _hover = false;
  bool _pressed = false;
  late final FocusNode _focusNode = FocusNode();

  bool get _hasLoadingSpinnerEffect => widget.effects
      .any((SuperButtonEffect e) => e is SuperLoadingSpinnerEffect);

  SuperButtonInteractionState get _interaction {
    return SuperButtonInteractionState(
      pressed: _pressed,
      hovered: _hover,
      focused: _focusNode.hasFocus,
      enabled: widget.enabled,
      loading: widget.loading,
      selected: widget.selected,
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusNodeChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusNodeChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusNodeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool interactive =
        widget.enabled && widget.onPressed != null && !widget.loading;
    final SuperButtonTokens tokens = SuperButtonTokens.of(widget.style);
    final double minSize = tokens.minTapTarget;
    const double defaultRadius = 8;
    final BorderRadius radius = tokens.borderRadiusFor(defaultRadius);
    final SuperButtonColorResolution colors = SuperButtonColorResolver.resolve(
      context,
      widget.style,
      _interaction,
    );
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final Widget? content = _buildContent(colors);
    assert(
      content != null ||
          ((widget.style.variant == SuperButtonVariant.icon ||
                  widget.style.variant == SuperButtonVariant.fab) &&
              widget.leading != null),
      'SuperButton needs `label`/`trailing` content, or for icon/fab a non-null `leading`.',
    );

    Widget child = _wrapEffects(
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minSize,
          minHeight: minSize,
        ),
        child: _buildButton(
          focusNode: _focusNode,
          scheme: scheme,
          colors: colors,
          tokens: tokens,
          radius: radius,
          onPressed: interactive ? widget.onPressed : null,
          child: content ?? (widget.leading ?? const SizedBox.shrink()),
        ),
      ),
    );

    child = MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: child,
    );

    child = Listener(
      onPointerDown: (_) => setState(() => _pressed = true),
      onPointerUp: (_) => setState(() => _pressed = false),
      onPointerCancel: (_) => setState(() => _pressed = false),
      child: child,
    );

    if (widget.tooltip != null) {
      child = Tooltip(
        message: widget.tooltip!,
        child: child,
      );
    }

    child = Semantics(
      button: true,
      label: widget.semanticLabel,
      selected: widget.selected,
      child: child,
    );

    return child;
  }

  Widget? _buildContent(SuperButtonColorResolution colors) {
    if (widget.label == null &&
        widget.leading == null &&
        widget.trailing == null) {
      return null;
    }
    final bool showRowSpinner = widget.loading && !_hasLoadingSpinnerEffect;
    final Color? fg = colors.foreground;
    // Ensure label/icon color matches the resolved role (M3 + web: nested Row/Flexible
    // can miss DefaultTextStyle from ButtonStyle, hurting contrast in light mode).
    Widget? inkLeading = widget.leading;
    Widget? inkLabel = widget.label;
    Widget? inkTrailing = widget.trailing;
    if (fg != null) {
      if (inkLeading != null) {
        final Widget lead = inkLeading;
        inkLeading = IconTheme.merge(
          data: IconThemeData(color: fg),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: fg),
            child: lead,
          ),
        );
      }
      if (inkLabel != null) {
        final Widget lab = inkLabel;
        inkLabel = IconTheme.merge(
          data: IconThemeData(color: fg),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: fg),
            child: lab,
          ),
        );
      }
      if (inkTrailing != null) {
        final Widget trail = inkTrailing;
        inkTrailing = IconTheme.merge(
          data: IconThemeData(color: fg),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: fg),
            child: trail,
          ),
        );
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (inkLeading != null) ...<Widget>[inkLeading, const SizedBox(width: 8)],
        if (inkLabel != null) Flexible(child: inkLabel),
        if (inkTrailing != null) ...<Widget>[
          const SizedBox(width: 8),
          inkTrailing,
        ],
        if (showRowSpinner) ...<Widget>[
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
    required FocusNode focusNode,
    required ColorScheme scheme,
    required SuperButtonColorResolution colors,
    required SuperButtonTokens tokens,
    required BorderRadius radius,
    required VoidCallback? onPressed,
    required Widget child,
  }) {
    final RoundedRectangleBorder shape =
        RoundedRectangleBorder(borderRadius: radius);
    final TextStyle? textStyle = widget.style.textStyleOverride;

    final BorderSide? side = widget.style.borderOverride ??
        (colors.outline != null ? BorderSide(color: colors.outline!) : null);

    switch (widget.style.variant) {
      case SuperButtonVariant.filled:
      case SuperButtonVariant.destructive:
      case SuperButtonVariant.icon:
      case SuperButtonVariant.fab:
      // gradient / glass / neumorphic: see doc/PLACEHOLDER_VARIANTS.md (filled fallback until v1 paint path).
      case SuperButtonVariant.gradient:
      case SuperButtonVariant.glass:
      case SuperButtonVariant.neumorphic:
        return FilledButton(
          focusNode: focusNode,
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: colors.background,
            foregroundColor: colors.foreground,
            padding: tokens.contentPadding,
            shape: shape,
            textStyle: textStyle,
            shadowColor: colors.shadow,
          ),
          child: child,
        );
      case SuperButtonVariant.tonal:
        return FilledButton.tonal(
          focusNode: focusNode,
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: colors.background,
            foregroundColor: colors.foreground,
            padding: tokens.contentPadding,
            shape: shape,
            textStyle: textStyle,
            shadowColor: colors.shadow,
          ),
          child: child,
        );
      case SuperButtonVariant.outlined:
        return OutlinedButton(
          focusNode: focusNode,
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.foreground,
            backgroundColor: colors.background,
            padding: tokens.contentPadding,
            shape: shape,
            textStyle: textStyle,
            side: side,
          ),
          child: child,
        );
      case SuperButtonVariant.text:
        return TextButton(
          focusNode: focusNode,
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: colors.foreground,
            padding: tokens.contentPadding,
            shape: shape,
            textStyle: textStyle,
          ),
          child: child,
        );
      case SuperButtonVariant.link:
        return TextButton(
          focusNode: focusNode,
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: colors.foreground ?? scheme.primary,
            padding: tokens.contentPadding,
            shape: shape,
            textStyle: textStyle?.copyWith(
                  decoration: TextDecoration.underline,
                ) ??
                const TextStyle(decoration: TextDecoration.underline),
          ),
          child: child,
        );
      case SuperButtonVariant.elevated:
        return ElevatedButton(
          focusNode: focusNode,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.background,
            foregroundColor: colors.foreground,
            elevation: colors.elevation,
            shadowColor: colors.shadow,
            padding: tokens.contentPadding,
            shape: shape,
            textStyle: textStyle,
          ),
          child: child,
        );
    }
  }

  Widget _wrapEffects(Widget child) {
    Widget out = child;
    for (final SuperButtonEffect e in widget.effects) {
      out = e.apply(
        context,
        _interaction,
        out,
      );
    }
    return out;
  }
}
