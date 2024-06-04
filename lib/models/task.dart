class Task {
  int? id;
  String title;
  String? description;
  String dueDate;
  int isCompleted;

  Task({
    this.id,
    required this.title,
    this.description,
    required this.dueDate,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'isCompleted': isCompleted,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'],
      isCompleted: map['isCompleted'],
    );
  }
}
