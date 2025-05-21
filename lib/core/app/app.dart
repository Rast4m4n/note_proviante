import 'package:flutter/material.dart';
import 'package:note_proviante/core/di/i_di_scope.dart';
import 'package:note_proviante/feature/screens/list_notes/list_notes_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IDiScope>(
      builder: (context, diScope, child) {
        return MaterialApp(
          theme: diScope.theme.currentTheme(),
          home: const ListNotesScreen(),
        );
      },
    );
  }
}
