import 'package:flutter/material.dart';
import 'package:super_button_package/super_button_package.dart';

/// Focus order, keyboard activation (Material buttons), and semantics samples.
/// See [doc/PHASE_2_PACKAGE_AND_EXAMPLES.md] §2.6.
class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  final TextEditingController _field = TextEditingController();

  @override
  void dispose() {
    _field.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          Text(
            'Accessibility',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Use Tab to move: text field, then the buttons. Activate with Enter or Space when focused. '
            'Enable VoiceOver / TalkBack to hear semanticLabel and state.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _field,
            decoration: const InputDecoration(
              labelText: 'Name (first focusable)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          SuperButton(
            onPressed: () {},
            label: const Text('Primary action'),
            semanticLabel: 'Primary action',
            tooltip: 'Runs the primary example action',
            style: const SuperButtonStyle(variant: SuperButtonVariant.filled),
          ),
          const SizedBox(height: 8),
          SuperButton(
            onPressed: () {},
            label: const Text('Secondary'),
            semanticLabel: 'Secondary',
            style: const SuperButtonStyle(variant: SuperButtonVariant.outlined),
          ),
          const SizedBox(height: 8),
          SuperButton(
            onPressed: () {},
            label: const Text('Selected look'),
            semanticLabel: 'Filter item selected',
            style: const SuperButtonStyle(
              variant: SuperButtonVariant.tonal,
              tone: SuperButtonTone.neutral,
            ),
            selected: true,
          ),
        ],
      ),
    );
  }
}
