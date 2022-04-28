import 'package:dartz/dartz.dart';
import '../../../../Core/Error/failures.dart';
import '../../../../Core/Entities/success.dart';

abstract class LoginRepository {
  Future<Either<Failure, Success>> login(username, password);
}
