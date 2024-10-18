import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/edit_task/bloc/edit_task_bloc.dart';
import 'package:prosoft_task/extensions/sizebox_extension.dart';

class CompleteTask extends StatelessWidget {
  const CompleteTask({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          state.completed ? 'Completed' : 'Not Completed',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        Icon(
          state.completed ? Icons.check : Icons.close,
          color: state.completed
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        8.w,
        ElevatedButton(
          onPressed: () => context.read<EditTaskBloc>().add(
                EditTaskCompletedChanged(!state.completed),
              ),
          child: Text(
            state.completed ? 'Mark as Complete' : 'Mark as Not Complete',
          ),
        )
      ],
    );
  }
}
