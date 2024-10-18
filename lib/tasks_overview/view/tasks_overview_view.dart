import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosoft_task/edit_task/view/edit_task_page.dart';
import 'package:prosoft_task/extensions/sizebox_extension.dart';
import 'package:prosoft_task/extensions/widget_extension.dart';
import 'package:prosoft_task/tasks_overview/bloc/tasks_overview_bloc.dart';
import 'package:prosoft_task/tasks_overview/widgets/task_list_tile.dart';
import 'package:prosoft_task/tasks_overview/widgets/tasks_overview_options_button.dart';

class TasksOverviewView extends StatelessWidget {
  const TasksOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Tasks',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w900,
                fontFamily: GoogleFonts.lora().fontFamily,
              ),
        ),
        actions: const [
          TasksOverviewOptionsButton(),
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(4.0),
        //   child: Container(
        //     color: Colors.orange,
        //     height: 4.0,
        //   ),
        // ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TasksOverviewBloc, TasksOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == TasksOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('An error occurred while loading tasks.'),
                    ),
                  );
              }
            },
          ),
          BlocListener<TasksOverviewBloc, TasksOverviewState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTask != current.lastDeletedTask &&
                current.lastDeletedTask != null,
            listener: (context, state) {
              final deletedTask = state.lastDeletedTask!;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Task ${deletedTask.todo} deleted.')),
                );
            },
          ),
        ],
        child: BlocBuilder<TasksOverviewBloc, TasksOverviewState>(
          builder: (context, state) {
            if (state.tasks.isEmpty) {
              if (state.status == TasksOverviewStatus.loading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state.status != TasksOverviewStatus.success) {
                return const SizedBox();
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/tasks.jpg',
                        width: 250,
                      ),
                    ),
                    20.h,
                    // const SizedBox(height: 20),
                    Text(
                      'No tasks found with the selected filters.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    20.h,
                    // const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: context.read<TasksOverviewBloc>().onRefresh,
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: context.read<TasksOverviewBloc>().onRefresh,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                // cacheExtent: 5,
                // controller:
                //     context.read<TasksOverviewBloc>().resultScrollController,
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  if (index != state.tasks.length - 1) {
                    return TaskListTile(
                      task: state.tasks.elementAt(index),
                      onDismissed: (_) {
                        context.read<TasksOverviewBloc>().add(
                              TasksOverviewTaskDeleted(
                                state.tasks.elementAt(index),
                              ),
                            );
                      },
                      onToggleCompleted: (isCompleted) {
                        context.read<TasksOverviewBloc>().add(
                              TasksOverviewTaskCompletionToggled(
                                task: state.tasks.elementAt(index),
                                completed: isCompleted,
                              ),
                            );
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          EditTaskPage.route(
                            tasksOverviewBloc:
                                context.read<TasksOverviewBloc>(),
                            initialTask: state.tasks.elementAt(index),
                          ),
                        );
                      },
                    ).onlyPadding(top: 6);
                  }
                  return Column(
                    children: [
                      TaskListTile(
                        task: state.tasks.elementAt(index),
                        onDismissed: (_) {
                          context.read<TasksOverviewBloc>().add(
                                TasksOverviewTaskDeleted(
                                  state.tasks.elementAt(index),
                                ),
                              );
                        },
                        onToggleCompleted: (isCompleted) {
                          context.read<TasksOverviewBloc>().add(
                                TasksOverviewTaskCompletionToggled(
                                  task: state.tasks.elementAt(index),
                                  completed: isCompleted,
                                ),
                              );
                        },
                        onTap: () {
                          Navigator.of(context).push(
                            EditTaskPage.route(
                              tasksOverviewBloc:
                                  context.read<TasksOverviewBloc>(),
                              initialTask: state.tasks.elementAt(index),
                            ),
                          );
                        },
                      ).onlyPadding(top: 6, bottom: 36),
                      if (state.status == TasksOverviewStatus.loading)
                        const Center(child: RefreshProgressIndicator())
                    ],
                  ).onlyPadding(bottom: 36);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
