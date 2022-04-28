import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Screens/Todo/Data/Models/todo_model.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';
import 'package:todo_clean/Screens/Todo/Domain/Repositories/todo_repository.dart';
import 'package:todo_clean/Screens/Todo/Domain/Usecases/todo_usecases.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late MockTodoRepository mockTodoRepository;
  late TodoUsecases usecases;
  const tId = 1, tTask = "test task", tChecked = false;
  const tTodoModel = TodoModel(id: tId, task: tTask, checked: tChecked);
  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecases = TodoUsecases(mockTodoRepository);
  });
  test("should call addTodo with proper data from the repository", () async {
    // arrange
    when(() => mockTodoRepository.addTodo(any()))
        .thenAnswer((_) async => const Right(tTodoModel));
    //act
    final result = await usecases.addTodo(tTask);
    //assert
    expect(result, const Right(tTodoModel));
    verify(() => mockTodoRepository.addTodo(tTask));
    verifyNoMoreInteractions(mockTodoRepository);
  });
  test("should call loadTodos with proper data from the repository", () async {
    // arrange
    when(() => mockTodoRepository.loadTodos())
        .thenAnswer((_) async => const Right(<TodoEntity>[tTodoModel]));
    //act
    final result = await usecases.loadTodos();
    //assert
    expect(result, const Right(<TodoEntity>[tTodoModel]));
    verify(() => mockTodoRepository.loadTodos());
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
