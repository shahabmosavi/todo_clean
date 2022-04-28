import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

import '../Repositories/todo_repository.dart';

class TodoUsecases {
  final TodoRepository repository;

  TodoUsecases(this.repository);
  Future<TodoEntity> addTodo(task) {
    return repository.addTodo(task);
  }

  Future<Success> deleteTodo(task) {
    return repository.deleteTodo(task);
  }

  Future<Success> updateTodo(id, task) {
    return repository.updateTodo(id, task);
  }

  Future<bool> toggleTodo(id) {
    return repository.toggleTodo(id);
  }

  Future<List<TodoEntity>> loadTodos() {
    return repository.loadTodos();
  }
}
