import 'package:note_proviante/core/storage/i_local_storage.dart';
import 'package:note_proviante/domain/note_model.dart';

class IsarStorage implements ILocalStorage {
  @override
  Future<void> init() async {}

  @override
  Future<void> write(NoteModel note) {
    // TODO: implement write
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> getTheme() {
    // TODO: implement getTheme
    throw UnimplementedError();
  }

  @override
  Future<void> saveTheme(bool isDark) async {}
}
