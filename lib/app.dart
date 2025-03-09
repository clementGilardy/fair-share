import 'package:flutter/material.dart';
import 'package:toi_et_moi/theme/app_theme.dart';
import 'screens/home/fair_share_home_page.dart';
import 'screens/settings/fair_share_settings_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fair Share',
      theme: AppTheme.themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const FairShareHomePage(title: 'Fair Share'),
        '/settings': (context) => const FairShareSettingsPage(),
      },
    );
  }
}