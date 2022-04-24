import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
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
    testWidgets('should call register in usecase if input are not empty',
        (tester) async {
      //arrange
      await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));

      when(() => mockRegisterUsecases.register(any(), any()))
          .thenAnswer((_) async => const Right(tAuthModel));
      //act
      registerGetx.register(tUsername, tPassword);
      //assert
      verify(() => mockRegisterUsecases.register(tUsername, tPassword))
          .called(1);
    });
    testWidgets('should call register in usecase if input are not empty',
        (tester) async {
      //arrange
      await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));

      when(() => mockRegisterUsecases.register(any(), any()))
          .thenAnswer((_) async => const Right(tAuthModel));
      //act
      registerGetx.register(tUsername, tPassword);
      //assert
      verify(() => mockRegisterUsecases.register(tUsername, tPassword))
          .called(1);
    });
    testWidgets(
        "should navigate to TodoPage when register is called successfully ",
        (tester) async {
      //arrange
      when(() => mockRegisterUsecases.register(any(), any()))
          .thenAnswer((_) async => const Right(Success()));
      await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));

      //act
      await registerGetx.register(tUsername, tPassword);
      //assert

      verify(() => mockRegisterUsecases.register(tUsername, tPassword))
          .called(1);
      expect(registerGetx.state, RegisterGetxStates.empty);
      expect(registerGetx.message, '');
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
      expect(registerGetx.state, RegisterGetxStates.error);

      expect(registerGetx.message, const RegisterFailure().message());
    });
  });
}
