import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/api/authentication/i_authentication_repository.dart';
import 'package:prosoft_task/api/category/i_category_repository.dart';
import 'package:prosoft_task/api/product/i_product_repository.dart';
import 'package:prosoft_task/api/task/i_task_repository.dart';
import 'package:prosoft_task/app/bloc/app_bloc.dart';
import 'package:prosoft_task/theme/bloc/theme_bloc.dart';

import 'app_view.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.tasksRepository,
    required this.authenticationRepository,
    required this.productRepository,
    required this.categoryRepository,
    required this.token,
  });

  final ITasksRepository tasksRepository;
  final IAuthenticationRepository authenticationRepository;
  final IProductRepository productRepository;
  final ICategoryRepository categoryRepository;
  final String? token;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ITasksRepository>.value(
          value: tasksRepository,
        ),
        RepositoryProvider<IAuthenticationRepository>.value(
          value: authenticationRepository,
        ),
        RepositoryProvider<IProductRepository>.value(
          value: productRepository,
        ),
        RepositoryProvider<ICategoryRepository>.value(
          value: categoryRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (_) => ThemeBloc()..add(InitialThemeSetEvent()),
          ),
          BlocProvider<AppBloc>(
            create: (_) =>
                AppBloc(authenticationRepository: authenticationRepository)
                  ..add(AppTokenChecked(token ?? '')),
          ),

          // BlocProvider<StatsBloc>(
          //   create: (context) =>
          //       StatsBloc()..add(const StatsSubscriptionRequested()),
          // ),
        ],
        child: const AppView(),
      ),
    );
  }
}
