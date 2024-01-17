class TodoModel {
  var id;
  String? title;
  String? createdAt;
  var isComplete = 0;

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



}
