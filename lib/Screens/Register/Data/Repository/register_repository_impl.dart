import 'package:todo_clean/Core/Error/exceptions.dart';
import 'package:todo_clean/Core/Error/failures.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_clean/Screens/Register/Data/DataSources/register_local_data_source.dart';
import 'package:todo_clean/Screens/Register/Domain/Repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterLocalDataSource localDataSource;

  RegisterRepositoryImpl(this.localDataSource);
  @override
  Future<Either<Failure, Success>> register(username, password) async {
    try {
      return Right(await localDataSource.register(username, password));
    } on RegisterException {
      return const Left(RegisterFailure());
    }
  }
}
