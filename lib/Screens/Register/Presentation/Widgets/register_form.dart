import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_clean/Screens/Login/Presentation/Pages/login_page.dart';
import 'package:todo_clean/Screens/Register/Presentation/Getx/register_getx.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final RxBool showPassword;
  late String username, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    showPassword = false.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RegisterGetx getx = Get.find();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: Obx(
                () => Text(getx.message),
              )),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Username'),
            onSaved: (String? val) {
              username = val!;
            },
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'Username must not be empty';
              }
              if (val.length < 4) {
                return 'Username must be atleast 4 character';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          Obx(
            () => TextFormField(
              onSaved: (String? val) {
                password = val!;
              },
              validator: (String? val) {
                if (val == null || val.isEmpty) {
                  return 'password must not be empty';
                }
                if (val.length < 4) {
                  return 'password must be atleast 4 character';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(showPassword.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      showPassword.value = !showPassword.value;
                    },
                  )),
              obscureText: showPassword.value,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
          const SizedBox(height: 50),
          GestureDetector(
              onTap: () {
                Get.to(() => const LoginPage());
              },
              child: const Text(
                'You have an account?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              )),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState == null ||
                    !_formKey.currentState!.validate()) {
                  return;
                }

                _formKey.currentState!.save();

                getx.register(username, password);
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
    );
  }
}
