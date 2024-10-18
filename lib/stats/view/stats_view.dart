import 'package:flutter/material.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final state = context.watch<StatsBloc>().state;
    // final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              key: Key('statsView_completedTasks_listTile'),
              leading: Icon(Icons.check_rounded),
              title: Text('Completed tasks'),
              trailing: Text(
                '0',
                // style: textTheme.headlineSmall,
              ),
            ),
            ListTile(
              key: Key('statsView_activeTasks_listTile'),
              leading: Icon(Icons.radio_button_unchecked_rounded),
              title: Text('Active tasks'),
              trailing: Text(
                '0',
                // style: textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
