import 'package:dartz/dartz.dart';
import 'package:todo_clean/Core/Error/failures.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

import '../Repositories/todo_repository.dart';

class TodoUsecases {
  final TodoRepository repository;

  TodoUsecases(this.repository);
  Future<Either<Failure, TodoEntity>> addTodo(task) {
    return repository.addTodo(task);
  }

  Future<Either<Failure, List<TodoEntity>>> loadTodos() {
    return repository.loadTodos();
  }
}
