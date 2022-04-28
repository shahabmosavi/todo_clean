import 'package:dartz/dartz.dart';

import '../../../../Core/Entities/success.dart';
import '../../../../Core/Error/failures.dart';

abstract class RegisterRepository {
  Future<Either<Failure, Success>> register(username, password);
}
