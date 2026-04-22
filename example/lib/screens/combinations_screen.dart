import 'package:flutter/material.dart';
import 'package:super_button_package/super_button_package.dart';

/// Variant × size/tone matrix (Phase 2).
class CombinationsScreen extends StatelessWidget {
  const CombinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        Text(
          'Combinations',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Phase 1: single row preview.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (final SuperButtonSize size in SuperButtonSize.values)
              SuperButton(
                onPressed: () {},
                label: Text(size.name),
                style: SuperButtonStyle(
                  variant: SuperButtonVariant.filled,
                  size: size,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
