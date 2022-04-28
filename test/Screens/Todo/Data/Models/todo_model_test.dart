import 'package:flutter_test/flutter_test.dart';
import 'package:todo_clean/Screens/Todo/Data/Models/todo_model.dart';
import 'package:todo_clean/Screens/Todo/Domain/Entities/todo_entity.dart';

import '../../../../Fixtures/fixture_reader.dart';

void main() {
  const tId = 1, tTask = "test task", tChecked = false;
  const tTodoEntity = TodoModel(checked: tChecked, task: tTask, id: tId);
  test(
    'should be a subclass of Todo entity',
    () async {
      // assert
      expect(tTodoEntity, isA<TodoEntity>());
    },
  );
  group('formJson', () {
    test('should return a valid model', () {
      //arrange
      final jsonData = fixture('todo.json');
      // act

      final result = TodoModel.fromJson(jsonData);

      //assert
      expect(result, tTodoEntity);
    });
  });
  group('toJson', () {
    test('should return a valid map containing proper data', () {
      //arrange
      final expectedMap = {'id': tId, "task": tTask, 'checked': tChecked};
      // act

      final result = tTodoEntity.toJson();

      //assert
      expect(result, expectedMap);
    });
  });
}
