import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/note_model.dart';
import 'package:getxtutorial6sqlitetodo/app/modules/notes/note_controller.dart';

class NoteEditPage extends GetView<NoteController> {
  final Note? note;

  const NoteEditPage({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: note?.title ?? '',
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              onChanged: (value) => note?.title = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: note?.content ?? '',
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              onChanged: (value) => note?.content = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (note != null) {
                  controller.updateNote(note!);
                } else {
                  controller.addNote(note!);
                }
              },
              child: Text(note == null ? 'Add Note' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
