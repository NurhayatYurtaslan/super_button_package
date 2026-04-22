import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_button_package_example/screens/combinations_screen.dart';

void main() {
  testWidgets('CombinationsScreen lays out without throwing', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CombinationsScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Combinations'), findsOneWidget);
  });
}
