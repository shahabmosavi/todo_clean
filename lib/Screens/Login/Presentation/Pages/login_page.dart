import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_clean/Screens/Login/Presentation/Getx/login_getx.dart';
import 'package:todo_clean/Screens/Login/Presentation/Widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginGetx getx = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Obx(
                () => Center(
                  child: getx.state == LoginGetxStates.loading
                      ? const CircularProgressIndicator()
                      : const LoginForm(),
                ),
              ))),
    );
  }
}
