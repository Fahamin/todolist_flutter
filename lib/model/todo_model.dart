class TodoModel {
  int id;
  String title;
  String datetime;
  bool isComplete = false;

  TodoModel(
    this.id,
    this.title,
    this.datetime,
    this.isComplete,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': datetime,
      'isComplete': isComplete ? 1 : 0,
    };
  }
}
