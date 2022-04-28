import 'package:dartz/dartz.dart';
import 'package:todo_clean/Core/Error/failures.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Either<Failure, TodoEntity>> addTodo(task);
  Future<Either<Failure, List<TodoEntity>>> loadTodos();
}
