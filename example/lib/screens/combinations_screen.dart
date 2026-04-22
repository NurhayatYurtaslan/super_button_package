import 'package:flutter/material.dart';
import 'package:super_button_package/super_button_package.dart';

/// Matrix: rows = minimum variant set, columns = [SuperButtonSize] or [SuperButtonTone].
/// See [doc/PHASE_2_PACKAGE_AND_EXAMPLES.md] §2.6.
class CombinationsScreen extends StatefulWidget {
  const CombinationsScreen({super.key});

  @override
  State<CombinationsScreen> createState() => _CombinationsScreenState();
}

class _CombinationsScreenState extends State<CombinationsScreen> {
  /// v1 “minimum set” (doc §2.4) on one screen.
  static const List<SuperButtonVariant> _rows = <SuperButtonVariant>[
    SuperButtonVariant.filled,
    SuperButtonVariant.tonal,
    SuperButtonVariant.outlined,
    SuperButtonVariant.text,
    SuperButtonVariant.elevated,
    SuperButtonVariant.icon,
    SuperButtonVariant.destructive,
  ];

  _ColumnAxis _axis = _ColumnAxis.size;

  @override
  Widget build(BuildContext context) {
    final List<Widget> columnHeaders = <Widget>[
      const SizedBox(
        width: 88,
        child: Text('Variant', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    ];
    final List<SuperButtonSize> sizes = SuperButtonSize.values;
    final List<SuperButtonTone> tones = SuperButtonTone.values;

    if (_axis == _ColumnAxis.size) {
      for (final SuperButtonSize s in sizes) {
        columnHeaders.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Center(
              child: Text(s.name, style: const TextStyle(fontSize: 11)),
            ),
          ),
        );
      }
    } else {
      for (final SuperButtonTone t in tones) {
        columnHeaders.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Center(
              child: Text(t.name, style: const TextStyle(fontSize: 10)),
            ),
          ),
        );
      }
    }

    final List<TableRow> tableRows = <TableRow>[];
    for (final SuperButtonVariant v in _rows) {
      final List<Widget> cells = <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(v.name, style: const TextStyle(fontSize: 12)),
        ),
      ];

      if (_axis == _ColumnAxis.size) {
        for (final SuperButtonSize s in sizes) {
          cells.add(
            _matrixCell(variant: v, size: s, tone: SuperButtonTone.primary),
          );
        }
      } else {
        for (final SuperButtonTone t in tones) {
          cells.add(_matrixCell(variant: v, size: SuperButtonSize.sm, tone: t));
        }
      }
      tableRows.add(TableRow(children: cells));
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Combinations',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Rows = v1 minimum variants. Columns = your choice (size or tone). '
              'Icon row uses a star icon. Destructive uses danger tone in resolver.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: SegmentedButton<_ColumnAxis>(
              segments: const <ButtonSegment<_ColumnAxis>>[
                ButtonSegment<_ColumnAxis>(
                  value: _ColumnAxis.size,
                  label: Text('By size'),
                ),
                ButtonSegment<_ColumnAxis>(
                  value: _ColumnAxis.tone,
                  label: Text('By tone'),
                ),
              ],
              selected: <_ColumnAxis>{_axis},
              onSelectionChanged: (Set<_ColumnAxis> next) {
                setState(() {
                  _axis = next.first;
                });
              },
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          sliver: SliverToBoxAdapter(
            child: Builder(
              builder: (BuildContext context) {
                // Horizontal [SingleChildScrollView] max width is unbounded: [Table] + intrinsic
                // column widths throw (assert in RenderBox, "Unexpected null" cascade on web).
                final int colCount = columnHeaders.length;
                const double firstColW = 100;
                const double cellW = 78;
                final Map<int, TableColumnWidth> columnWidths = <int, TableColumnWidth>{
                  for (int i = 0; i < colCount; i++)
                    i: FixedColumnWidth(i == 0 ? firstColW : cellW),
                };
                final double tableWidth = firstColW + (colCount - 1) * cellW;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: tableWidth),
                    child: Table(
                      columnWidths: columnWidths,
                      defaultColumnWidth: const FixedColumnWidth(cellW),
                      border: TableBorder.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 0.5,
                      ),
                      children: <TableRow>[
                        TableRow(children: columnHeaders),
                        ...tableRows,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  static Widget _matrixCell({
    required SuperButtonVariant variant,
    required SuperButtonSize size,
    required SuperButtonTone tone,
  }) {
    final bool isIcon = variant == SuperButtonVariant.icon;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Center(
        child: SuperButton(
          onPressed: () {},
          label: isIcon
              ? null
              : Text(variant.name, style: const TextStyle(fontSize: 10)),
          leading: isIcon ? const Icon(Icons.star, size: 18) : null,
          style: SuperButtonStyle(
            variant: variant,
            size: size,
            tone: variant == SuperButtonVariant.destructive
                ? SuperButtonTone.danger
                : tone,
            shape: SuperButtonShape.rounded,
          ),
        ),
      ),
    );
  }
}

enum _ColumnAxis { size, tone }
