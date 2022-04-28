import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
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
  const tSuccess = Success();
  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecases = TodoUsecases(mockTodoRepository);
  });
  test("should call addTodo with proper data from the repository", () async {
    // arrange
    when(() => mockTodoRepository.addTodo(any()))
        .thenAnswer((_) async => tTodoModel);
    //act
    final result = await usecases.addTodo(tTask);
    //assert
    expect(result, tTodoModel);
    verify(() => mockTodoRepository.addTodo(tTask));
    verifyNoMoreInteractions(mockTodoRepository);
  });
  test("should call loadTodos with proper data from the repository", () async {
    // arrange
    when(() => mockTodoRepository.loadTodos())
        .thenAnswer((_) async => const <TodoEntity>[tTodoModel]);
    //act
    final result = await usecases.loadTodos();
    //assert
    expect(result, const <TodoEntity>[tTodoModel]);
    verify(() => mockTodoRepository.loadTodos());
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test("should call deleteTodo with proper data from the repository", () async {
    // arrange
    when(() => mockTodoRepository.deleteTodo(any()))
        .thenAnswer((_) async => tSuccess);
    //act
    final result = await usecases.deleteTodo(tId);
    //assert
    expect(result, tSuccess);
    verify(() => mockTodoRepository.deleteTodo(tId));
    verifyNoMoreInteractions(mockTodoRepository);
  });
  test("should call updateTodo with proper data from the repository", () async {
    // arrange
    when(() => mockTodoRepository.updateTodo(any(), any()))
        .thenAnswer((_) async => tSuccess);
    //act
    final result = await usecases.updateTodo(tId, tTask);
    //assert
    expect(result, tSuccess);
    verify(() => mockTodoRepository.updateTodo(tId, tTask));
    verifyNoMoreInteractions(mockTodoRepository);
  });
  test("should call toggleTodo with proper data from the repository", () async {
    // arrange
    when(() => mockTodoRepository.toggleTodo(any()))
        .thenAnswer((_) async => true);
    //act
    final result = await usecases.toggleTodo(tId);
    //assert
    expect(result, true);
    verify(() => mockTodoRepository.toggleTodo(tId));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
