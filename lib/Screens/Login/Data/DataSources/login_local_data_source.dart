import 'package:hive/hive.dart';
import 'package:todo_clean/Core/Entities/success.dart';
import 'package:todo_clean/Core/Models/auth_model.dart';

import '../../../../Core/Error/exceptions.dart';

abstract class LoginLocalDataSource {
  Future<Success> login(username, password);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final HiveInterface hive;

  LoginLocalDataSourceImpl(this.hive);
  @override
  Future<Success> login(username, password) async {
    final usersBox = await hive.openBox('users');
    final user = usersBox.get(username);
    if (user != null) {
      AuthModel model = AuthModel.fromJson(user);
      if (model.password == password) {
        await usersBox.close();

        return const Success();
      }
    }
    await usersBox.close();

    throw LoginException();
  }
}
