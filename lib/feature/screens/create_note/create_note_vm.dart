import 'package:flutter/material.dart';
import 'package:note_proviante/data/repository/note_repository.dart';
import 'package:note_proviante/domain/note_model.dart';
import 'package:note_proviante/feature/screens/list_notes/list_notes_screen.dart';
import 'package:uuid/uuid.dart';

class CreateNoteVm {
  CreateNoteVm({required INoteRepository noteRepository})
    : _noteRepository = noteRepository;

  final INoteRepository _noteRepository;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Future<void> saveNote(BuildContext context) async {
    final title = titleController.text;
    final content = contentController.text;
    await _noteRepository.saveNote(
      NoteModel(
        id: Uuid().v4(),
        title: title,
        content: content,
        createdAt: DateTime.now(),
      ),
    );
    if (context.mounted) navigateToNotes(context);
  }

  void navigateToNotes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListNotesScreen()),
    );
  }
}
