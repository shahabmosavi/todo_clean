import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String password, username;

  const AuthEntity({required this.password, required this.username});

  @override
  List<Object?> get props => [password, username];
}
