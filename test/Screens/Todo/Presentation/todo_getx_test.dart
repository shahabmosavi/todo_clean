import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Screens/Todo/Data/Models/todo_model.dart';
import 'package:todo_clean/Screens/Todo/Domain/Usecases/todo_usecases.dart';
import 'package:todo_clean/Screens/Todo/Presentation/Getx/todo_getx.dart';

class MockTodoUsecases extends Mock implements TodoUsecases {}

void main() {
  late MockTodoUsecases mockTodoUsecases;
  late TodoGetx getx;

  const tId = 1, tTask = "test task", tChecked = false;
  const tTodoEntity = TodoModel(checked: tChecked, task: tTask, id: tId);

  setUp(() {
    mockTodoUsecases = MockTodoUsecases();
    getx = TodoGetx(mockTodoUsecases);
  });
  // ignore: non_constant_identifier_names

  group('addTodo', () {
    test('should fire states in order [empty,loading,empty]', () async {
      when(() => mockTodoUsecases.addTodo(any()))
          .thenAnswer((_) async => tTodoEntity);
      expect(getx.state, TodoGetxStates.empty);
      final call = getx.addTodo(tTask);
      expect(getx.state, TodoGetxStates.loading);
      await call;
      expect(getx.state, TodoGetxStates.empty);
    });
    test('should call addTodo in usecase if input is not empty', () async {
      //arrange
      when(() => mockTodoUsecases.addTodo(any()))
          .thenAnswer((_) async => tTodoEntity);
      //act
      await getx.addTodo(tTask);
      //assert
      verify(() => mockTodoUsecases.addTodo(tTask)).called(1);
      expect(getx.todos, [tTodoEntity]);
    });
  });
  group('loadTodos', () {
    test('should fire states in order [empty,loading,empty]', () async {
      when(() => mockTodoUsecases.loadTodos())
          .thenAnswer((_) async => [tTodoEntity]);
      expect(getx.state, TodoGetxStates.empty);
      final call = getx.loadTodos();
      expect(getx.state, TodoGetxStates.loading);
      await call;
      expect(getx.state, TodoGetxStates.empty);
    });
    test('should call addTodo in usecase if input is not empty', () async {
      //arrange
      when(() => mockTodoUsecases.loadTodos())
          .thenAnswer((_) async => [tTodoEntity]);
      //act
      await getx.loadTodos();
      //assert
      verify(() => mockTodoUsecases.loadTodos()).called(1);
      expect(getx.todos, [tTodoEntity]);
    });
  });
  group('updateTodo', () {
    test('should call updateTodo in usecase', () async {
      //arrange
      when(() => mockTodoUsecases.updateTodo(any(), any()))
          .thenAnswer((_) async => const Success());
      //act
      await getx.updateTodo(tId, tTask);
      //assert
      verify(() => mockTodoUsecases.updateTodo(tId, tTask)).called(1);
      expect(getx.todos, [tTodoEntity]);
    });
  });
  group('deleteTodo', () {
    test('should call deleteTodo in usecase', () async {
      //arrange
      when(() => mockTodoUsecases.deleteTodo(any()))
          .thenAnswer((_) async => const Success());
      //act
      //-1 is only for testing
      await getx.deleteTodo(tId, -1);
      //assert
      verify(() => mockTodoUsecases.deleteTodo(tId)).called(1);
    });
  });
  group('toggleTodo', () {
    test('should call toggleTodo in usecase', () async {
      //arrange
      when(() => mockTodoUsecases.toggleTodo(
            any(),
          )).thenAnswer((_) async => true);
      //act
      await getx.toggleTodo(tId);
      //assert
      verify(() => mockTodoUsecases.toggleTodo(tId)).called(1);
    });
  });
}
