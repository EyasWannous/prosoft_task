import 'package:flutter/material.dart';
import 'package:prosoft_task/api/task/models/task.dart';
import 'package:prosoft_task/extensions/widget_extension.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    required this.task,
    super.key,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
  });

  final Task task;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: Key('taskListTile_dismissible_${task.id}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.tertiaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(
          Icons.delete,
          color: theme.colorScheme.onBackground,
        ),
      ),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        color: !task.completed
            ? theme.colorScheme.surface
            : theme.colorScheme.outlineVariant,
        // surfaceTintColor: theme.colorScheme.onSecondary,
        shadowColor: theme.colorScheme.primary,
        elevation: 3,
        child: ListTile(
          onTap: onTap,
          title: Text(
            task.todo,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: !task.completed
                ? TextStyle(
                    color: captionColor,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    color: captionColor,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w400,
                  ),
          ),
          subtitle: Text(
            'By User: ${task.userId.toString()}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: Checkbox(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            value: task.completed,
            onChanged: onToggleCompleted == null
                ? null
                : (value) => onToggleCompleted!(value!),
          ),
          // trailing: Icon(
          //   Icons.arrow_forward_ios,
          //   color: theme.colorScheme.primary,
          // ),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: task.completed
                  ? theme.colorScheme.primary
                  : theme.colorScheme.tertiary,
              child: Text(
                task.completed ? 'Completed' : 'on-going',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: task.completed
                        ? theme.colorScheme.onInverseSurface
                        : theme.colorScheme.surfaceVariant
                    // : const Color(0XFFfeddaa),
                    ),
              ),
            ),
          ).onlyPadding(top: 24),
        ),
      ),
    );
  }
}
