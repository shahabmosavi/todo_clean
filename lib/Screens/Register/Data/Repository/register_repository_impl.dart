import '../../../../Core/Error/exceptions.dart';
import '../../../../Core/Error/failures.dart';
import '../../../../Core/Entities/success.dart';
import 'package:dartz/dartz.dart';
import '../DataSources/register_local_data_source.dart';
import '../../Domain/Repositories/register_repository.dart';

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
