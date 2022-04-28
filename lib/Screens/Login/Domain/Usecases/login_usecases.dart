import 'package:todo_clean/Core/Error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Screens/Login/Domain/Repositories/login_repository.dart';

class LoginUsecases {
  final LoginRepository repository;

  LoginUsecases(this.repository);
  Future<Either<Failure, Success>> login(username, password) async {
    return await repository.login(username, password);
  }
}
