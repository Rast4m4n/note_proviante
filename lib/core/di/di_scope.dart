import 'package:flutter/material.dart';
import 'package:note_proviante/core/di/i_di_scope.dart';
import 'package:note_proviante/core/storage/I_local_storage.dart';
import 'package:note_proviante/core/storage/shared_pref_storage.dart';
import 'package:note_proviante/feature/themes/theme_switcher.dart';

class DiScope with ChangeNotifier implements IDiScope {
  @override
  Future<void> init() async {
    await _storage.init();
    _theme.addListener(() {
      notifyListeners();
    });
    ThemeSwitcher.isDark = await _storage.getTheme();
  }

  @override
  ILocalStorage get storage => _storage;
  final _storage = SharedPrefStorage();

  @override
  ThemeSwitcher get theme => _theme;
  final _theme = ThemeSwitcher();
}
