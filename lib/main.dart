import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_clean/Screens/Register/Presentation/Pages/register_page.dart';
import 'package:todo_clean/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  HiveInterface hive = Get.find();
  final directory = await getApplicationDocumentsDirectory();
  hive.init(directory.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(title: 'todo clean', home: RegisterPage());
  }
}
