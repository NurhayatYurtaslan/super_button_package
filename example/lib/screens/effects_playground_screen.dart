import 'package:flutter/material.dart';
import 'package:super_button_package/super_button_package.dart';

/// Interactive [SuperButtonEffect] samples (sliders; see [doc/PHASE_2_PACKAGE_AND_EXAMPLES.md] §2.6).
class EffectsPlaygroundScreen extends StatefulWidget {
  const EffectsPlaygroundScreen({super.key});

  @override
  State<EffectsPlaygroundScreen> createState() => _EffectsPlaygroundScreenState();
}

class _EffectsPlaygroundScreenState extends State<EffectsPlaygroundScreen> {
  double _pressedScale = 0.95;

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
          'Tweak [SuperScaleEffect] press scale. Other effects are combined on the same button.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text('Scale: ${_pressedScale.toStringAsFixed(2)}'),
        Slider(
          min: 0.9,
          max: 1.0,
          value: _pressedScale,
          onChanged: (double v) => setState(() => _pressedScale = v),
        ),
        const SizedBox(height: 16),
        SuperButton(
          onPressed: () {},
          label: const Text('Scale + focus + ink'),
          style: const SuperButtonStyle(
            variant: SuperButtonVariant.filled,
            tone: SuperButtonTone.primary,
          ),
          effects: <SuperButtonEffect>[
            SuperScaleEffect(pressedScale: _pressedScale),
            const SuperFocusRingEffect(),
            const SuperInkRippleEffect(),
          ],
        ),
      ],
    );
  }
}
