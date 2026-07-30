import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _notificationsEnabled = true;
  bool _darkMode = true;
  int _selectedNavIndex = 0;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get darkMode => _darkMode;
  int get selectedNavIndex => _selectedNavIndex;

  void setNavIndex(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }
}
