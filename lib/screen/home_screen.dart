import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todolist_flutter/db/database_sqlite.dart';
import 'package:todolist_flutter/widgets/todo_list_item.dart';

import '../providers/providers.dart';
import '../widgets/todo_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    var todos = ref.watch(getAllTodoProvider);
    var db = ref.watch(databaseProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: todos.when(
                data: (todos) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final todo = todos.elementAt(index);

                      return TodoListItem(
                        model: todo,
                        onTapCheckBox: () {
                          db.updateTodo(
                              todo.id, todo.title, todo.isComplete ? 0 : 1);
                          ref.refresh(getAllTodoProvider);
                        },
                        onTapDelete: () {
                          db.deleteTodo(todo.id);
                          ref.refresh(getAllTodoProvider);
                        },
                      );
                    },
                  );
                },
                error: (error, r) => Center(child: Text("Error")),
                loading: () {
                  Center(child: CircularProgressIndicator());
                })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return CustomdialogNewTodo(
                onPressedCreate: () {
                  final tile = ref.read(titleTodoProvider);
                  if (tile.isNotEmpty) {
                    db.insertTodo(tile, 0);
                    Get.back();
                  }
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
