import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_flutter/db/database_sqlite.dart';
import 'package:todolist_flutter/model/todo_model.dart';

import '../db/database_firestore.dart';

final databaseProvider = StateProvider((ref) => SQLHelper());

final getAllTodoProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return await SQLHelper().getAllTodo();
});

final fireProvider = StateProvider((ref) => FireStoreDb());

final titleTodoProvider = StateProvider<String>((ref) {
  return '';
});

var themeProvider = StateProvider((ref) => true);

final firestoreProvider =
    FutureProvider.autoDispose<List<TodoModel>>((ref) async {
  QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('todo').get();
  List<TodoModel> dataList =
      snapshot.docs.map((doc) => TodoModel.fromMap(doc.data())).toList();

  return dataList;
});
