import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/DataSource/core_local_data_source.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Core/Error/exceptions.dart';
import 'package:todo_clean/Core/Error/failures.dart';
import 'package:todo_clean/Screens/Register/Data/DataSources/register_local_data_source.dart';
import 'package:todo_clean/Screens/Register/Data/Repository/register_repository_impl.dart';

class MockLocalDataSource extends Mock implements RegisterLocalDataSource {}

class MockCoreLocalDataSource extends Mock implements CoreLocalDataSource {}

void main() {
  late MockLocalDataSource mockLocalDataSource;

  late RegisterRepositoryImpl registerRepositoryImpl;
  late MockCoreLocalDataSource mockCoreLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockCoreLocalDataSource = MockCoreLocalDataSource();
    registerRepositoryImpl =
        RegisterRepositoryImpl(mockLocalDataSource, mockCoreLocalDataSource);
  });
  const tSuccess = Success();
  group('register', () {
    const String tUsername = 'username', tPassword = 'password';
    test('should return success when user registered successfully', () async {
      //arrange
      when(() => mockLocalDataSource.register(any(), any()))
          .thenAnswer((_) async => tSuccess);
      when(() => mockCoreLocalDataSource.setLogedInUser(any()))
          .thenAnswer((_) async => tSuccess);
      //act
      final result =
          await registerRepositoryImpl.register(tUsername, tPassword);

      //assert
      expect(result, const Right(tSuccess));
      verify(() => mockLocalDataSource.register(tUsername, tPassword))
          .called(1);
      verify(() => mockCoreLocalDataSource.setLogedInUser(tUsername)).called(1);
    });
    test('should return RegisterFailure when user registered usuccessfully',
        () async {
      //arrange
      when(() => mockLocalDataSource.register(any(), any()))
          .thenThrow(RegisterException());

      //act
      final result =
          await registerRepositoryImpl.register(tUsername, tPassword);

      //assert
      expect(result, const Left(RegisterFailure()));
      verify(() => mockLocalDataSource.register(tUsername, tPassword))
          .called(1);
    });
  });
}
