import 'package:flutter/material.dart';
import 'package:toi_et_moi/theme/app_theme.dart';
import 'screens/home/home_page.dart';
import 'screens/settings/settings_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toi et Moi',
      theme: AppTheme.themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Toi & Moi'),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}