import 'package:todo_clean/Core/DataSource/core_local_data_source.dart';

import '../../../../Core/Error/exceptions.dart';
import '../../../../Core/Error/failures.dart';
import '../../../../Core/Entities/success.dart';
import 'package:dartz/dartz.dart';
import '../DataSources/login_local_data_source.dart';
import '../../Domain/Repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginLocalDataSource localDataSource;
  final CoreLocalDataSource coreLocalDataSource;

  LoginRepositoryImpl(this.localDataSource, this.coreLocalDataSource);
  @override
  Future<Either<Failure, Success>> login(username, password) async {
    try {
      final res = await localDataSource.login(username, password);
      coreLocalDataSource.setLogedInUser(username);
      return Right(res);
    } on LoginException {
      return const Left(LoginFailure());
    }
  }
}
