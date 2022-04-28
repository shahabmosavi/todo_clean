import 'package:hive/hive.dart';
import 'package:todo_clean/Core/Entities/success.dart';

abstract class CoreLocalDataSource {
  Future<Success> setLogedInUser(username);
  Future<String> getLogedInUser();
}

class CoreLocalDataSourceImpl implements CoreLocalDataSource {
  final HiveInterface hive;

  CoreLocalDataSourceImpl(this.hive);
  @override
  Future<Success> setLogedInUser(username) async {
    final logedBox = await hive.openBox('loged');
    logedBox.put(0, username);

    await logedBox.close();
    return const Success();
  }

  @override
  Future<String> getLogedInUser() async {
    final logedBox = await hive.openBox('loged');
    final res = logedBox.get(0);

    await logedBox.close();
    return res;
  }
}
