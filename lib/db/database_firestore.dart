import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_flutter/model/todo_model.dart';

class FireStoreDb {
  final _firestore = FirebaseFirestore.instance;
  CollectionReference _todo = FirebaseFirestore.instance.collection('todo');

  Stream get alltodo => _firestore.collection("todo").snapshots();

  Future<bool> addNewTodo(var title, var isComplete) async {
    final docRef = _firestore.collection('todo').doc();
    try {
      TodoModel model =
          TodoModel(docRef.id, title, DateTime.now().toString(), isComplete);

      await docRef.set(model.toJson()).then(
          (value) => debugPrint(" successfully!"),
          onError: (e) => debugPrint("Error : $e"));
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> deletTodo(String TodoId) async {
    _todo = _firestore.collection('todo');
    try {
      await _todo.doc(TodoId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> updateTodo(String id, String title, int fav) async {
    _todo = _firestore.collection('todo');
    try {
      await _todo.doc(id).update({
        'title': title,
        'createdAt': DateTime.now().toString(),
        'isComplete':fav
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

   getTodoList() {
    CollectionReference users = FirebaseFirestore.instance.collection('todo');

    return users.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print('${doc.id} => ${doc.data()}');
      });
    }).catchError((error) => print("Failed to fetch : $error"));
  }
}
