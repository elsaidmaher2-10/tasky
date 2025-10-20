
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Feature/Tasks/taskscontroller.dart';
import 'package:tasky/core/component/task_list_widget.dart';


class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Taskscontroller(),
      child: Scaffold(
        body: Consumer<Taskscontroller>(
          builder:
              (BuildContext context, Taskscontroller value, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TaskListWidget(
                    tasks: value.todotasks,
                    ontap: (value, index) async {
                      context.read<Taskscontroller>().changestate(value, index);
                    },
                    onDelete: (int p1) {
                      context.read<Taskscontroller>().onDelete(p1);
                      context.read<Taskscontroller>().loadtasks();
                    },
                    onedit: () {
                      context.read<Taskscontroller>().loadtasks();
                    },
                  ),
                );
              },
        ),
        appBar: AppBar(title: Text("To Do tasks")),
      ),
    );
  }
}
