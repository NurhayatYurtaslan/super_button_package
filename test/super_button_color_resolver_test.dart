import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_button_package/super_button_package.dart';

void main() {
  testWidgets('filled danger uses scheme error/ onError',
      (WidgetTester tester) async {
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

  testWidgets('selected filled primary uses secondaryContainer pair',
      (WidgetTester tester) async {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    );
    late SuperButtonColorResolution r;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: scheme),
        home: Builder(
          builder: (BuildContext c) {
            r = SuperButtonColorResolver.resolve(
              c,
              const SuperButtonStyle(
                variant: SuperButtonVariant.filled,
                tone: SuperButtonTone.primary,
              ),
              const SuperButtonInteractionState(
                pressed: false,
                hovered: false,
                focused: false,
                enabled: true,
                loading: false,
                selected: true,
              ),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(r.background, scheme.secondaryContainer);
    expect(r.foreground, scheme.onSecondaryContainer);
  });

  testWidgets('outlined primary uses primary ink on page surface, not onPrimary',
      (WidgetTester tester) async {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: Colors.deepOrange,
      brightness: Brightness.light,
    );
    late SuperButtonColorResolution r;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: scheme),
        home: Builder(
          builder: (BuildContext c) {
            r = SuperButtonColorResolver.resolve(
              c,
              const SuperButtonStyle(
                variant: SuperButtonVariant.outlined,
                tone: SuperButtonTone.primary,
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
    expect(r.foreground, scheme.primary);
    expect(r.foreground, isNot(scheme.onPrimary));
  });

  testWidgets('outlined neutral resolves outline and foreground',
      (WidgetTester tester) async {
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.teal);
    late SuperButtonColorResolution r;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: scheme),
        home: Builder(
          builder: (BuildContext c) {
            r = SuperButtonColorResolver.resolve(
              c,
              const SuperButtonStyle(
                variant: SuperButtonVariant.outlined,
                tone: SuperButtonTone.neutral,
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
    expect(r.outline, scheme.outline);
    expect(r.foreground, scheme.onSurface);
  });
}
