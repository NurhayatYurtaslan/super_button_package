import 'package:flutter/material.dart';

import 'screens/accessibility_screen.dart';
import 'screens/combinations_screen.dart';
import 'screens/effects_playground_screen.dart';
import 'screens/gallery_screen.dart';

void main() {
  runApp(const SuperButtonShowcaseApp());
}

class SuperButtonShowcaseApp extends StatefulWidget {
  const SuperButtonShowcaseApp({super.key});

  @override
  State<SuperButtonShowcaseApp> createState() => _SuperButtonShowcaseAppState();
}

class _SuperButtonShowcaseAppState extends State<SuperButtonShowcaseApp> {
  int _index = 0;
  ThemeMode _mode = ThemeMode.system;

  static const List<Widget> _pages = <Widget>[
    GalleryScreen(),
    CombinationsScreen(),
    EffectsPlaygroundScreen(),
    AccessibilityScreen(),
  ];

  static const List<NavigationDestination> _destinations =
      <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.grid_view_outlined),
      selectedIcon: Icon(Icons.grid_view),
      label: 'Gallery',
    ),
    NavigationDestination(
      icon: Icon(Icons.view_module_outlined),
      selectedIcon: Icon(Icons.view_module),
      label: 'Combinations',
    ),
    NavigationDestination(
      icon: Icon(Icons.tune_outlined),
      selectedIcon: Icon(Icons.tune),
      label: 'Effects',
    ),
    NavigationDestination(
      icon: Icon(Icons.accessibility_new_outlined),
      selectedIcon: Icon(Icons.accessibility_new),
      label: 'A11y',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperButton showcase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _mode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('super_button_package'),
          actions: <Widget>[
            IconButton(
              tooltip: 'Toggle theme',
              onPressed: () {
                setState(() {
                  _mode = switch (_mode) {
                    ThemeMode.system => ThemeMode.light,
                    ThemeMode.light => ThemeMode.dark,
                    ThemeMode.dark => ThemeMode.system,
                  };
                });
              },
              icon: Icon(
                _mode == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode_outlined,
              ),
            ),
          ],
        ),
        body: SafeArea(child: _pages[_index]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (int i) => setState(() => _index = i),
          destinations: _destinations,
        ),
      ),
    );
  }
}