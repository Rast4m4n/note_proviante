import 'package:flutter/material.dart';
import 'package:note_proviante/core/storage/i_local_storage.dart';
import 'package:note_proviante/feature/themes/app_theme.dart';

class ThemeSwitcher with ChangeNotifier {
  static ThemeSwitcher? _singleton;
  static ThemeSwitcher get instance => _singleton!;
  final ILocalStorage _localStorage;

  ThemeSwitcher._internal({required ILocalStorage localStorage})
    : _localStorage = localStorage;

  factory ThemeSwitcher({required ILocalStorage localStorage}) {
    _singleton ??= ThemeSwitcher._internal(localStorage: localStorage);
    return instance;
  }

  static bool isDark = false;

  ThemeData currentTheme() {
    return isDark ? AppTheme.dark : AppTheme.light;
  }

  void switchTheme(BuildContext context) {
    _localStorage.saveTheme(isDark = !isDark).then((_) => notifyListeners());
  }
}
