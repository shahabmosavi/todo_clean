import 'dart:convert';

import 'package:hive/hive.dart';
import '../../../../Core/Entities/success.dart';
import '../../../../Core/Models/auth_model.dart';

import '../../../../Core/Error/exceptions.dart';

abstract class RegisterLocalDataSource {
  Future<Success> register(username, password);
}

class RegisterLocalDataSourceImpl implements RegisterLocalDataSource {
  final HiveInterface hive;

  RegisterLocalDataSourceImpl(this.hive);
  @override
  Future<Success> register(username, password) async {
    final usersBox = await hive.openBox('users');

    final bool userNotExist = usersBox.get(username) == null;
    if (userNotExist) {
      final String userData = json
          .encode(AuthModel(password: password, username: username).toJson());
      usersBox.put(username, userData);
      await usersBox.close();
      return const Success();
    }
    await usersBox.close();

    throw RegisterException();
  }
}
