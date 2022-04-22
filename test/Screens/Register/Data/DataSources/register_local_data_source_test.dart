import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_clean/Screens/Register/Data/DataSources/register_local_data_source.dart';

class MockSharedPrefrences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPrefrences mockSharedPrefrences;
  late RegisterLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPrefrences = MockSharedPrefrences();
    dataSource = RegisterLocalDataSourceImpl(mockSharedPrefrences);
  });

  group('register', () {p});
}
