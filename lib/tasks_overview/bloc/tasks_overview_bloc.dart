import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:prosoft_task/api/task/i_task_repository.dart';
import 'package:prosoft_task/api/task/models/task.dart';
import 'package:prosoft_task/api/task/models/task_result.dart';

part 'tasks_overview_event.dart';
part 'tasks_overview_state.dart';

class TasksOverviewBloc extends Bloc<TasksOverviewEvent, TasksOverviewState> {
  TasksOverviewBloc(
      // this.resultScrollController,
      {
    // required StatsBloc statsBloc,
    required ITasksRepository tasksRepository,
  })  : _tasksRepository = tasksRepository,
        // _statsBloc = statsBloc,
        super(const TasksOverviewState()) {
    on<TasksOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TasksOverviewTaskCompletionToggled>(_onTaskCompletionToggled);
    on<TasksOverviewTaskAdd>(_onTaskAddOrUpdated);
    on<TasksOverviewTaskDeleted>(_onTaskDeleted);
  }

  final ITasksRepository _tasksRepository;
  final List<Task> tasksResult = [];
  int pageNumber = 1;
  int perPage = 10;

  // final StatsBloc _statsBloc;

  void _onTaskAddOrUpdated(
      TasksOverviewTaskAdd event, Emitter<TasksOverviewState> emit) {
    emit(state.copyWith(status: TasksOverviewStatus.loading));

    final contains =
        tasksResult.indexWhere((element) => element.id == event.task.id);
    if (contains > -1) {
      tasksResult[contains] = event.task;
    } else {
      tasksResult.add(event.task);
      // _statsBloc.add(const StatsChangedActiveTasks(1));
    }

    emit(state.copyWith(
      status: TasksOverviewStatus.success,
      tasks: tasksResult,
    ));
  }

  // final ScrollController resultScrollController;
  // double lastPixelsPosition = 0;

  Future<void> _onSubscriptionRequested(
    TasksOverviewSubscriptionRequested event,
    Emitter<TasksOverviewState> emit,
  ) async {
    emit(state.copyWith(status: TasksOverviewStatus.loading));

    TaskResult? currentTasks = await _tasksRepository.getTasks(
      pageNumber.toString(),
      perPage.toString(),
    );

    if (currentTasks == null || currentTasks.todos == null) {
      emit(state.copyWith(status: TasksOverviewStatus.failure));
    }

    if (pageNumber == 1) {
      tasksResult.clear();

      if (currentTasks?.todos == null || currentTasks!.todos!.isEmpty) {
        // _fixAll();

        emit(state.copyWith(
          status: TasksOverviewStatus.success,
          tasks: tasksResult,
        ));

        return;
      }

      tasksResult.insertAll(0, currentTasks.todos!);

      // _fixAll();
      emit(state.copyWith(
        status: TasksOverviewStatus.success,
        tasks: tasksResult,
      ));

      return;
    }

    if (currentTasks?.todos != null && currentTasks!.todos!.isNotEmpty) {
      tasksResult.insertAll(0, currentTasks.todos!);
    }

    // _fixAll();
    emit(state.copyWith(
      status: TasksOverviewStatus.success,
      tasks: tasksResult,
    ));
  }

  Future<void> _onTaskDeleted(
    TasksOverviewTaskDeleted event,
    Emitter<TasksOverviewState> emit,
  ) async {
    try {
      await _tasksRepository.deleteTask(event.task.id);
      tasksResult.remove(event.task);
      emit(state.copyWith(lastDeletedTask: event.task));
    } catch (e) {
      emit(state.copyWith(status: TasksOverviewStatus.failure));
    }
  }

  Future<void> onRefresh() async {
    pageNumber = (tasksResult.length / perPage).ceil();
    pageNumber++;
    add(const TasksOverviewSubscriptionRequested());
  }

  void _onTaskCompletionToggled(
    TasksOverviewTaskCompletionToggled event,
    Emitter<TasksOverviewState> emit,
  ) {
    final newTodo = event.task.copyWith(completed: event.completed);

    if (tasksResult.indexWhere((element) => element.id == newTodo.id) > -1) {
      tasksResult[tasksResult.indexWhere(
        (element) => element.id == newTodo.id,
      )] = newTodo;

      // log('${tasksResult.indexWhere((element) => element.id == newTodo.id)}');
    }

    emit(state.copyWith(
      status: TasksOverviewStatus.loading,
    ));

    _tasksRepository.saveTask(newTodo);

    emit(state.copyWith(
      status: TasksOverviewStatus.success,
      tasks: tasksResult,
    ));
  }

  // void _fixAll() {
  //   for (var element in tasksResult) {
  //     _fixId(element);
  //   }
  // }

  // void _fixId(Task task) {
  //   var result = tasksResult.where((element) => element.id == task.id);
  //   if (result.length == 1) return;

  //   for (var element in result) {
  //     var temp = element.copyWith(
  //       id: DateTime.now().millisecondsSinceEpoch,
  //     );
  //     tasksResult.remove(element);
  //     tasksResult.add(temp);
  //   }
  // }
}
