import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todolist_flutter/db/database_sqlite.dart';
import 'package:todolist_flutter/model/todo_model.dart';
import 'package:todolist_flutter/routes/routes.dart';
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
    var todos = ref.watch(firestoreProvider);
    //var todos = ref.watch(getAllTodoProvider);
    var db = ref.watch(databaseProvider);
    var fireDb = ref.watch(fireProvider);

    return Flexible(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "TodoList"
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: 1.sw,
          height: 1.sh,
          margin: EdgeInsets.only(top: 30.h),
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: todos.when(data: (todos) {
              if (todos.isNotEmpty) {
                return Center(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final model = todos.elementAt(index);
                      //for sqlite
                      /*var model = TodoModel(todo["id"], todo["title"],
                          todo["createdAt"], todo["isComplete"]);*/
                      return TodoListItem(
                        model: model,
                        onTapCheckBox: () async {
                          fireDb.updateTodo(model.id, model.title!,
                              model.isComplete == 1 ? 0 : 1);

                          /* db.updateTodo(model.id, model.title!,
                              model.isComplete == 1 ? 0 : 1);*/
                          await ref.refresh(firestoreProvider);
                        },
                        onTapDetails: () async {
                          Get.toNamed(Routes.details, arguments: model);
                        },
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text("Todo is Empty\n Add Tap + Button"));
              }
            }, error: (error, r) {
              return Center(child: Text("Error"));
            }, loading: () {
              return Center(child: CircularProgressIndicator());
            })),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return CustomdialogNewTodo(
                  onPressedCreate: () async {
                    final tile = ref.read(titleTodoProvider);
                    if (tile.isNotEmpty) {
                      // await db.insertTodo(tile, 0);
                      //ref.refresh(getAllTodoProvider);

                      fireDb.addNewTodo(tile, 0);
                      ref.refresh(firestoreProvider);
                      Get.back();
                    }
                  },
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
