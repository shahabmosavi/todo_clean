// ignore_for_file: avoid_returning_null_for_void

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/DataSource/core_local_data_source.dart';
import 'package:todo_clean/Core/Entities/success.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

void main() {
  late final HiveInterface mockHive;
  late final CoreLocalDataSourceImpl dataSource;
  late final MockBox mockBox;
  setUp(() {
    mockHive = MockHive();
    mockBox = MockBox();
    dataSource = CoreLocalDataSourceImpl(mockHive);
  });

  group('setLogedInUser', () {
    const tUsername = 'username';
    test('should save user to loged box', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.close()).thenAnswer((_) async => null);
      when(() => mockBox.put(any(), any())).thenAnswer((_) async => null);
      //act
      final result = await dataSource.setLogedInUser(tUsername);
      //assert
      verify(() => mockHive.openBox('loged')).called(1);
      verify(() => mockBox.put(0, tUsername)).called(1);
      verify(() => mockBox.close()).called(1);
      expect(result, const Success());
    });
  });
  group('getLogedInUser', () {
    const tUsername = 'username';
    test('should get user from loged box', () async {
      //arrange
      when(() => mockHive.openBox(any())).thenAnswer((_) async => mockBox);
      when(() => mockBox.close()).thenAnswer((_) async => null);
      when(() => mockBox.get(
            any(),
          )).thenAnswer((_) async => tUsername);
      //act
      final result = await dataSource.getLogedInUser();
      //assert
      verify(() => mockHive.openBox('loged')).called(1);
      verify(() => mockBox.get(0)).called(1);
      verify(() => mockBox.close()).called(1);
      expect(result, tUsername);
    });
  });
}
