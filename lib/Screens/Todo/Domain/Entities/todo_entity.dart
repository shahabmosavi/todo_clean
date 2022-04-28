import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int id;
  final String task;
  final bool checked;

  const TodoEntity(
      {required this.id, required this.task, required this.checked});

  @override
  List<Object?> get props => [checked, id, task];
}
