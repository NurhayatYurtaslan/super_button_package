import 'package:flutter/material.dart';
import 'package:super_button_package/super_button_package.dart';

/// Focus, keyboard, semantics (Phase 2 fills in coverage).
class AccessibilityScreen extends StatelessWidget {
  const AccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        Text(
          'Accessibility',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Use Tab / Space / Enter to exercise default Material behavior.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        SuperButton(
          onPressed: () {},
          label: const Text('Label for screen readers'),
          style: const SuperButtonStyle(variant: SuperButtonVariant.outlined),
        ),
      ],
    );
  }
}
