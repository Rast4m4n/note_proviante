import 'package:flutter/material.dart';
import 'package:note_proviante/core/di/i_di_scope.dart';
import 'package:note_proviante/feature/screens/create_note/create_note_screen.dart';
import 'package:note_proviante/feature/screens/list_notes/list_notes_vm.dart';
import 'package:note_proviante/feature/themes/theme_switcher.dart';
import 'package:provider/provider.dart';

class ListNotesScreen extends StatefulWidget {
  const ListNotesScreen({super.key});

  @override
  State<ListNotesScreen> createState() => _ListNotesScreenState();
}

class _ListNotesScreenState extends State<ListNotesScreen> {
  late final ListNotesVm vm;
  @override
  void initState() {
    super.initState();
    vm = ListNotesVm(noteRepository: context.read<IDiScope>().noteRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список заметок'),
        actions: [
          Consumer<IDiScope>(
            builder: (context, scope, child) {
              return IconButton(
                onPressed: () => scope.theme.switchTheme(context),
                icon:
                    ThemeSwitcher.isDark
                        ? const Icon(Icons.light_mode)
                        : const Icon(Icons.dark_mode),
              );
            },
          ),
        ],
      ),
      body: Provider(create: (context) => vm, child: const ListNotesWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNoteScreen()),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListNotesWidget extends StatelessWidget {
  const ListNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<ListNotesVm>().getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Ошибка загрузки заметок: ${snapshot.error}'),
          );
        }
        final notes = snapshot.data;
        return ListView.separated(
          itemCount: snapshot.data?.length ?? 0,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(notes?[index].id),
              onDismissed: (direction) {
                context.read<ListNotesVm>().deleteNote(notes![index].id);
              },
              background: ColoredBox(
                color: Colors.red,
                child: const Icon(Icons.delete),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  child: ListTile(
                    title: Text(notes?[index].title ?? ''),
                    subtitle: Text(notes?[index].content ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  CreateNoteScreen(note: notes?[index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
