import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';
import 'screens/toko/toko_screen.dart';
import 'screens/pengetahuan/pengetahuan_screen.dart';
import 'screens/lokasi/lokasi_screen.dart';
import 'widgets/bottom_navbar.dart';
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
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TokoScreen(),
    PengetahuanScreen(),
    LokasiScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
