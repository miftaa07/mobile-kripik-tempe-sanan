import 'package:flutter/material.dart';

import 'screens/splash/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const KampungSananApp());
}

class KampungSananApp extends StatelessWidget {
  const KampungSananApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kampung Keripik Tempe Sanan',
      theme: AppTheme.theme,
      home: const SplashScreen(),
    );
  }
}
