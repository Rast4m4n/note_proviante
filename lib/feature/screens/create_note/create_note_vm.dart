import 'package:flutter/material.dart';
import 'package:note_proviante/data/repository/note_repository.dart';
import 'package:note_proviante/domain/note_model.dart';
import 'package:note_proviante/feature/screens/list_notes/list_notes_screen.dart';
import 'package:uuid/uuid.dart';

class CreateNoteVm {
  CreateNoteVm({required INoteRepository noteRepository, NoteModel? note})
    : _noteRepository = noteRepository,
      _note = note;

  final NoteModel? _note;

  final INoteRepository _noteRepository;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? errorText;

  /// Проверка на валидность формы
  bool isValidForm() {
    return formKey.currentState!.validate();
  }

  /// Проверка на валидность заголовка
  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return errorText = 'Заголовок не может быть пустым';
    }
    return null;
  }

  /// Сохранение заметки и возвращение на экран списка заметок
  Future<void> saveAndBackToListNote(BuildContext context) async {
    if (!isValidForm()) return;
    final title = titleController.text;
    final content = contentController.text;
    if (_note != null) await _editExistingNote(title, content);
    if (_note == null) await _saveNote(title, content);
    if (context.mounted) navigateToNotes(context);
  }

  /// Создание новой заметки
  Future<void> _saveNote(String title, String content) async {
    await _noteRepository.saveNote(
      NoteModel(
        id: Uuid().v4(),
        title: title,
        content: content,
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Изменение существующей заметки
  Future<void> _editExistingNote(String title, String content) async {
    await _noteRepository.editNote(
      NoteModel(
        id: _note!.id,
        title: title,
        content: content,
        createdAt: DateTime.now(),
      ),
    );
  }

  void navigateToNotes(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ListNotesScreen()),
      (route) => false,
    );
  }
}
