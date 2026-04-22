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
  static const double _kRailBreakpoint = 900;
  static const List<Color> _seedOptions = <Color>[
    Colors.deepPurple,
    Colors.teal,
    Colors.orange,
    Colors.indigo,
  ];
  int _seedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    GalleryScreen(),
    CombinationsScreen(),
    EffectsPlaygroundScreen(),
    AccessibilityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final Color seed = _seedOptions[_seedIndex];
    return MaterialApp(
      title: 'SuperButton showcase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _mode,
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints c) {
          final bool useRail = c.maxWidth >= _kRailBreakpoint;
          return Scaffold(
            appBar: AppBar(
              title: const Text('super_button_package example'),
              actions: <Widget>[
                IconButton(
                  tooltip: 'Cycle seed color',
                  onPressed: () {
                    setState(() {
                      _seedIndex = (_seedIndex + 1) % _seedOptions.length;
                    });
                  },
                  icon: Icon(
                    Icons.palette_outlined,
                    color: _seedOptions[_seedIndex],
                  ),
                ),
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
            body: useRail
                ? Row(
                    children: <Widget>[
                      NavigationRail(
                        selectedIndex: _index,
                        onDestinationSelected: (int i) {
                          setState(() => _index = i);
                        },
                        labelType: NavigationRailLabelType.all,
                        destinations: const <NavigationRailDestination>[
                          NavigationRailDestination(
                            icon: Icon(Icons.grid_view_outlined),
                            selectedIcon: Icon(Icons.grid_view),
                            label: Text('Gallery'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.view_module_outlined),
                            selectedIcon: Icon(Icons.view_module),
                            label: Text('Comb.'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.tune_outlined),
                            selectedIcon: Icon(Icons.tune),
                            label: Text('Effects'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.accessibility_new_outlined),
                            selectedIcon: Icon(Icons.accessibility_new),
                            label: Text('A11y'),
                          ),
                        ],
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(child: SafeArea(child: _pages[_index])),
                    ],
                  )
                : SafeArea(child: _pages[_index]),
            bottomNavigationBar: useRail
                ? null
                : NavigationBar(
                    selectedIndex: _index,
                    onDestinationSelected: (int i) =>
                        setState(() => _index = i),
                    destinations: const <NavigationDestination>[
                      NavigationDestination(
                        icon: Icon(Icons.grid_view_outlined),
                        selectedIcon: Icon(Icons.grid_view),
                        label: 'Gallery',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.view_module_outlined),
                        selectedIcon: Icon(Icons.view_module),
                        label: 'Comb.',
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
                    ],
                  ),
          );
        },
      ),
    );
  }
}
