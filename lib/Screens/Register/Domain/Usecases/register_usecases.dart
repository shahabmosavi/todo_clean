import '../../../../Core/Error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../Core/Entities/success.dart';
import '../Repositories/register_repository.dart';

class RegisterUsecases {
  final RegisterRepository repository;

  RegisterUsecases(this.repository);
  Future<Either<Failure, Success>> register(username, password) async {
    return await repository.register(username, password);
  }
}
