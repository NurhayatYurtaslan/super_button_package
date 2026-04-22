import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_button_package/super_button_package.dart';

void main() {
  testWidgets('SuperButton shows label and blocks tap when disabled', (
    WidgetTester tester,
  ) async {
    int taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SuperButton(
            onPressed: () => taps++,
            label: const Text('Continue'),
            style: const SuperButtonStyle(variant: SuperButtonVariant.filled),
            enabled: false,
          ),
        ),
      ),
    );
    expect(find.text('Continue'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pump();
    expect(taps, 0);
  });

  testWidgets('loading state blocks onPressed', (WidgetTester tester) async {
    int taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SuperButton(
            onPressed: () => taps++,
            label: const Text('Load'),
            style: const SuperButtonStyle(variant: SuperButtonVariant.filled),
            loading: true,
          ),
        ),
      ),
    );
    await tester.tap(find.text('Load'));
    await tester.pump();
    expect(taps, 0);
  });
}
