// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';
import 'package:todo_clean/Screens/Todo/Domain/Usecases/todo_usecases.dart';

class TodoGetx {
  final TodoUsecases usecases;
  final Rx<TodoGetxStates> _state = TodoGetxStates.empty.obs;
  final RxList<TodoEntity> _todos = <TodoEntity>[].obs;
  TodoGetxStates get state => _state.value;
  List<TodoEntity> get todos => _todos.value;

  TodoGetx(this.usecases);
  Future<void> loadTodos() async {
    _state.value = TodoGetxStates.loading;
    await Future.delayed(const Duration(seconds: 1));
    final todos = await usecases.loadTodos();
    _todos.value = todos;
    _state.value = TodoGetxStates.empty;
  }

  Future<void> updateTodo(id, task) async {
    throw UnimplementedError();
  }

  Future<bool> toggleTodo(id) async {
    return await usecases.toggleTodo(id);
  }

  Future<void> addTodo(task) async {
    _state.value = TodoGetxStates.loading;
    await Future.delayed(const Duration(seconds: 1));
    final newTodo = await usecases.addTodo(task);
    _todos.value.add(newTodo);
    _state.value = TodoGetxStates.empty;
  }

  Future<void> deleteTodo(id, index) {
    //-1 is only for testing
    if (index != -1) _todos.value.removeAt(index);
    return usecases.deleteTodo(id);
  }
}

enum TodoGetxStates {
  empty,
  loading,
}
