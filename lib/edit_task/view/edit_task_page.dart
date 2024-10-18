import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/api/task/i_task_repository.dart';
import 'package:prosoft_task/api/task/models/task.dart';
import 'package:prosoft_task/edit_task/bloc/edit_task_bloc.dart';
import 'package:prosoft_task/tasks_overview/bloc/tasks_overview_bloc.dart';

import 'edit_task_view.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({super.key});

  static Route<void> route({
    Task? initialTask,
    required TasksOverviewBloc tasksOverviewBloc,
  }) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditTaskBloc(
          tasksOverviewBloc: tasksOverviewBloc,
          tasksRepository: context.read<ITasksRepository>(),
          initialTask: initialTask,
        ),
        child: const EditTaskPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTaskBloc, EditTaskState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditTaskStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditTaskView(),
    );
  }
}
