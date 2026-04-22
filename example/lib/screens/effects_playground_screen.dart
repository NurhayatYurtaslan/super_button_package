import 'package:flutter/material.dart';
import 'package:super_button_package/super_button_package.dart';

/// Interactive [SuperButtonEffect] controls (see [doc/PHASE_2_PACKAGE_AND_EXAMPLES.md] §2.6).
class EffectsPlaygroundScreen extends StatefulWidget {
  const EffectsPlaygroundScreen({super.key});

  @override
  State<EffectsPlaygroundScreen> createState() =>
      _EffectsPlaygroundScreenState();
}

class _EffectsPlaygroundScreenState extends State<EffectsPlaygroundScreen> {
  bool _ink = true;
  bool _scale = true;
  bool _focus = true;
  bool _elevation = true;
  bool _spinner = false;
  double _pressedScale = 0.95;
  int _scaleMs = 100;
  double _elevationBase = 0.0;
  double _elevationHover = 2.0;
  double _elevationPress = 1.0;
  double _ringWidth = 2.0;
  double _spinnerSize = 24.0;
  double _spinnerStroke = 2.0;

  List<SuperButtonEffect> get _stack {
    final List<SuperButtonEffect> f = <SuperButtonEffect>[];
    if (_ink) {
      f.add(const SuperInkRippleEffect());
    }
    if (_scale) {
      f.add(
        SuperScaleEffect(
          pressedScale: _pressedScale,
          duration: Duration(milliseconds: _scaleMs),
        ),
      );
    }
    if (_focus) {
      f.add(SuperFocusRingEffect(width: _ringWidth));
    }
    if (_elevation) {
      f.add(
        SuperElevationEffect(
          base: _elevationBase,
          hovered: _elevationHover,
          pressed: _elevationPress,
        ),
      );
    }
    if (_spinner) {
      f.add(
        SuperLoadingSpinnerEffect(
          size: _spinnerSize,
          strokeWidth: _spinnerStroke,
        ),
      );
    }
    if (f.isEmpty) {
      f.add(const SuperIdentityEffect());
    }
    return f;
  }

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
          'Toggle each effect, then use sliders. Glow intensity is not a separate class yet — '
          'see doc §2.5 optional effects.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('SuperInkRippleEffect'),
          value: _ink,
          onChanged: (bool v) => setState(() => _ink = v),
        ),
        SwitchListTile(
          title: const Text('SuperScaleEffect'),
          value: _scale,
          onChanged: (bool v) => setState(() => _scale = v),
        ),
        if (_scale) ...<Widget>[
          Text('  pressedScale: ${_pressedScale.toStringAsFixed(2)}'),
          Slider(
            value: _pressedScale,
            min: 0.9,
            max: 1.0,
            onChanged: (double v) => setState(() => _pressedScale = v),
          ),
          Text('  duration: $_scaleMs ms'),
          Slider(
            value: _scaleMs.toDouble(),
            min: 0,
            max: 500,
            divisions: 50,
            label: '$_scaleMs',
            onChanged: (double v) =>
                setState(() => _scaleMs = v.round().clamp(0, 500)),
          ),
        ],
        SwitchListTile(
          title: const Text('SuperFocusRingEffect'),
          value: _focus,
          onChanged: (bool v) => setState(() => _focus = v),
        ),
        if (_focus) ...<Widget>[
          Text('  width: ${_ringWidth.toStringAsFixed(1)}'),
          Slider(
            value: _ringWidth,
            min: 0.5,
            max: 4,
            onChanged: (double v) => setState(() => _ringWidth = v),
          ),
        ],
        SwitchListTile(
          title: const Text('SuperElevationEffect'),
          value: _elevation,
          onChanged: (bool v) => setState(() => _elevation = v),
        ),
        if (_elevation) ...<Widget>[
          Text('  base: ${_elevationBase.toStringAsFixed(1)}'),
          Slider(
            value: _elevationBase,
            min: 0,
            max: 8,
            onChanged: (double v) => setState(() => _elevationBase = v),
          ),
          Text('  hover: ${_elevationHover.toStringAsFixed(1)}'),
          Slider(
            value: _elevationHover,
            min: 0,
            max: 12,
            onChanged: (double v) => setState(() => _elevationHover = v),
          ),
          Text('  press: ${_elevationPress.toStringAsFixed(1)}'),
          Slider(
            value: _elevationPress,
            min: 0,
            max: 8,
            onChanged: (double v) => setState(() => _elevationPress = v),
          ),
        ],
        SwitchListTile(
          title: const Text('SuperLoadingSpinnerEffect'),
          value: _spinner,
          onChanged: (bool v) => setState(() => _spinner = v),
        ),
        if (_spinner) ...<Widget>[
          Text('  size: ${_spinnerSize.toStringAsFixed(0)}'),
          Slider(
            value: _spinnerSize,
            min: 12,
            max: 40,
            onChanged: (double v) => setState(() => _spinnerSize = v),
          ),
          Text('  stroke: ${_spinnerStroke.toStringAsFixed(1)}'),
          Slider(
            value: _spinnerStroke,
            min: 0.5,
            max: 4,
            onChanged: (double v) => setState(() => _spinnerStroke = v),
          ),
        ],
        const SizedBox(height: 16),
        const Text('Sample button'),
        const SizedBox(height: 8),
        SuperButton(
          onPressed: () {},
          label: const Text('Press / hover / focus me'),
          style: const SuperButtonStyle(
            variant: SuperButtonVariant.filled,
            tone: SuperButtonTone.primary,
          ),
          effects: _stack,
          loading: _spinner,
        ),
      ],
    );
  }
}
