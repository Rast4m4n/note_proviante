import 'package:flutter/material.dart';
import 'package:note_proviante/core/storage/I_local_storage.dart';
import 'package:note_proviante/feature/themes/theme_switcher.dart';

abstract class IDiScope with ChangeNotifier {
  Future<void> init();

  ILocalStorage get storage;

  ThemeSwitcher get theme;
}
