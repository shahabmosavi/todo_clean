import 'package:dartz/dartz.dart';
import 'package:todo_clean/Core/Error/failures.dart';
import 'package:todo_clean/Core/Entities/success.dart';

abstract class RegisterRepository {
  Future<Either<Failure, Success>> register(username, password);
}
