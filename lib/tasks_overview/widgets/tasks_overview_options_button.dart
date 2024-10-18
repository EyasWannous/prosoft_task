import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/app/bloc/app_bloc.dart';
import 'package:prosoft_task/theme/bloc/theme_bloc.dart';
import 'package:prosoft_task/theme/theme.dart';

enum TasksOverviewOption { swithTheme, logout }

class TasksOverviewOptionsButton extends StatelessWidget {
  const TasksOverviewOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TasksOverviewOption>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      tooltip: 'Options',
      onSelected: (options) {
        switch (options) {
          case TasksOverviewOption.swithTheme:
            context.read<ThemeBloc>().add(ThemeSwitchEvent());
          case TasksOverviewOption.logout:
            context.read<AppBloc>().add(const AppLogoutRequested());
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: TasksOverviewOption.logout,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Logout'),
                Icon(Icons.logout),
              ],
            ),
          ),
          PopupMenuItem(
            value: TasksOverviewOption.swithTheme,
            child: BlocBuilder<ThemeBloc, ThemeData>(
              builder: (_, themeData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Change Theme'),
                    Icon(
                      themeData.colorScheme ==
                              FlutterTasksTheme.dark.colorScheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                  ],
                );
              },
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
