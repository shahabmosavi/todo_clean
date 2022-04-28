import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

abstract class TodoLocalDataSource {
  Future<TodoEntity> addTodo(task);
  Future<List<TodoEntity>> loadTodos();
}

// class TodoLocalDataSourceImpl implements TodoLocalDataSource{}