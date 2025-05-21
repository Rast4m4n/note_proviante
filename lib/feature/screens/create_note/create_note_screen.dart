import 'package:flutter/material.dart';
import 'package:note_proviante/core/di/i_di_scope.dart';
import 'package:note_proviante/domain/note_model.dart';
import 'package:note_proviante/feature/screens/create_note/create_note_vm.dart';
import 'package:provider/provider.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key, this.note});
  final NoteModel? note;

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  late final CreateNoteVm vm;
  @override
  void initState() {
    super.initState();
    vm = CreateNoteVm(
      noteRepository: context.read<IDiScope>().noteRepository,
      note: widget.note,
    );
    if (widget.note != null) {
      vm.titleController.text = widget.note!.title;
      vm.contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    super.dispose();
    vm.titleController.dispose();
    vm.contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создание заметки')),
      body: TextFieldContents(vm: vm),
      floatingActionButton: FloatingActionButton(
        onPressed: () => vm.saveAndBackToListNote(context),
        child: const Icon(Icons.save),
      ),
    );
  }
}

class TextFieldContents extends StatelessWidget {
  const TextFieldContents({super.key, required this.vm});
  final CreateNoteVm vm;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 8,
        children: [
          Form(
            key: vm.formKey,
            child: TextFormField(
              validator: vm.validateTitle,
              controller: vm.titleController,
              decoration: InputDecoration(
                hintText: 'Заголовок',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextField(
            controller: vm.contentController,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Текст заметки',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
