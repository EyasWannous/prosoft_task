import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:prosoft_task/api/task/i_task_repository.dart';
import 'package:prosoft_task/api/task/models/task.dart';
import 'package:prosoft_task/tasks_overview/bloc/tasks_overview_bloc.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc({
    required TasksOverviewBloc tasksOverviewBloc,
    required ITasksRepository tasksRepository,
    required Task? initialTask,
  })  : _tasksRepository = tasksRepository,
        _tasksOverviewBloc = tasksOverviewBloc,
        todoEditingController = TextEditingController(),
        userIdEditingController = TextEditingController(),
        completedEditingController = TextEditingController(),
        super(
          EditTaskState(
            initialTask: initialTask,
            todo: initialTask?.todo ?? '',
            completed: initialTask?.completed ?? false,
            userId: initialTask?.userId ?? 0,
          ),
        ) {
    on<EditTaskTodoChanged>(_onTodoChanged);
    on<EditTaskUserIdChanged>(_onUserIdChanged);
    on<EditTaskCompletedChanged>(_onCompletedChanged);
    on<EditTaskSubmitted>(_onSubmitted);

    setOfInts.add(Random().nextInt(1000));
  }

  final ITasksRepository _tasksRepository;
  final TasksOverviewBloc _tasksOverviewBloc;

  final TextEditingController todoEditingController;
  final TextEditingController userIdEditingController;
  final TextEditingController completedEditingController;

  int initialMax = 1000;
  Set<int> setOfInts = {};

  void _onTodoChanged(
    EditTaskTodoChanged event,
    Emitter<EditTaskState> emit,
  ) =>
      emit(state.copyWith(todo: event.todo));

  void _onUserIdChanged(
    EditTaskUserIdChanged event,
    Emitter<EditTaskState> emit,
  ) =>
      emit(state.copyWith(userId: event.userId));

  void _onCompletedChanged(
    EditTaskCompletedChanged event,
    Emitter<EditTaskState> emit,
  ) =>
      emit(state.copyWith(completed: event.completed));

  Future<void> _onSubmitted(
    EditTaskSubmitted event,
    Emitter<EditTaskState> emit,
  ) async {
    emit(state.copyWith(status: EditTaskStatus.loading));
    final task =
        (state.initialTask ?? const Task(todo: '', userId: 0, completed: false))
            .copyWith(
      id: state.initialTask?.id,
      todo: state.todo,
      userId: state.userId,
      completed: state.completed,
    );

    try {
      emit(state.copyWith(status: EditTaskStatus.success));
      var savedTask = await _tasksRepository.saveTask(task);
      var newTask = savedTask.copyWith();
      if (state.initialTask == null) {
        if (setOfInts.isEmpty) {
          initialMax += 1000;
          setOfInts.add(initialMax);
        }
        newTask = savedTask.copyWith(id: setOfInts.first);
        setOfInts.remove(setOfInts.first);
      }
      _tasksOverviewBloc.add(TasksOverviewTaskAdd(newTask));
    } catch (e) {
      emit(state.copyWith(status: EditTaskStatus.failure));
    }
  }

  // Form
  final formKey = GlobalKey<FormState>();

  bool checkValidation() => formKey.currentState!.validate();

  @override
  Future<void> close() {
    todoEditingController.dispose();
    userIdEditingController.dispose();
    completedEditingController.dispose();
    return super.close();
  }
}
