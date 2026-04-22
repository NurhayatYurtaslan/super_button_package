import 'package:flutter/material.dart';
import 'package:super_button_package/super_button_package.dart';

/// Simple grid to preview a subset of variants (Phase 2 expands this).
class VariantGrid extends StatelessWidget {
  const VariantGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const List<SuperButtonVariant> row = <SuperButtonVariant>[
      SuperButtonVariant.filled,
      SuperButtonVariant.tonal,
      SuperButtonVariant.outlined,
      SuperButtonVariant.text,
      SuperButtonVariant.elevated,
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: row
          .map(
            (SuperButtonVariant v) => SuperButton(
              onPressed: () {},
              label: Text(v.name),
              style: SuperButtonStyle(variant: v),
            ),
          )
          .toList(),
    );
  }
}
