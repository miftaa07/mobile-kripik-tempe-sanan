import 'package:flutter/material.dart';

import '../../../core/di/app_dependencies.dart';
import '../../home/views/home_screen.dart';
import '../../lokasi/views/lokasi_screen.dart';
import '../../pengetahuan/views/pengetahuan_screen.dart';
import '../../toko/views/toko_screen.dart';
import '../viewmodels/main_view_model.dart';
import '../widgets/bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  final AppDependencies? dependencies;

  const MainScreen({super.key, this.dependencies});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainViewModel _viewModel = MainViewModel();

  AppDependencies get _dependencies =>
      widget.dependencies ?? AppDependencies.instance;

  List<Widget> get _screens => [
    HomeScreen(dependencies: _dependencies),
    TokoScreen(dependencies: _dependencies),
    PengetahuanScreen(
      onBack: _viewModel.goHome,
      onNavigateTab: _viewModel.selectTab,
      dependencies: _dependencies,
    ),
    LokasiScreen(
      onBack: _viewModel.goHome,
      dependencies: _dependencies,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _viewModel,
      builder: (context, _) => Scaffold(
        body: IndexedStack(
          index: _viewModel.currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavbar(
          currentIndex: _viewModel.currentIndex,
          onTap: _viewModel.selectTab,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
