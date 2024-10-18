import 'models/models.dart';

abstract class ITasksRepository {
  const ITasksRepository();

  Future<TaskResult?> getTasks(String pageNumber, String perPage);

  // Future<Task> addTask(Task task);

  Future<Task> saveTask(Task task);

  Future<bool> deleteTask(int id);
}

class TaskNotFoundException implements Exception {}
