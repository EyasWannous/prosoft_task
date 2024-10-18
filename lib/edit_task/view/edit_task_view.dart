import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/edit_task/bloc/edit_task_bloc.dart';
import 'package:prosoft_task/edit_task/widgets/todo_filed.dart';
import 'package:prosoft_task/edit_task/widgets/widgets.dart';
import 'package:prosoft_task/extensions/sizebox_extension.dart';
import 'package:prosoft_task/extensions/widget_extension.dart';
import 'package:prosoft_task/theme/bloc/theme_bloc.dart';
import 'package:prosoft_task/theme/theme.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditTaskBloc bloc) => bloc.state.status);
    final isNewTask = context.select(
      (EditTaskBloc bloc) => bloc.state.isNewTask,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewTask ? 'Add Task' : 'Edit Task',
        ),
        actions: [
          BlocBuilder<ThemeBloc, ThemeData>(
            builder: (_, themeData) {
              return IconButton(
                onPressed: () =>
                    context.read<ThemeBloc>().add(ThemeSwitchEvent()),
                icon: Icon(
                  themeData.colorScheme == FlutterTasksTheme.dark.colorScheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: context.read<EditTaskBloc>().formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://www.projoodle.com/landing/img/todo-list-wizard.png",
                    progressIndicatorBuilder: (_, __, downloadProgress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                    width: 75 * 2,
                    height: 150 * 2,
                  ),
                  Text(
                    'Add Task to your list',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
              20.h,
              const TodoField(),
              20.h,
              const CompleteTask()
            ],
          ),
        ).allPadding(16),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save changes',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () {
                if (context.read<EditTaskBloc>().checkValidation()) {
                  context.read<EditTaskBloc>().add(const EditTaskSubmitted());
                }
              },
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
    );
  }
}
