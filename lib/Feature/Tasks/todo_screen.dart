import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Feature/Tasks/taskscontroller.dart';
import 'package:tasky/core/component/task_list_widget.dart';
import 'package:tasky/core/constant/appsizes.dart';

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
                  padding: EdgeInsets.all(Appsizes.pw16),
                  child: TaskListWidget(
                    tasks: value.todotasks,
                    ontap: (value, index) async {
                      context.read<Taskscontroller>().changetodostate(
                        value,
                        index,
                      );
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
