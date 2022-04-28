import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Core/Error/failures.dart';
import 'package:todo_clean/Screens/Login/Domain/Usecases/login_usecases.dart';
import 'package:todo_clean/Screens/Login/Presentation/Getx/login_getx.dart';

class MockLoginUsecases extends Mock implements LoginUsecases {}

void main() {
  late MockLoginUsecases mockLoginUsecases;
  late LoginGetx loginGetx;

  setUp(() {
    mockLoginUsecases = MockLoginUsecases();
    loginGetx = LoginGetx(mockLoginUsecases);
  });

  group('login', () {
    const tUsername = 'usenrame', tPassword = 'password';
    const tAuthModel = Success();

    testWidgets('should call login in usecase if inputs are not empty',
        (tester) async {
      //arrange
      await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));

      when(() => mockLoginUsecases.login(any(), any()))
          .thenAnswer((_) async => const Right(tAuthModel));
      //act
      await loginGetx.login(tUsername, tPassword);
      //assert
      verify(() => mockLoginUsecases.login(tUsername, tPassword)).called(1);
    });
    testWidgets(
        "should navigate to TodoPage when login is called successfully ",
        (tester) async {
      //arrange
      when(() => mockLoginUsecases.login(any(), any()))
          .thenAnswer((_) async => const Right(Success()));
      await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));

      //act
      await loginGetx.login(tUsername, tPassword);
      //assert

      verify(() => mockLoginUsecases.login(tUsername, tPassword)).called(1);
      expect(loginGetx.state, LoginGetxStates.empty);
      expect(loginGetx.message, '');
    });
    test(
        "should set message to LoginFailure message and change state to [Error] when login not successfully called",
        () async {
      //arrange
      when(() => mockLoginUsecases.login(any(), any()))
          .thenAnswer((_) async => const Left(LoginFailure()));
      //act
      await loginGetx.login(tUsername, tPassword);
      //assert
      verify(() => mockLoginUsecases.login(tUsername, tPassword)).called(1);
      expect(loginGetx.state, LoginGetxStates.error);

      expect(loginGetx.message, const LoginFailure().message());
    });
  });
}
