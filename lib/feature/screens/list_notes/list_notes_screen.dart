import 'package:flutter/material.dart';
import 'package:note_proviante/core/di/i_di_scope.dart';
import 'package:note_proviante/feature/screens/create_note/create_note_screen.dart';
import 'package:note_proviante/feature/themes/theme_switcher.dart';
import 'package:provider/provider.dart';

class ListNotesScreen extends StatelessWidget {
  const ListNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список заметок'),
        actions: [
          IconButton(
            onPressed:
                () => context.read<IDiScope>().theme.switchTheme(context),
            icon:
                ThemeSwitcher.isDark
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemBuilder: (context, index) {
          return ListTile(title: Text('Заметка $index'));
        },
      ),
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
