import 'package:flutter/material.dart';
import 'package:super_button_package/super_button_package.dart';

/// Toggles and sliders for effects (Phase 2).
class EffectsPlaygroundScreen extends StatelessWidget {
  const EffectsPlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        Text(
          'Effects playground',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Phase 1 scaffold: add effect toggles in Phase 2.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        SuperButton(
          onPressed: () {},
          label: const Text('With identity effect'),
          style: const SuperButtonStyle(variant: SuperButtonVariant.tonal),
          effects: const <SuperButtonEffect>[SuperIdentityEffect()],
        ),
      ],
    );
  }
}
