import 'dart:convert';

import 'package:prosoft_task/api/task/i_task_repository.dart';
import 'package:prosoft_task/api/task/tasks_client.dart';
import 'package:prosoft_task/api/storage.dart';

import 'models/models.dart';

class TaskRepository extends ITasksRepository {
  const TaskRepository({
    required this.storage,
    required this.client,
  });

  final Storage storage;
  final TaskClient client;
  static const String key = 'tasks?';

  Future<Task> addTask(Task task) async {
    final result = await client.addTask(task, storage.getValue('token')!);
    if (result == null) {
      return task;
    }

    await storage.setValue('$key${task.id.toString()}', jsonEncode(result));
    storage.removeByPrefix(key);

    return task;
  }

  @override
  Future<bool> deleteTask(int id) async {
    final result = await client.deleteTask(id, storage.getValue('token')!);
    if (!result) {
      return false;
    }

    await storage.remove('$key${id.toString()}');
    storage.removeByPrefix(key);

    return true;
  }

  @override
  Future<TaskResult?> getTasks(String pageNumber, String perPage) async {
    final result =
        await client.getTasks(pageNumber, perPage, storage.getValue('token')!);
    if (result == null) {
      if (storage.contains('${key}PageNumber:$pageNumber,PerPage:$perPage')) {
        final savedTasks =
            storage.getValue('${key}PageNumber:$pageNumber,PerPage:$perPage');

        if (savedTasks == null) return null;

        final tasks = TaskResult.fromJson(
          jsonDecode(savedTasks) as Map<String, dynamic>,
        );

        return tasks;
      }
      return null;
    }

    await storage.setValue(
      '${key}PageNumber:$pageNumber,PerPage:$perPage',
      result,
    );

    final tasks = TaskResult.fromJson(
      jsonDecode(result) as Map<String, dynamic>,
    );

    return tasks;
  }

  Future<Task> updateTask(Task task) async {
    final result = await client.updateTask(task, storage.getValue('token')!);
    if (result == null) {
      if (storage.contains('$key${task.id.toString()}')) {
        final savedTask = storage.getValue('$key${task.id.toString()}');
        if (savedTask == null) {
          return task;
        }

        return Task.fromJson(jsonDecode(savedTask) as Map<String, dynamic>);
      }
      return task;
    }

    await storage.setValue('$key${task.id.toString()}', result.toString());
    storage.removeByPrefix(key);

    return result;
  }

  @override
  Future<Task> saveTask(Task task) {
    if (task.id == 0) {
      return addTask(task);
    }
    return updateTask(task);
  }
}
