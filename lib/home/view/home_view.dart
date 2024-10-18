import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/animation/fade_indexed_stack.dart';
import 'package:prosoft_task/edit_task/view/edit_task_page.dart';
import 'package:prosoft_task/home/cubit/home_cubit.dart';
import 'package:prosoft_task/home/widgets/home_tab_button.dart';
import 'package:prosoft_task/product/view/view.dart';
// import 'package:prosoft_task/stats/view/stats_page.dart';
import 'package:prosoft_task/tasks_overview/bloc/tasks_overview_bloc.dart';
import 'package:prosoft_task/tasks_overview/view/tasks_overview_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: FadeIndexedStack(
        index: selectedTab.index,
        children: const [TasksOverviewPage(), ProductPage()],
        // StatsPage(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('homeView_addTask_floatingActionButton'),
        onPressed: () => Navigator.of(context).push(
          EditTaskPage.route(
            tasksOverviewBloc: context.read<TasksOverviewBloc>(),
            initialTask: null,
          ),
        ),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.todos,
              icon: const Icon(Icons.list),
            ),
            // HomeTabButton(
            //   groupValue: selectedTab,
            //   value: HomeTab.stats,
            //   icon: const Icon(Icons.show_chart_rounded),
            // ),
            HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.product,
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
