import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Core/Error/failures.dart';
import 'package:todo_clean/Screens/Register/Domain/Usecases/register_usecases.dart';
import 'package:todo_clean/Screens/Register/Presentation/Getx/register_getx.dart';

class MockRegisterUsecases extends Mock implements RegisterUsecases {}

void main() {
  late MockRegisterUsecases mockRegisterUsecases;
  late RegisterGetx registerGetx;

  setUp(() {
    mockRegisterUsecases = MockRegisterUsecases();
    registerGetx = RegisterGetx(mockRegisterUsecases);
  });

  group('register', () {
    const tUsername = 'usenrame', tPassword = 'password';
    const tAuthModel = Success();
    test('should call register in usecase if input are not empty', () {
      //arrange
      when(() => mockRegisterUsecases.register(any(), any()))
          .thenAnswer((_) async => const Right(tAuthModel));
      //act
      registerGetx.register(tUsername, tPassword);
      //assert
      verify(() => mockRegisterUsecases.register(tUsername, tPassword))
          .called(1);
    });
    test(
        "should set message to RegisterFailure message and change state to [Error] when register not successfully called",
        () async {
      //arrange
      when(() => mockRegisterUsecases.register(any(), any()))
          .thenAnswer((_) async => const Left(RegisterFailure()));
      //act
      await registerGetx.register(tUsername, tPassword);
      //assert
      verify(() => mockRegisterUsecases.register(tUsername, tPassword))
          .called(1);
      // expect(registerGetx.state, /.const TypeMatcher<Error>());

      expect(registerGetx.message, const RegisterFailure().message());
    });
  });
}
