import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/note_model.dart';
import 'package:getxtutorial6sqlitetodo/app/data/repository/note_repository.dart';
import 'package:getxtutorial6sqlitetodo/app/modules/notes/note_edit_page.dart';

class NoteController extends GetxController {
  final NoteRepository repository;
  NoteController(this.repository);

  RxList<Note> noteList = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAll();
  }

  void getAll() {
    repository.getAll().then((data) {
      noteList.assignAll(data);
    });
  }

  void addNote(Note note) {
    Get.to(() => const NoteEditPage());
  }

  void editNote(Note note) {
    Get.to(() => NoteEditPage(note: note));
  }

  void deleteNote(int noteId) {
    repository.delete(noteId).then((_) {
      getAll();
    });
  }

  void updateNote(Note note) {
    repository.update(note);
  }
}
