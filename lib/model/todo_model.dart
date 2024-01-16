class TodoModel {
  int id;
  String title;
  String createdAt;
  bool isComplete = false;

  TodoModel(
    this.id,
    this.title,
    this.createdAt,
    this.isComplete,
  );

  factory TodoModel.fromMap(Map<String, dynamic> maps) {
    return TodoModel(
      maps['id'],
      maps['title'],
      maps['createdAt'],
      maps['isComplete'],
      // Initialize other fields from the map
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': createdAt,
      'isComplete': isComplete ? 1 : 0,
    };
  }
}
