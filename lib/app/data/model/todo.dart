class Todo {
  final int id;
  final String title;
  final String content;

  Todo({
    required this.id,
    required this.title,
    required this.content,
  });


  factory Todo.fromSqfliteDatabase(Map<String, dynamic> map) => Todo(
    id: map['id']?.toInt() ?? 0,
    title: map['title']?? '',
    content: map['content']?? '',
  );
}