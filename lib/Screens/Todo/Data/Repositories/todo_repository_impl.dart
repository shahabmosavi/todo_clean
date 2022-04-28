import 'package:todo_clean/Screens/Todo/Data/DataSources/todo_local_data_source.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

import 'package:todo_clean/Screens/Todo/Domain/Repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);
  @override
  Future<TodoEntity> addTodo(task) async {
    return await localDataSource.addTodo(task);
  }

  @override
  Future<List<TodoEntity>> loadTodos() async {
    return await localDataSource.loadTodos();
  }
}
