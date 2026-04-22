import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_button_package/super_button_package.dart';

void main() {
  testWidgets('filled danger uses scheme error/ onError', (WidgetTester tester) async {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,
    );
    late SuperButtonColorResolution r;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: scheme,
        ),
        home: Builder(
          builder: (BuildContext c) {
            r = SuperButtonColorResolver.resolve(
              c,
              const SuperButtonStyle(
                variant: SuperButtonVariant.filled,
                tone: SuperButtonTone.danger,
              ),
              const SuperButtonInteractionState(
                pressed: false,
                hovered: false,
                focused: false,
                enabled: true,
                loading: false,
                selected: false,
              ),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(r.background, scheme.error);
    expect(r.foreground, scheme.onError);
  });
}
