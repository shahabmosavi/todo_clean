import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
  String message();
  @override
  List<Object> get props => [];
}

class RegisterFailure extends Failure {
  const RegisterFailure();
  @override
  String message() {
    return 'This UserName Already Exists';
  }
}

class LoginFailure extends Failure {
  const LoginFailure();
  @override
  String message() {
    return 'This UserName Does Not Exists';
  }
}
