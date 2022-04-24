import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Core/Error/exceptions.dart';
import 'package:todo_clean/Core/Models/auth_model.dart';
import 'package:todo_clean/Screens/Register/Data/DataSources/register_local_data_source.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

void main() {
  late final HiveInterface mockHive;
  late final RegisterLocalDataSourceImpl dataSource;
  late final MockBox mockBox;

  setUp(() async {
    mockHive = MockHive();
    mockBox = MockBox();

    dataSource = RegisterLocalDataSourceImpl(mockHive);
  });

  group('register', () {
    const String tUsername = 'username', tPassword = 'password';
    late final String jsonData;
    setUp(() async {
      jsonData = json.encode(
          const AuthModel(password: tPassword, username: tUsername).toJson());
    });
    test(
        'should save new user and  in database and return success username is unique',
        () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.get(any())).thenReturn(null);
      // ignore: avoid_returning_null_for_void
      when(() => mockBox.close()).thenAnswer((_) async => null);
      // ignore: avoid_returning_null_for_void
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => null);
      //act
      final result = await dataSource.register(tUsername, tPassword);
      //assert
      verify(() => mockHive.openBox('users')).called(1);
      verify(() => mockBox.get(tUsername)).called(1);
      verify(() => mockBox.put(tUsername, jsonData)).called(1);
      verify(() => mockBox.close()).called(1);
      expect(result, const Success());
    });

    test('should throw RegisterException when username exist', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.get(any())).thenReturn(jsonData);
      // ignore: avoid_returning_null_for_void
      when(() => mockBox.close()).thenAnswer((_) async => null);
      // ignore: avoid_returning_null_for_void
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => null);
      //act
      final call = dataSource.register;
      //assert
      expect(() => call(tUsername, tPassword),
          throwsA(const TypeMatcher<RegisterException>()));
      verifyNever(() => mockBox.put(tUsername, jsonData));
    });
  });
}
