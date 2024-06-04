import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/database_helper.dart';
import '../models/task.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  final db = DatabaseHelper();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final data = await db.getTasks();
    setState(() {
      tasks = data;
    });
  }

  Future<void> _deleteTask(int id) async {
    await db.deleteTask(id);
    _loadTasks();
  }

  Future<void> _editTask(Task task) async {
    await Get.to(() => TaskFormScreen(task: task));
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            key: Key(task.id.toString()),
            background: Container(color: Colors.red),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirmação"),
                      content: const Text("Você realmente deseja excluir esta tarefa?"),
                      actions: <Widget>[
                        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("Cancelar")),
                        TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Excluir")),
                      ],
                    );
                  },
                );
              } else {
                _editTask(task);
                return false;
              }
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                _deleteTask(task.id);
              }
            },
            child: ListTile(
              title: Text(task.name),
              subtitle: Text(task.description),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: (bool? value) async {
                  task.isCompleted = value ?? false;
                  await db.updateTask(task);
                  _loadTasks();
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => const TaskFormScreen());
          _loadTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
