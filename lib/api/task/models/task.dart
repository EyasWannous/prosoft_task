import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  const Task({
    required this.todo,
    required this.userId,
    required this.completed,
    int? id,
  }) : id = id ?? 0;

  final int id;
  final String todo;
  final int userId;
  final bool completed;

  Task copyWith({
    int? id,
    String? todo,
    int? userId,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      userId: userId ?? this.userId,
      completed: completed ?? this.completed,
    );
  }

  static Task fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object> get props => [id, todo, userId, completed];
}
