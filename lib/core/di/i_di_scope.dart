import 'package:flutter/material.dart';
import 'package:note_proviante/core/storage/i_local_storage.dart';
import 'package:note_proviante/data/repository/note_repository.dart';
import 'package:note_proviante/feature/themes/theme_switcher.dart';

/// Интерфейс для работы с DI
abstract class IDiScope with ChangeNotifier {
  /// Инициализация DI
  Future<void> init();

  /// Получение хранилища
  ILocalStorage get storage;

  /// Получение темы
  ThemeSwitcher get theme;

  /// Получение репозитория заметок
  INoteRepository get noteRepository;
}
