import 'package:flutter/widgets.dart';

import '../super_button_interaction_state.dart';

/// Composable, stackable interaction / feedback layer (see docs).
///
/// Phase 1 provides the type system; concrete effects land in Phase 2.
abstract class SuperButtonEffect {
  const SuperButtonEffect();

  Widget apply(
    BuildContext context,
    SuperButtonInteractionState state,
    Widget child,
  );
}

/// Placeholder that leaves [child] unchanged; useful for API smoke tests.
class SuperIdentityEffect extends SuperButtonEffect {
  const SuperIdentityEffect();

  @override
  Widget apply(
    BuildContext context,
    SuperButtonInteractionState state,
    Widget child,
  ) =>
      child;
}
