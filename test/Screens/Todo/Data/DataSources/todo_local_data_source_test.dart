// ignore_for_file: avoid_returning_null_for_void

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Screens/Todo/Data/DataSources/todo_local_data_source.dart';
import 'package:todo_clean/Screens/Todo/Data/Models/todo_model.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

void main() {
  late final HiveInterface mockHive;
  late final TodoLocalDataSourceImpl dataSource;
  late final MockBox mockBox;
  late final String jsonData;
  const tId = 1, tTask = "test task", tChecked = false;
  const tTodoModel = TodoModel(id: tId, task: tTask, checked: tChecked);
  setUp(() async {
    mockHive = MockHive();
    mockBox = MockBox();
    dataSource = TodoLocalDataSourceImpl(mockHive);

    jsonData = json.encode(tTodoModel.toJson());
  });

  group('addTodo', () {
    test('should add todo to database and return TodoEntity', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.add(any())).thenAnswer((_) async => tId);
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => null);
      when(() => mockBox.close()).thenAnswer((_) async => null);
      //act
      final result = await dataSource.addTodo(tTask);
      //assert
      expect(result, tTodoModel);
      verify(() => mockHive.openBox('todos')).called(1);
      verify(() => mockBox.add(tTask)).called(1);
      verify(() => mockBox.put(tId, jsonData)).called(1);
      verify(() => mockBox.close()).called(1);
    });
  });
  group('loadTodos', () {
    test('should return all todos in database', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.values).thenAnswer((_) => <TodoEntity>[]);
      // ignore: avoid_returning_null_for_void
      when(() => mockBox.close()).thenAnswer((_) async => null);
      //act
      final result = await dataSource.loadTodos();
      //assert
      expect(result, <TodoEntity>[]);
      verify(() => mockHive.openBox('todos')).called(1);
      verify(() => mockBox.values).called(1);
      verify(() => mockBox.close()).called(1);
    });
  });
  group('deleteTodo', () {
    test('should delete todo', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.delete(any())).thenAnswer((_) async => null);
      when(() => mockBox.close()).thenAnswer((_) async => null);
      //act
      final result = await dataSource.deleteTodo(tId);
      //assert
      expect(result, const Success());
      verify(() => mockHive.openBox('todos')).called(1);
      verify(() => mockBox.delete(tId)).called(1);
      verify(() => mockBox.close()).called(1);
    });
  });
  group('deleteTodo', () {
    test('should delete todo', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.delete(any())).thenAnswer((_) async => null);
      when(() => mockBox.close()).thenAnswer((_) async => null);
      //act
      final result = await dataSource.deleteTodo(tId);
      //assert
      expect(result, const Success());
      verify(() => mockHive.openBox('todos')).called(1);
      verify(() => mockBox.delete(tId)).called(1);
      verify(() => mockBox.close()).called(1);
    });
  });

  group('updateTodo', () {
    test('should update todo', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.get(any())).thenAnswer((_) async => jsonData);

      when(() => mockBox.put(any(), any())).thenAnswer((_) async => null);
      when(() => mockBox.close()).thenAnswer((_) async => null);
      //act
      final result = await dataSource.updateTodo(tId, tTask);
      //assert
      expect(result, const Success());
      verify(() => mockHive.openBox('todos')).called(1);
      verify(() => mockBox.put(tId, jsonData)).called(1);
      verify(() => mockBox.close()).called(1);
    });
  });
  group('toggleTodo', () {
    const tTodoModelTrue = TodoModel(id: tId, task: tTask, checked: true);

    final jsonDataTrue = json.encode(tTodoModelTrue.toJson());
    test('should return false when todo is true', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.get(any())).thenAnswer((_) async => jsonDataTrue);
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => null);
      when(() => mockBox.close()).thenAnswer((_) async => null);
      //act
      final result = await dataSource.toggleTodo(tId);
      //assert
      expect(result, false);
      verify(() => mockHive.openBox('todos')).called(1);
      verify(() => mockBox.put(tId, jsonData)).called(1);
      verify(() => mockBox.close()).called(1);
    });
    test('should return true when todo is false', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.get(any())).thenAnswer((_) async => jsonData);
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => null);
      when(() => mockBox.close()).thenAnswer((_) async => null);
      //act
      final result = await dataSource.toggleTodo(tId);
      //assert
      expect(result, true);
      verify(() => mockHive.openBox('todos')).called(1);
      verify(() => mockBox.put(tId, jsonDataTrue)).called(1);
      verify(() => mockBox.close()).called(1);
    });
  });
}
