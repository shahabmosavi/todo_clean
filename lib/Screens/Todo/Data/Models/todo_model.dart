import 'dart:convert';

import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel(
      {required int id, required String task, required bool checked})
      : super(id: id, task: task, checked: checked);

  factory TodoModel.fromJson(String jsonData) {
    Map<String, dynamic> decoded = json.decode(jsonData);
    return TodoModel(
        id: decoded['id']!,
        task: decoded['task']!,
        checked: decoded['checked']!);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, "task": task, "checked": checked};
  }
}
