
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Feature/Tasks/taskscontroller.dart';
import 'package:tasky/core/component/task_list_widget.dart';


class CompleteScreen extends StatelessWidget {
  const CompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Taskscontroller(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<Taskscontroller>(
            builder:
                (BuildContext context, Taskscontroller value, Widget? child) {
                  return TaskListWidget(
                    tasks: value.completeTasks,
                    ontap: (value, index) async {
                      context.read<Taskscontroller>().changecompletetate(
                        value,
                        index,
                      );
                    },
                    onDelete: (int p1) {
                      context.read<Taskscontroller>().onDelete(p1);
                      context.read<Taskscontroller>().loadcompletetasks();
                    },
                    onedit: () {
                      context.read<Taskscontroller>().loadcompletetasks();
                    },
                  );
                },
          ),
        ),
        appBar: AppBar(title: Text("Complete tasks")),
      ),
    );
  }
}
