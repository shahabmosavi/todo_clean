import 'package:todo_clean/Core/DataSource/core_local_data_source.dart';

import '../../../../Core/Error/exceptions.dart';
import '../../../../Core/Error/failures.dart';
import '../../../../Core/Entities/success.dart';
import 'package:dartz/dartz.dart';
import '../DataSources/register_local_data_source.dart';
import '../../Domain/Repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterLocalDataSource localDataSource;
  final CoreLocalDataSource coreLocalDataSource;

  RegisterRepositoryImpl(this.localDataSource, this.coreLocalDataSource);
  @override
  Future<Either<Failure, Success>> register(username, password) async {
    try {
      final res = await localDataSource.register(username, password);
      await coreLocalDataSource.setLogedInUser(username);
      return Right(res);
    } on RegisterException {
      return const Left(RegisterFailure());
    }
  }
}
