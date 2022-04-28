import 'package:todo_clean/Core/Error/exceptions.dart';
import 'package:todo_clean/Core/Error/failures.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_clean/Screens/Login/Data/DataSources/login_local_data_source.dart';
import 'package:todo_clean/Screens/Login/Domain/Repositories/login_repository.dart';

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
