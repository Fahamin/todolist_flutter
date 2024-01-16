import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist_flutter/model/todo_model.dart';

import 'custom_icon_button.dart';

class TodoListItem extends StatelessWidget {

  TodoModel model;
  final void Function() onTapCheckBox;
  final void Function() onTapDelete;


  TodoListItem(this.model, this.onTapCheckBox, this.onTapDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
            IconButton(
                icon: Icon(
                  (model.isComplete)
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  color: Colors.blue,
                  size: 23,
                ),
                color: Colors.blue.withOpacity(0.3),
                 onPressed: () { onTapCheckBox; },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        model.title,
                        style: GoogleFonts.roboto(
                          color: const Color(0xff6C6868),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: model.isComplete ? TextDecoration.lineThrough : null,
                          decorationThickness: model.isComplete ? 2.0 : null,
                          decorationColor: model.isComplete ? Colors.blue : null,
                        ),
                      ),
                      Text(
                        model.datetime,
                        style: GoogleFonts.roboto(
                          color: const Color(0xff6C6868),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          decorationThickness: model.isComplete ? 2.0 : null,
                          decorationColor: model.isComplete ? Colors.blue : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomIconButton(
                icon: const Icon(
                  Icons.disabled_by_default_rounded,
                  color: Colors.red,
                  size: 23,
                ),
                color: Colors.red.withOpacity(0.3),
                // onTap: onTapDelete,
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}