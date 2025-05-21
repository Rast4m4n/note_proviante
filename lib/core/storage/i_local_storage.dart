import 'package:note_proviante/domain/note_model.dart';

abstract class ILocalStorage {
  Future<void> init();
  Future<void> write(NoteModel note);
  Future<List<NoteModel>> get();
  Future<void> delete(int id);
  Future<void> saveTheme(bool isDark);
  Future<bool> getTheme();
}
