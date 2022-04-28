import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_clean/Screens/Login/Data/DataSources/login_local_data_source.dart';
import 'package:todo_clean/Screens/Login/Data/Repository/login_repository_impl.dart';
import 'package:todo_clean/Screens/Login/Domain/Repositories/login_repository.dart';
import 'package:todo_clean/Screens/Login/Domain/Usecases/login_usecases.dart';
import 'package:todo_clean/Screens/Login/Presentation/Getx/login_getx.dart';
import 'package:todo_clean/Screens/Register/Data/DataSources/register_local_data_source.dart';
import 'package:todo_clean/Screens/Register/Data/Repository/register_repository_impl.dart';
import 'package:todo_clean/Screens/Register/Domain/Repositories/register_repository.dart';
import 'package:todo_clean/Screens/Register/Domain/Usecases/register_usecases.dart';
import 'package:todo_clean/Screens/Register/Presentation/Getx/register_getx.dart';

Future<void> init() async {
  //! Screens - register
  //third parties
  Get.lazyPut(() => Hive);
  //datasources
  Get.lazyPut<RegisterLocalDataSource>(
      () => RegisterLocalDataSourceImpl(Get.find()));
  //repository
  Get.lazyPut<RegisterRepository>(() => RegisterRepositoryImpl(Get.find()));
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
  Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(Get.find()));
  //usecases
  Get.lazyPut(() => LoginUsecases(Get.find()));
  //getx
  Get.lazyPut(() => LoginGetx(Get.find()));
}
