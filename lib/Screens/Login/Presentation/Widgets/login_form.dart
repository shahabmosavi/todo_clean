import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/login_page.dart';
import '../Getx/login_getx.dart';
import '../../../Register/Presentation/Pages/register_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    LoginGetx getx = Get.find();
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
                Get.offAll(() => const RegisterPage());
              },
              child: const Text(
                'Dont have an account?',
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

                getx.login(username, password);
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
    );
  }
}
