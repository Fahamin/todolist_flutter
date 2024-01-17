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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['isComplete'] = this.isComplete;
    return data;
  }

}
