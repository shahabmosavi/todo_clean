import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:todo_clean/Core/DataSource/core_local_data_source.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Screens/Todo/Data/Models/todo_model.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

abstract class TodoLocalDataSource {
  Future<TodoEntity> addTodo(task);
  Future<Success> deleteTodo(id);
  Future<bool> toggleTodo(id);
  Future<Success> updateTodo(id, task);
  Future<List<TodoEntity>> loadTodos();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final HiveInterface hive;
  final CoreLocalDataSource coreLocalDataSource;

  TodoLocalDataSourceImpl(this.hive, this.coreLocalDataSource);
  @override
  Future<TodoEntity> addTodo(task) async {
    final user = await coreLocalDataSource.getLogedInUser();
    final todosBox = await hive.openBox('todos-$user');
    final id = await todosBox.add(task);
    final todoModel = TodoModel(id: id, task: task, checked: false);
    await todosBox.put(id, json.encode(todoModel.toJson()));
    await todosBox.close();
    return todoModel;
  }

  @override
  Future<List<TodoEntity>> loadTodos() async {
    final user = await coreLocalDataSource.getLogedInUser();

    final todosBox = await hive.openBox('todos-$user');
    final List<TodoEntity> list = [];
    final jsonlist = todosBox.values.toList();
    for (final json in jsonlist) {
      list.add(TodoModel.fromJson(json));
    }
    await todosBox.close();
    return list;
  }

  @override
  Future<Success> deleteTodo(id) async {
    final user = await coreLocalDataSource.getLogedInUser();

    final todosBox = await hive.openBox('todos-$user');
    todosBox.delete(id);
    await todosBox.close();

    return const Success();
  }

  @override
  Future<Success> updateTodo(id, task) async {
    final user = await coreLocalDataSource.getLogedInUser();

    final todosBox = await hive.openBox('todos-$user');
    final todoModel = TodoModel.fromJson(await todosBox.get(id));
    await todosBox.put(
        id,
        json.encode(TodoModel(id: id, task: task, checked: todoModel.checked)
            .toJson()));
    await todosBox.close();
    return const Success();
  }

  @override
  Future<bool> toggleTodo(id) async {
    final user = await coreLocalDataSource.getLogedInUser();

    final todosBox = await hive.openBox('todos-$user');
    final todo = await todosBox.get(id);
    final todoModel = TodoModel.fromJson(todo);
    final todoModelReversed =
        TodoModel(id: id, task: todoModel.task, checked: !todoModel.checked);
    todosBox.put(id, json.encode(todoModelReversed.toJson()));
    await todosBox.close();
    return todoModelReversed.checked;
  }
}
