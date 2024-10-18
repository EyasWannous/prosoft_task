part of 'tasks_overview_bloc.dart';

enum TasksOverviewStatus { initial, loading, success, failure }

final class TasksOverviewState extends Equatable {
  const TasksOverviewState({
    this.status = TasksOverviewStatus.initial,
    this.tasks = const [],
    this.lastDeletedTask,
  });

  final TasksOverviewStatus status;
  final List<Task> tasks;
  final Task? lastDeletedTask;

  TasksOverviewState copyWith({
    TasksOverviewStatus? status,
    List<Task>? tasks,
    Task? lastDeletedTask,
  }) {
    return TasksOverviewState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      lastDeletedTask: lastDeletedTask ?? this.lastDeletedTask,
    );
  }

  @override
  List<Object?> get props => [status, tasks, lastDeletedTask];
}
