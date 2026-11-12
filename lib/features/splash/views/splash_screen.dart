import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/di/app_dependencies.dart';
import '../../../core/theme/app_theme.dart';
import '../../navigation/views/main_screen.dart';
import '../viewmodels/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  final AppDependencies? dependencies;

  const SplashScreen({super.key, this.dependencies});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashViewModel _viewModel = const SplashViewModel();

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await _viewModel.waitForIntro();
    if (!mounted) return;

    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => MainScreen(
          dependencies: widget.dependencies ?? AppDependencies.instance,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppTheme.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/splash_background.png',
              fit: BoxFit.cover,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xD9FFFCF7),
                    Color(0xCCFFF9F0),
                    Color(0xE6FCF9F5),
                  ],
                  stops: [0, 0.54, 1],
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'KAMPUNG KERIPIK TEMPE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.textDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'SANAN MALANG',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontSize: 31,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.7,
                            height: 1.1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(width: 40, height: 2, color: AppTheme.primary),
                      const SizedBox(height: 17),
                      const Text(
                        '“Dari Tradisi Menjadi Kebanggaan Rasa”',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.textDark,
                          fontFamily: 'serif',
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
