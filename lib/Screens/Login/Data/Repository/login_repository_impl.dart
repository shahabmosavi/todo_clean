import '../../../../Core/Error/exceptions.dart';
import '../../../../Core/Error/failures.dart';
import '../../../../Core/Entities/success.dart';
import 'package:dartz/dartz.dart';
import '../DataSources/login_local_data_source.dart';
import '../../Domain/Repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImpl(this.localDataSource);
  @override
  Future<Either<Failure, Success>> login(username, password) async {
    try {
      return Right(await localDataSource.login(username, password));
    } on LoginException {
      return const Left(LoginFailure());
    }
  }
}
