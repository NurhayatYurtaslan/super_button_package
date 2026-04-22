import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'super_button_enums.dart';

@immutable
class SuperButtonStyle {
  const SuperButtonStyle({
    this.variant = SuperButtonVariant.filled,
    this.size = SuperButtonSize.md,
    this.shape = SuperButtonShape.rounded,
    this.tone = SuperButtonTone.primary,
    this.paddingOverride,
    this.textStyleOverride,
    this.backgroundColorOverride,
    this.foregroundColorOverride,
    this.borderOverride,
  });

  final SuperButtonVariant variant;
  final SuperButtonSize size;
  final SuperButtonShape shape;
  final SuperButtonTone tone;
  final EdgeInsets? paddingOverride;
  final TextStyle? textStyleOverride;
  final Color? backgroundColorOverride;
  final Color? foregroundColorOverride;
  final BorderSide? borderOverride;
}
