import 'package:note_proviante/data/repository/note_repository.dart';
import 'package:note_proviante/domain/note_model.dart';

class ListNotesVm {
  ListNotesVm({required INoteRepository noteRepository})
    : _noteRepository = noteRepository;

  final INoteRepository _noteRepository;

  Future<List<NoteModel>> getNotes() async {
    return await _noteRepository.getNotes();
  }

  Future<void> deleteNote(String id) async {
    await _noteRepository.deleteNote(id);
  }
}
