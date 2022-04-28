import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Getx/todo_getx.dart';

class TodoController extends StatefulWidget {
  const TodoController({
    Key? key,
  }) : super(key: key);

  @override
  State<TodoController> createState() => _TodoControllerState();
}

class _TodoControllerState extends State<TodoController> {
  final TextEditingController textEditingController = TextEditingController();
  final TodoGetx controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        Expanded(
            flex: 4,
            child: TextField(
              controller: textEditingController,
            )),
        const SizedBox(width: 10),
        Expanded(
            child: FloatingActionButton(
          onPressed: () {
            if (textEditingController.text.isNotEmpty) {
              controller.addTodo(textEditingController.text);
            }
          },
          child: const Center(
            child: Text(
              "+",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, height: 1),
            ),
          ),
        )),
      ],
    ));
  }
}
