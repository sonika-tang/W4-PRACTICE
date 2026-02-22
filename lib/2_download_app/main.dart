import 'package:flutter/material.dart';
import 'package:w4_practice/2_download_app/ui/screens/downloads/widgets/download_controler.dart';

import 'ui/providers/theme_color_provider.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'ui/screens/downloads/downloads_screen.dart';
import 'ui/theme/theme.dart';

final List<DownloadController> downloadControllers = [
  DownloadController(Ressource(name: 'image1.png', size: 120)),
  DownloadController(Ressource(name: 'image2.png', size: 500)),
  DownloadController(Ressource(name: 'image3.png', size: 12000)),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 1;

  final List<Widget> _pages = [DownloadsScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: ListenableBuilder(
        listenable: themeColorProvider,
        builder: (context, _) {
          final theme = themeColorProvider.current;
          return Scaffold(
            body: _pages[_currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              selectedItemColor: theme.color,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Downloads',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
