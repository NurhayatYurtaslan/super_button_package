import 'package:flutter/painting.dart';

import '../style/super_button_enums.dart';
import '../style/super_button_style.dart';

/// Layout tokens (padding, min height, border radius) derived from [SuperButtonStyle].
///
/// Refined in Phase 2; Phase 1 keeps values stable for scaffolding.
class SuperButtonTokens {
  SuperButtonTokens._(this._style);

  final SuperButtonStyle _style;

  static SuperButtonTokens of(SuperButtonStyle style) =>
      SuperButtonTokens._(style);

  EdgeInsets get contentPadding {
    if (_style.paddingOverride != null) {
      return _style.paddingOverride!;
    }
    switch (_style.size) {
      case SuperButtonSize.xs:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
      case SuperButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case SuperButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case SuperButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
      case SuperButtonSize.xl:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
    }
  }

  /// Minimum along the main axis; enforced in the widget in Phase 2.
  double get minTapTarget {
    switch (_style.size) {
      case SuperButtonSize.xs:
        return 36;
      case SuperButtonSize.sm:
        return 40;
      case SuperButtonSize.md:
        return 44;
      case SuperButtonSize.lg:
        return 48;
      case SuperButtonSize.xl:
        return 52;
    }
  }

  BorderRadius borderRadiusFor(double defaultRadius) {
    switch (_style.shape) {
      case SuperButtonShape.rounded:
        return BorderRadius.circular(defaultRadius);
      case SuperButtonShape.pill:
        return BorderRadius.circular(999);
      case SuperButtonShape.stadium:
        return BorderRadius.circular(999);
      case SuperButtonShape.circle:
        return BorderRadius.circular(999);
      case SuperButtonShape.squircle:
        return BorderRadius.circular(defaultRadius * 1.1);
      case SuperButtonShape.cutCorner:
        return const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(4),
        );
    }
  }
}
