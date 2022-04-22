import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Screens/Register/Domain/Repositories/register_repository.dart';
import 'package:todo_clean/Screens/Register/Domain/Usecases/register_usecases.dart';

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late MockRegisterRepository mockRegisterRepository;
  late RegisterUsecases usecases;
  const String tUsername = 'username', tPassword = 'password';
  const tSuccess = Success();
  setUp(() {
    mockRegisterRepository = MockRegisterRepository();
    usecases = RegisterUsecases(mockRegisterRepository);
  });

  test("should call register with proper data from the repository", () async {
    // arrange
    when(() => mockRegisterRepository.register(any(), any()))
        .thenAnswer((_) async => const Right(tSuccess));
    //act
    final result = await usecases.register(tUsername, tPassword);
    //assert
    expect(result, const Right(tSuccess));
    verify(() => mockRegisterRepository.register(tUsername, tPassword));
    verifyNoMoreInteractions(mockRegisterRepository);
  });
}
