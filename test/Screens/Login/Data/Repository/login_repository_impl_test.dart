import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Core/Error/exceptions.dart';
import 'package:todo_clean/Core/Error/failures.dart';
import 'package:todo_clean/Screens/Login/Data/DataSources/login_local_data_source.dart';
import 'package:todo_clean/Screens/Login/Data/Repository/login_repository_impl.dart';

class MockLocalDataSource extends Mock implements LoginLocalDataSource {}

void main() {
  late MockLocalDataSource mockLocalDataSource;

  late LoginRepositoryImpl loginRepositoryImpl;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    loginRepositoryImpl = LoginRepositoryImpl(mockLocalDataSource);
  });
  const tSuccess = Success();
  group('login', () {
    const String tUsername = 'username', tPassword = 'password';
    test(
        'should return success and store username when user logined successfully',
        () async {
      //arrange
      when(() => mockLocalDataSource.login(any(), any()))
          .thenAnswer((_) async => tSuccess);

      //act
      final result = await loginRepositoryImpl.login(tUsername, tPassword);

      //assert
      expect(result, const Right(tSuccess));
      verify(() => mockLocalDataSource.login(tUsername, tPassword)).called(1);
    });
    test('should return LoginFailure when user logined usuccessfully',
        () async {
      //arrange
      when(() => mockLocalDataSource.login(any(), any()))
          .thenThrow(LoginException());

      //act
      final result = await loginRepositoryImpl.login(tUsername, tPassword);

      //assert
      expect(result, const Left(LoginFailure()));
      verify(() => mockLocalDataSource.login(tUsername, tPassword)).called(1);
    });
  });
}
