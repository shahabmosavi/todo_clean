import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_clean/Core/DataSource/core_local_data_source.dart';
import 'package:todo_clean/Screens/Todo/Data/DataSources/todo_local_data_source.dart';
import 'package:todo_clean/Screens/Todo/Data/Repositories/todo_repository_impl.dart';
import 'package:todo_clean/Screens/Todo/Domain/Repositories/todo_repository.dart';
import 'package:todo_clean/Screens/Todo/Domain/Usecases/todo_usecases.dart';
import 'package:todo_clean/Screens/Todo/Presentation/Getx/todo_getx.dart';
import 'Screens/Login/Data/DataSources/login_local_data_source.dart';
import 'Screens/Login/Data/Repository/login_repository_impl.dart';
import 'Screens/Login/Domain/Repositories/login_repository.dart';
import 'Screens/Login/Domain/Usecases/login_usecases.dart';
import 'Screens/Login/Presentation/Getx/login_getx.dart';
import 'Screens/Register/Data/DataSources/register_local_data_source.dart';
import 'Screens/Register/Data/Repository/register_repository_impl.dart';
import 'Screens/Register/Domain/Repositories/register_repository.dart';
import 'Screens/Register/Domain/Usecases/register_usecases.dart';
import 'Screens/Register/Presentation/Getx/register_getx.dart';

Future<void> init() async {
  //! Screens - register
  //third parties
  Get.lazyPut(() => Hive);
  //datasources
  Get.lazyPut<RegisterLocalDataSource>(
      () => RegisterLocalDataSourceImpl(Get.find()));
  Get.lazyPut<CoreLocalDataSource>(() => CoreLocalDataSourceImpl(Get.find()));
  //repository
  Get.lazyPut<RegisterRepository>(
      () => RegisterRepositoryImpl(Get.find(), Get.find()));
  //usecases
  Get.lazyPut(() => RegisterUsecases(Get.find()));
  //getx
  Get.lazyPut(() => RegisterGetx(Get.find()));
  //! Screens - login
  //third parties
  Get.lazyPut(() => Hive);
  //datasources
  Get.lazyPut<LoginLocalDataSource>(() => LoginLocalDataSourceImpl(Get.find()));
  //repository
  Get.lazyPut<LoginRepository>(
      () => LoginRepositoryImpl(Get.find(), Get.find()));
  //usecases
  Get.lazyPut(() => LoginUsecases(Get.find()));
  //getx
  Get.lazyPut(() => LoginGetx(Get.find()));
  //! Screens - todo
  //third parties
  Get.lazyPut(() => Hive);
  //datasources
  Get.lazyPut<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(Get.find(), Get.find()));
  //repository
  Get.lazyPut<TodoRepository>(() => TodoRepositoryImpl(Get.find()));
  //usecases
  Get.lazyPut(() => TodoUsecases(Get.find()));
  //getx
  Get.lazyPut(() => TodoGetx(Get.find()));
}
