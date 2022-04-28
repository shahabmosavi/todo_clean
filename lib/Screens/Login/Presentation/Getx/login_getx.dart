import 'package:get/get.dart';
import 'package:todo_clean/Screens/Login/Domain/Usecases/login_usecases.dart';
import 'package:todo_clean/Screens/Todo/Presentation/Pages/todo_page.dart';

class LoginGetx {
  final LoginUsecases usecases;

  LoginGetx(this.usecases);

  final Rx<LoginGetxStates> _state = LoginGetxStates.empty.obs;
  final RxString _message = ''.obs;

  String get message => _message.value;
  LoginGetxStates get state => _state.value;
  Future<void> login(username, password) async {
    _state.value = LoginGetxStates.loading;
    await Future.delayed(const Duration(seconds: 2));

    final successOrFilure = await usecases.login(username, password);
    successOrFilure.fold((failure) {
      _state.value = LoginGetxStates.error;
      _message.value = failure.message();
    }, (r) {
      Get.offAll(() => const TodoPage());
      _state.value = LoginGetxStates.empty;

      _message.value = '';
    });
    return;
  }
}

enum LoginGetxStates { empty, loading, error }
