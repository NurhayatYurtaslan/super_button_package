import 'dart:ui' show Color;

/// Shared color math for the button resolvers and theme integration.
class SuperColorUtils {
  /// On-surface opacity for disabled *foreground* (Material 3).
  static const double disabledForegroundOpacity = 0.38;

  static Color applyDisabledForeground(Color source) {
    return source.withValues(alpha: source.a * disabledForegroundOpacity);
  }
}
