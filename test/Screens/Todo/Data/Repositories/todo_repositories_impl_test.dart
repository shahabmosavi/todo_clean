import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Screens/Todo/Data/DataSources/todo_local_data_source.dart';
import 'package:todo_clean/Screens/Todo/Data/Models/todo_model.dart';
import 'package:todo_clean/Screens/Todo/Data/Repositories/todo_repository_impl.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

class MockTodoLocalDataSource extends Mock implements TodoLocalDataSource {}

void main() {
  late MockTodoLocalDataSource mockLocalDataSource;
  late TodoRepositoryImpl repositoryImpl;

  setUp(() {
    mockLocalDataSource = MockTodoLocalDataSource();
    repositoryImpl = TodoRepositoryImpl(mockLocalDataSource);
  });
  const tId = 1, tTask = "test task", tChecked = false;
  const tTodoModel = TodoModel(id: tId, task: tTask, checked: tChecked);
  group('addTodo', () {
    test('should return TodoEntity when Todo added successfully', () async {
      //arrange
      when(() => mockLocalDataSource.addTodo(any()))
          .thenAnswer((_) async => tTodoModel);

      //act
      final result = await repositoryImpl.addTodo(tTask);

      //assert
      expect(result, tTodoModel);
      verify(() => mockLocalDataSource.addTodo(tTask)).called(1);
    });
  });
  group('loadTodos', () {
    test('should return list of TodoEntity  when Todo added successfully',
        () async {
      //arrange
      when(() => mockLocalDataSource.loadTodos())
          .thenAnswer((_) async => <TodoEntity>[tTodoModel]);

      //act
      final result = await repositoryImpl.loadTodos();

      //assert
      expect(result, <TodoEntity>[tTodoModel]);
      verify(() => mockLocalDataSource.loadTodos()).called(1);
    });
  });
}
