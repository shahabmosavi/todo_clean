import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final bool checked;
  final int id;
  final String task;

  const Todo({required this.checked, required this.id, required this.task});

  @override
  List<Object?> get props => [checked, id, task];
}
