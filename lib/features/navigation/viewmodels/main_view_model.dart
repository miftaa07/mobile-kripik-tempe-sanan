import 'package:flutter/foundation.dart';

class MainViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void selectTab(int index) {
    if (index < 0 || index > 3 || _currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }

  void goHome() => selectTab(0);
}
