import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

import '../Repositories/todo_repository.dart';

class TodoUsecases {
  final TodoRepository repository;

  TodoUsecases(this.repository);
  Future<TodoEntity> addTodo(task) {
    return repository.addTodo(task);
  }

  Future<List<TodoEntity>> loadTodos() {
    return repository.loadTodos();
  }
}
