import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:prosoft_task/api/authentication/authentication_client.dart';
import 'package:prosoft_task/api/authentication/authentication_repository.dart';
import 'package:prosoft_task/api/category/category_client.dart';
import 'package:prosoft_task/api/category/category_repository.dart';
import 'package:prosoft_task/api/product/product_client.dart';
import 'package:prosoft_task/api/product/product_repository.dart';
import 'package:prosoft_task/api/storage.dart';
import 'package:prosoft_task/api/task/task_repository.dart';
import 'package:prosoft_task/api/task/tasks_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prosoft_task/app/app.dart';
import 'package:prosoft_task/app/app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.manual,
  //   overlays: [],
  // );

  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  Bloc.observer = const AppBlocObserver();

  final plugin = await SharedPreferences.getInstance();

  final tasksRepository = TaskRepository(
    client: TaskClient(),
    storage: Storage(plugin: plugin),
  );

  final authenticationRepository = AuthenticationRepository(
    client: AuthenticationClient(),
    plugin: plugin,
  );

  final categoryRepository = CategoryRepository(
    client: CategoryClient(),
    storage: Storage(plugin: plugin),
  );

  final productRepository = ProductRepository(
    client: ProductClient(),
    storage: Storage(plugin: plugin),
  );

  final token = await authenticationRepository.checkLoggedIn();

  runApp(App(
    tasksRepository: tasksRepository,
    authenticationRepository: authenticationRepository,
    categoryRepository: categoryRepository,
    productRepository: productRepository,
    token: token,
  ));
}
