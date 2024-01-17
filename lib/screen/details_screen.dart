import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todolist_flutter/model/todo_model.dart';

import '../providers/providers.dart';
import '../widgets/custom_text_field.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  var _titleController = TextEditingController();
  var _createDateController = TextEditingController();
  late TodoModel model;

  @override
  void dispose() {
    _titleController.dispose();
    _createDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = Get.arguments;
    _titleController.text = model.title.toString();
    _createDateController.text = model.createdAt.toString();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
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
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _createDateController,
                ),
                TextField(
                  decoration: InputDecoration(),
                  maxLines: 4,
                  controller: _titleController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        fireDb.updateTodo(
                            model.id, _titleController.text, model.isComplete);
                        /*db.updateTodo(
                            model.id, _titleController.text, model.isComplete);*/
                        ref.refresh(firestoreProvider);
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Update"),
                      ),
                    ),
                    Gap(10.w),
                    ElevatedButton(
                      onPressed: () {
                       // db.deleteTodo(model.id);
                        fireDb.deletTodo(model.id);
                        ref.refresh(firestoreProvider);

                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Delete"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
