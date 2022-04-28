import 'package:flutter_test/flutter_test.dart';
import 'package:todo_clean/Core/Entities/auth_entity.dart';
import 'package:todo_clean/Core/Models/auth_model.dart';

import '../../../Fixtures/fixture_reader.dart';

void main() {
  String tUsername = 'username', tPassword = 'password';
  final tAuthEntity = AuthModel(username: tUsername, password: tPassword);
  test(
    'should be a subclass of Auth entity',
    () async {
      // assert
      expect(tAuthEntity, isA<AuthEntity>());
    },
  );
  group('formJson', () {
    test('should return a valid model', () {
      //arrange
      final jsonData = fixture('user.json');
      // act

      final result = AuthModel.fromJson(jsonData);

      //assert
      expect(result, tAuthEntity);
    });
  });
  group('toJson', () {
    test('should return a valid map containing proper data', () {
      //arrange
      final expectedMap = {'username': "username", "password": "password"};
      // act

      final result = tAuthEntity.toJson();

      //assert
      expect(result, expectedMap);
    });
  });
}
