import 'dart:convert';

import 'package:note_proviante/core/storage/i_local_storage.dart';
import 'package:note_proviante/domain/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class _StorageKeys {
  static const String notes = 'notes';
  static const String theme = 'theme';
}

class SharedPrefStorage implements ILocalStorage {
  SharedPrefStorage._internal();

  @override
  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static SharedPrefStorage get _instance => SharedPrefStorage._internal();
  late final SharedPreferences _pref;

  factory SharedPrefStorage() {
    return _instance;
  }

  /// Запись данных в хранилище c обработкой ошибок
  Future<void> _setString(String key, String value, String errorMessage) async {
    try {
      await _pref.setString(key, value);
    } catch (e) {
      throw Exception("$errorMessage: $e");
    }
  }

  /// Запись заметки в хранилище
  @override
  Future<void> write(NoteModel note) async {
    final notes = await get();
    notes.add(note);
    final notesJson = notes.map((e) => e.toMap()).toList();
    _setString(
      _StorageKeys.notes,
      jsonEncode(notesJson),
      'Ошибка записи данных в хранилище',
    );
  }

  /// Изменение заметки в хранилище
  @override
  Future<void> edit(NoteModel note) async {
    final notes = await get();
    final index = notes.indexWhere((e) => e.id == note.id);
    if (index != -1) {
      notes[index] = notes[index].copyWith(
        title: note.title,
        content: note.content,
      );
    }
    final notesJson = notes.map((e) => e.toMap()).toList();
    _setString(
      _StorageKeys.notes,
      jsonEncode(notesJson),
      'Ошибка редактирования данных в хранилище',
    );
  }

  /// Получение заметок из хранилища
  @override
  Future<List<NoteModel>> get() async {
    try {
      final notes = _pref.getString(_StorageKeys.notes);
      if (notes == null || notes.isEmpty) return [];
      final notesList = jsonDecode(notes) as List<dynamic>;
      return notesList
          .map((e) => NoteModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Ошибка загрузки данных с хранилища: $e');
    }
  }

  /// Удаление заметки из хранилища
  @override
  Future<void> delete(String id) async {
    final notes = await get();
    notes.removeWhere((note) => note.id == id);
    final notesJson = notes.map((e) => e.toMap()).toList();
    _setString(
      _StorageKeys.notes,
      jsonEncode(notesJson),
      'Ошибка удаления данных из хранилища',
    );
  }

  /// Сохранение темы
  @override
  Future<void> saveTheme(bool isDark) async {
    await _pref.setBool(_StorageKeys.theme, isDark);
  }

  /// Получение темы
  @override
  Future<bool> getTheme() async {
    final isDark = _pref.getBool(_StorageKeys.theme) ?? false;
    return isDark;
  }
}
