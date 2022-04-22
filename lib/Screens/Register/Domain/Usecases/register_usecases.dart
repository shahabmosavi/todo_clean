import 'package:todo_clean/Core/Error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Screens/Register/Domain/Repositories/register_repository.dart';

class RegisterUsecases {
  final RegisterRepository repository;

  RegisterUsecases(this.repository);
  Future<Either<Failure, Success>> register(username, password) async {
    return await repository.register(username, password);
  }
}
