import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_clean/Screens/Todo/Presentation/Getx/todo_getx.dart';
import 'package:todo_clean/Screens/Todo/Presentation/Widgets/todo_controller.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TodoGetx controller = Get.find();

  @override
  void initState() {
    controller.loadTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Obx(() {
          if (controller.state == TodoGetxStates.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                  flex: 10,
                  child: Obx(
                    () {
                      return ListView.builder(
                        itemCount: controller.todos.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Dismissible(
                            onDismissed: (d) {
                              controller.deleteTodo(controller.todos[i].id, i);
                            },
                            key: Key(i.toString()),
                            child: TodoWidget(
                                value: controller.todos[i].checked,
                                controller: controller,
                                id: controller.todos[i].id,
                                task: controller.todos[i].task),
                          );
                        },
                      );
                    },
                  )),
              const SizedBox(height: 10),
              const TodoController(),
            ],
          );
        }));
  }
}

class TodoWidget extends StatefulWidget {
  const TodoWidget({
    Key? key,
    required this.controller,
    required this.task,
    required this.id,
    required this.value,
  }) : super(key: key);

  final TodoGetx controller;
  final String task;
  final int id;
  final bool value;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late final RxBool value;
  @override
  void initState() {
    value = widget.value.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => CheckboxListTile(
          value: value.value,
          onChanged: (v) async {
            value.value = await widget.controller.toggleTodo(widget.id);
          },
          title: Text(widget.task),
        ));
  }
}
