import 'package:flutter/material.dart';
import 'package:super_button_package/super_button_package.dart';

import '../components/variant_grid.dart';

/// Placeholder for the full matrix + filters (Phase 2).
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        Text('Gallery', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        const VariantGrid(),
        const SizedBox(height: 24),
        SuperButton(
          onPressed: () {},
          label: const Text('Sample filled'),
          style: const SuperButtonStyle(
            variant: SuperButtonVariant.filled,
            size: SuperButtonSize.md,
            shape: SuperButtonShape.pill,
          ),
          effects: const <SuperButtonEffect>[SuperIdentityEffect()],
        ),
      ],
    );
  }
}
