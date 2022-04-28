import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Screens/Login/Domain/Repositories/login_repository.dart';
import 'package:todo_clean/Screens/Login/Domain/Usecases/login_usecases.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late MockLoginRepository mockLoginRepository;
  late LoginUsecases usecases;
  const String tUsername = 'username', tPassword = 'password';
  const tSuccess = Success();
  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecases = LoginUsecases(mockLoginRepository);
  });

  test("should call login with proper data from the repository", () async {
    // arrange
    when(() => mockLoginRepository.login(any(), any()))
        .thenAnswer((_) async => const Right(tSuccess));
    //act
    final result = await usecases.login(tUsername, tPassword);
    //assert
    expect(result, const Right(tSuccess));
    verify(() => mockLoginRepository.login(tUsername, tPassword));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
