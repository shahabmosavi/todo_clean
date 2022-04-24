import 'package:get/get.dart';
import 'package:todo_clean/Screens/Register/Domain/Usecases/register_usecases.dart';
import 'package:todo_clean/Screens/Register/Presentation/Getx/register_getx_states.dart';

class RegisterGetx {
  final RegisterUsecases usecases;

  RegisterGetx(this.usecases);

  final Rx<RegisterGetxStates> _state = Empty().obs;
  final RxString _message = ''.obs;

  String get message => _message.value;
  RegisterGetxStates get state => _state.value;
  Future<void> register(username, password) async {
    final successOrFilure = await usecases.register(username, password);
    successOrFilure.fold((failure) {
      // _state.value = Error();
      _message.value = failure.message();
    }, (r) => null);
    return;
  }
}
