import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_clean/Screens/Register/Presentation/Getx/register_getx.dart';
import 'package:todo_clean/Screens/Register/Presentation/Widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterGetx getx = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Obx(
                () => Center(
                  child: getx.state == RegisterGetxStates.loading
                      ? const CircularProgressIndicator()
                      : const RegisterForm(),
                ),
              ))),
    );
  }
}
