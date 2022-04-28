import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

abstract class TodoRepository {
  Future<TodoEntity> addTodo(task);
  Future<Success> deleteTodo(id);
  Future<Success> updateTodo(id, task);
  Future<bool> toggleTodo(id);
  Future<List<TodoEntity>> loadTodos();
}
