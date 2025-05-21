import 'package:flutter/material.dart';
import 'package:note_proviante/core/storage/i_local_storage.dart';
import 'package:note_proviante/data/repository/note_repository.dart';
import 'package:note_proviante/feature/themes/theme_switcher.dart';

abstract class IDiScope with ChangeNotifier {
  Future<void> init();

  ILocalStorage get storage;

  ThemeSwitcher get theme;

  INoteRepository get noteRepository;
}
