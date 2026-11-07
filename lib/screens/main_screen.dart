import 'package:flutter/material.dart';

import 'home/home_screen.dart';
import 'lokasi/lokasi_screen.dart';
import 'pengetahuan/pengetahuan_screen.dart';
import 'toko/toko_screen.dart';
import '../widgets/bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> get _screens => [
    HomeScreen(),
    TokoScreen(),
    PengetahuanScreen(
      onBack: () {
        setState(() {
          _currentIndex = 0;
        });
      },
    ),
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
