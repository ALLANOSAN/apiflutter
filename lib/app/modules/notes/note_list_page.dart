import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/note_model.dart';
import 'package:getxtutorial6sqlitetodo/app/modules/notes/note_controller.dart';

class NoteListPage extends GetView<NoteController> {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Obx(() {
        if (controller.noteList.isEmpty) {
          return const Center(
            child: Text('No Notes'),
          );
        } else {
          return ListView.builder(
            itemCount: controller.noteList.length,
            itemBuilder: (context, index) {
              Note note = controller.noteList[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                onTap: () => controller.editNote(note),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    controller.deleteNote(note.id!);
                  },
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Note newNote = Note(
            title: 'Seu título aqui',
            content: 'Seu conteúdo aqui',
            // initialize your note properties here...
          );
          controller.addNote(newNote);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
