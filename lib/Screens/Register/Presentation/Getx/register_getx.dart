import 'package:get/get.dart';
import 'package:todo_clean/Screens/Register/Domain/Usecases/register_usecases.dart';
import 'package:todo_clean/Screens/Todo/Presentation/Pages/todo_page.dart';

class RegisterGetx {
  final RegisterUsecases usecases;

  RegisterGetx(this.usecases);

  final Rx<RegisterGetxStates> _state = RegisterGetxStates.empty.obs;
  final RxString _message = ''.obs;

  String get message => _message.value;
  RegisterGetxStates get state => _state.value;
  Future<void> register(username, password) async {
    _state.value = RegisterGetxStates.loading;
    await Future.delayed(const Duration(seconds: 2));

    final successOrFilure = await usecases.register(username, password);
    successOrFilure.fold((failure) {
      _state.value = RegisterGetxStates.error;
      _message.value = failure.message();
    }, (r) {
      Get.to(() => const TodoPage());
      _state.value = RegisterGetxStates.empty;

      _message.value = '';
    });
    return;
  }
}

enum RegisterGetxStates { empty, loading, error }
