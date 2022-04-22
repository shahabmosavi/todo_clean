import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_clean/Core/Entities/success.dart';

abstract class RegisterLocalDataSource {
  Future<Success> register(username, password);
}

class RegisterLocalDataSourceImpl implements RegisterLocalDataSource {
  final SharedPreferences sharedPreferences;

  RegisterLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<Success> register(username, password) {
    throw UnimplementedError();
  }
}
