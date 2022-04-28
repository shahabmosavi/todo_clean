import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Core/Error/exceptions.dart';
import 'package:todo_clean/Core/Models/auth_model.dart';
import 'package:todo_clean/Screens/Login/Data/DataSources/login_local_data_source.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

void main() {
  late final HiveInterface mockHive;
  late final LoginLocalDataSourceImpl dataSource;
  late final MockBox mockBox;

  setUp(() async {
    mockHive = MockHive();
    mockBox = MockBox();
    dataSource = LoginLocalDataSourceImpl(mockHive);
  });

  group('login', () {
    const String tUsername = 'username', tPassword = 'password';
    late final String jsonData;
    late final Map<String, dynamic> jsonMap;
    setUp(() async {
      jsonData = json.encode(
          const AuthModel(password: tPassword, username: tUsername).toJson());
      jsonMap = json.decode(jsonData);
    });

    test('should return success when username and password is currect',
        () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.get(any())).thenReturn(jsonData);
      // ignore: avoid_returning_null_for_void
      when(() => mockBox.close()).thenAnswer((_) async => null);
      //act
      final result = await dataSource.login(tUsername, tPassword);
      //assert

      verify(() => mockHive.openBox('users')).called(1);
      verify(() => mockBox.get(tUsername)).called(1);
      verify(() => mockBox.close()).called(1);
      expect(result, const Success());
      expect(jsonMap['password'], tPassword);
    });

    test('should throw LoginException when username not exist', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.get(any())).thenReturn(null);
      // ignore: avoid_returning_null_for_void
      when(() => mockBox.close()).thenAnswer((_) async => null);
      // ignore: avoid_returning_null_for_void
      //act
      final call = dataSource.login;
      //assert
      expect(() => call(tUsername, tPassword),
          throwsA(const TypeMatcher<LoginException>()));
    });
  });
}
