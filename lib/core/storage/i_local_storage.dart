import 'package:note_proviante/domain/note_model.dart';

/// Интерфейс для работы с локальным хранилищем
abstract class ILocalStorage {
  Future<void> init();
  Future<void> write(NoteModel note);
  Future<void> edit(NoteModel note);
  Future<List<NoteModel>> get();
  Future<void> delete(String id);
  Future<void> saveTheme(bool isDark);
  Future<bool> getTheme();
}
