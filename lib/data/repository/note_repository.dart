import 'package:note_proviante/core/storage/i_local_storage.dart';
import 'package:note_proviante/domain/note_model.dart';

/// Интерфейс для работы с заметками
abstract class INoteRepository {
  /// Получение заметок
  Future<List<NoteModel>> getNotes();

  /// Сохранение заметки
  Future<void> saveNote(NoteModel note);

  /// Удаление заметки
  Future<void> deleteNote(String id);

  /// Изменение заметки
  Future<void> editNote(NoteModel note);
}

class NoteRepository implements INoteRepository {
  NoteRepository({required ILocalStorage localStorage})
    : _localStorage = localStorage;

  final ILocalStorage _localStorage;

  @override
  Future<List<NoteModel>> getNotes() async {
    final notes = await _localStorage.get();
    return notes;
  }

  @override
  Future<void> saveNote(NoteModel note) async {
    await _localStorage.write(note);
  }

  @override
  Future<void> deleteNote(String id) async {
    await _localStorage.delete(id);
  }

  @override
  Future<void> editNote(NoteModel note) async {
    await _localStorage.edit(note);
  }
}
