import 'dart:convert';

import '../Entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required String password, required String username})
      : super(password: password, username: username);

  factory AuthModel.fromJson(String jsonData) {
    Map<String, dynamic> decoded = json.decode(jsonData);
    return AuthModel(
        password: decoded['password']!, username: decoded['username']!);
  }
  Map<String, String> toJson() {
    return {'username': username, "password": password};
  }
}
