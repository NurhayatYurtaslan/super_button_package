import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_button_package/super_button_package.dart';

import '../components/variant_grid.dart';

/// Gallery: filter panel + live preview + copyable code snippet (see [doc/PHASE_2_PACKAGE_AND_EXAMPLES.md] §2.6).
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  SuperButtonVariant _variant = SuperButtonVariant.filled;
  SuperButtonSize _size = SuperButtonSize.md;
  SuperButtonShape _shape = SuperButtonShape.rounded;
  SuperButtonTone _tone = SuperButtonTone.primary;
  bool _enabled = true;
  bool _loading = false;
  bool _ink = false;
  bool _scale = true;
  bool _focus = false;
  bool _elevation = false;
  bool _spinner = false; // when true, uses SuperLoadingSpinnerEffect (hides row spinner)

  String get _snippet {
    return '''
SuperButton(
  onPressed: () {},
  label: const Text('Preview'),
  style: const SuperButtonStyle(
    variant: SuperButtonVariant.${_variant.name},
    size: SuperButtonSize.${_size.name},
    shape: SuperButtonShape.${_shape.name},
    tone: SuperButtonTone.${_tone.name},
  ),
  enabled: $_enabled,
  loading: $_loading,
  effects: const [
    // add SuperScaleEffect(), SuperFocusRingEffect(), etc.
  ],
),''';
  }

  List<SuperButtonEffect> get _effectList {
    final List<SuperButtonEffect> f = <SuperButtonEffect>[];
    if (_ink) {
      f.add(const SuperInkRippleEffect());
    }
    if (_scale) {
      f.add(const SuperScaleEffect());
    }
    if (_focus) {
      f.add(const SuperFocusRingEffect());
    }
    if (_elevation) {
      f.add(const SuperElevationEffect());
    }
    if (_spinner) {
      f.add(const SuperLoadingSpinnerEffect());
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
        Text('Gallery', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          'Filter the preview, then copy the generated snippet below.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        _dropdown<SuperButtonVariant>(
          'Variant',
          _variant,
          SuperButtonVariant.values,
          (SuperButtonVariant v) => setState(() => _variant = v),
        ),
        const SizedBox(height: 8),
        _dropdown<SuperButtonSize>(
          'Size',
          _size,
          SuperButtonSize.values,
          (SuperButtonSize v) => setState(() => _size = v),
        ),
        const SizedBox(height: 8),
        _dropdown<SuperButtonShape>(
          'Shape',
          _shape,
          SuperButtonShape.values,
          (SuperButtonShape v) => setState(() => _shape = v),
        ),
        const SizedBox(height: 8),
        _dropdown<SuperButtonTone>(
          'Tone',
          _tone,
          SuperButtonTone.values,
          (SuperButtonTone v) => setState(() => _tone = v),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Enabled'),
          value: _enabled,
          onChanged: (bool v) => setState(() => _enabled = v),
        ),
        SwitchListTile(
          title: const Text('Loading'),
          value: _loading,
          onChanged: (bool v) => setState(() => _loading = v),
        ),
        const Divider(),
        const Text('Effects'),
        SwitchListTile(
          title: const Text('SuperInkRippleEffect (splash / highlight tint)'),
          value: _ink,
          onChanged: (bool v) => setState(() => _ink = v),
        ),
        SwitchListTile(
          title: const Text('SuperScaleEffect'),
          value: _scale,
          onChanged: (bool v) => setState(() => _scale = v),
        ),
        SwitchListTile(
          title: const Text('Focus ring (SuperFocusRingEffect)'),
          value: _focus,
          onChanged: (bool v) => setState(() => _focus = v),
        ),
        SwitchListTile(
          title: const Text('Elevation (SuperElevationEffect)'),
          value: _elevation,
          onChanged: (bool v) => setState(() => _elevation = v),
        ),
        SwitchListTile(
          title: const Text('Loading overlay (SuperLoadingSpinnerEffect)'),
          value: _spinner,
          onChanged: (bool v) => setState(() => _spinner = v),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: SuperButton(
            onPressed: () {},
            label: const Text('Preview'),
            tooltip: 'Live sample',
            semanticLabel: 'Preview',
            style: SuperButtonStyle(
              variant: _variant,
              size: _size,
              shape: _shape,
              tone: _tone,
            ),
            effects: _effectList,
            loading: _loading,
            enabled: _enabled,
          ),
        ),
        const SizedBox(height: 20),
        const Text('All baseline variants (quick)'),
        const SizedBox(height: 8),
        const VariantGrid(),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            FilledButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: _snippet));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Snippet copied')),
                  );
                }
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copy snippet'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Material(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SelectableText(
              _snippet,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown<T extends Object>(
    String label,
    T value,
    List<T> values,
    void Function(T) onChanged,
  ) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          items: values
              .map(
                (T e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(e.toString().split('.').last),
                ),
              )
              .toList(),
          onChanged: (T? v) {
            if (v != null) {
              onChanged(v);
            }
          },
        ),
      ),
    );
  }
}
