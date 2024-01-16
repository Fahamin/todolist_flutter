
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_flutter/db/database_sqlite.dart';
import 'package:todolist_flutter/model/todo_model.dart';

final databaseProvider = StateProvider((ref) => SQLHelper());

final getAllTodoProvider = FutureProvider<List<TodoModel>>((ref) async {
  return await SQLHelper().getAllTodo();
});


final titleTodoProvider = StateProvider<String>((ref) {
  return '';
});


var themeProvider = StateProvider((ref) => true);
