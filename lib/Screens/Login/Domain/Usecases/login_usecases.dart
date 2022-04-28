import '../../../../Core/Error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../Core/Entities/success.dart';
import '../Repositories/login_repository.dart';

class LoginUsecases {
  final LoginRepository repository;

  LoginUsecases(this.repository);
  Future<Either<Failure, Success>> login(username, password) async {
    return await repository.login(username, password);
  }
}
