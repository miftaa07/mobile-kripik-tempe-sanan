import 'package:flutter/material.dart';

import 'core/di/app_dependencies.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/views/splash_screen.dart';

void main() {
  runApp(const KampungSananApp());
}

class KampungSananApp extends StatelessWidget {
  final AppDependencies? dependencies;

  const KampungSananApp({super.key, this.dependencies});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kampung Keripik Tempe Sanan',
      theme: AppTheme.theme,
      home: SplashScreen(
        dependencies: dependencies ?? AppDependencies.instance,
      ),
    );
  }
}
