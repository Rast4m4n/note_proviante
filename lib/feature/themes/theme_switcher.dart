import 'package:flutter/material.dart';
import 'package:note_proviante/core/di/i_di_scope.dart';
import 'package:note_proviante/feature/themes/app_theme.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher with ChangeNotifier {
  static ThemeSwitcher? _singleton;
  static ThemeSwitcher get instance => _singleton!;
  ThemeSwitcher._internal();

  factory ThemeSwitcher() {
    _singleton ??= ThemeSwitcher._internal();
    return instance;
  }

  static bool isDark = false;

  ThemeData currentTheme() {
    return isDark ? AppTheme.dark : AppTheme.light;
  }

  void switchTheme(BuildContext context) {
    context
        .read<IDiScope>()
        .storage
        .saveTheme(isDark = !isDark)
        .then((_) => notifyListeners());
  }
}
