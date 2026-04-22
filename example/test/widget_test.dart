import 'package:flutter_test/flutter_test.dart';
import 'package:super_button_package_example/main.dart';

void main() {
  testWidgets('Showcase app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperButtonShowcaseApp());
    expect(find.text('super_button_package'), findsOneWidget);
  });
}
