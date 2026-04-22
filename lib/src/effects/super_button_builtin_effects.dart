import 'package:flutter/material.dart';

import '../super_button_interaction_state.dart';
import 'super_button_effect.dart';

/// Emphasises Material splash on the subtree (M3 [ButtonStyle] also splashes; use
/// to tint splash/highlight for custom surfaces). See [doc/PHASE_2_PACKAGE_AND_EXAMPLES.md].
class SuperInkRippleEffect extends SuperButtonEffect {
  const SuperInkRippleEffect({
    this.splashColor,
    this.highlightColor,
  });

  final Color? splashColor;
  final Color? highlightColor;

  @override
  Widget apply(
    BuildContext context,
    SuperButtonInteractionState state,
    Widget child,
  ) {
    if (!state.enabled) {
      return child;
    }
    final ThemeData base = Theme.of(context);
    return Theme(
      data: base.copyWith(
        splashColor: splashColor ?? base.splashColor,
        highlightColor: highlightColor ?? base.highlightColor,
      ),
      child: child,
    );
  }
}

class SuperScaleEffect extends SuperButtonEffect {
  const SuperScaleEffect({this.pressedScale = 0.98});

  final double pressedScale;

  @override
  Widget apply(
    BuildContext context,
    SuperButtonInteractionState state,
    Widget child,
  ) {
    final double s = (state.pressed && state.enabled && !state.loading) ? pressedScale : 1.0;
    return Transform.scale(
      scale: s,
      alignment: Alignment.center,
      filterQuality: FilterQuality.low,
      child: child,
    );
  }
}

class SuperElevationEffect extends SuperButtonEffect {
  const SuperElevationEffect({this.hovered = 2.0, this.pressed = 1.0, this.base = 0.0});

  final double base;
  final double hovered;
  final double pressed;

  @override
  Widget apply(
    BuildContext context,
    SuperButtonInteractionState state,
    Widget child,
  ) {
    double e = base;
    if (state.pressed) {
      e += pressed;
    } else if (state.hovered) {
      e += hovered;
    }
    e = e.clamp(0.0, 24.0);
    if (e <= 0) {
      return child;
    }
    return Material(
      type: MaterialType.button,
      elevation: e,
      color: Colors.transparent,
      shadowColor: Theme.of(context).colorScheme.shadow,
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }
}

class SuperFocusRingEffect extends SuperButtonEffect {
  const SuperFocusRingEffect({this.width = 2.0, this.color});

  final double width;
  final Color? color;

  @override
  Widget apply(
    BuildContext context,
    SuperButtonInteractionState state,
    Widget child,
  ) {
    final Color c = color ?? Theme.of(context).colorScheme.primary;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      curve: Curves.ease,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: state.focused
            ? Border.all(color: c, width: width)
            : Border.all(color: Colors.transparent, width: width),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

class SuperLoadingSpinnerEffect extends SuperButtonEffect {
  const SuperLoadingSpinnerEffect({this.size = 22.0, this.strokeWidth = 2.0});

  final double size;
  final double strokeWidth;

  @override
  Widget apply(
    BuildContext context,
    SuperButtonInteractionState state,
    Widget child,
  ) {
    if (!state.loading) {
      return child;
    }
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0.45,
          child: AbsorbPointer(child: child),
        ),
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
