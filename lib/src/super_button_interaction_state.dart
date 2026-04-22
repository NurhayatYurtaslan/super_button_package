import 'package:flutter/foundation.dart';

/// Input for style resolution and effect stacks (see doc/PHASE_2_PACKAGE_AND_EXAMPLES.md).
@immutable
class SuperButtonInteractionState {
  const SuperButtonInteractionState({
    required this.pressed,
    required this.hovered,
    required this.focused,
    required this.enabled,
    required this.loading,
    required this.selected,
  });

  final bool pressed;
  final bool hovered;
  final bool focused;
  final bool enabled;
  final bool loading;
  final bool selected;

  SuperButtonInteractionState copyWith({
    bool? pressed,
    bool? hovered,
    bool? focused,
    bool? enabled,
    bool? loading,
    bool? selected,
  }) {
    return SuperButtonInteractionState(
      pressed: pressed ?? this.pressed,
      hovered: hovered ?? this.hovered,
      focused: focused ?? this.focused,
      enabled: enabled ?? this.enabled,
      loading: loading ?? this.loading,
      selected: selected ?? this.selected,
    );
  }
}
