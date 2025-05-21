import 'dart:convert';

import 'package:note_proviante/core/storage/I_local_storage.dart';
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

  Future<void> _setString(String key, String value, String errorMessage) async {
    try {
      await _pref.setString(key, value);
    } catch (e) {
      throw Exception("$errorMessage: $e");
    }
  }

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

  @override
  Future<List<NoteModel>> get() async {
    try {
      final notes = _pref.getString(_StorageKeys.notes);
      if (notes == null || notes.isEmpty) return [];
      return jsonDecode(notes).map((e) => NoteModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception('Ошибка загрузки данных с хранилища: $e');
    }
  }

  @override
  Future<void> delete(int id) async {
    final notes = await get();
    notes.removeWhere((note) => note.id == id.toString());
    final notesJson = notes.map((e) => e.toMap()).toList();
    _setString(
      _StorageKeys.notes,
      jsonEncode(notesJson),
      'Ошибка удаления данных из хранилища',
    );
  }

  @override
  Future<void> saveTheme(bool isDark) async {
    await _pref.setBool(_StorageKeys.theme, isDark);
  }

  @override
  Future<bool> getTheme() async {
    final isDark = _pref.getBool(_StorageKeys.theme) ?? false;
    return isDark;
  }
}
