import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/api/category/i_category_repository.dart';
import 'package:prosoft_task/api/product/i_product_repository.dart';
import 'package:prosoft_task/api/task/i_task_repository.dart';
import 'package:prosoft_task/home/cubit/home_cubit.dart';
import 'package:prosoft_task/product/bloc/product_bloc.dart';
import 'package:prosoft_task/tasks_overview/bloc/tasks_overview_bloc.dart';

import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
        BlocProvider<TasksOverviewBloc>(
          create: (context) => TasksOverviewBloc(
            // ScrollController(),
            // statsBloc: context.read<StatsBloc>(),
            tasksRepository: context.read<ITasksRepository>(),
          )..add(const TasksOverviewSubscriptionRequested()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(
            productRepository: context.read<IProductRepository>(),
            categoryRepository: context.read<ICategoryRepository>(),
          )..add(const CategoriesSubscriptionRequested()),
        ),
      ],
      child: const HomeView(),
    );
  }
}
