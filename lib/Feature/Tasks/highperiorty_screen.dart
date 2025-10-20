import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Feature/Tasks/taskscontroller.dart';
import 'package:tasky/core/component/task_list_widget.dart';
import 'package:tasky/core/constant/appsizes.dart';

class HighperiortyScreen extends StatelessWidget {
  const HighperiortyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Taskscontroller(),
      child: Scaffold(
        appBar: AppBar(title: Text("High Priority Tasks")),
        body: Padding(
          padding: EdgeInsets.all(Appsizes.pw16),
          child: Consumer<Taskscontroller>(
            builder:
                (BuildContext context, Taskscontroller value, Widget? child) {
                  final Controller = context.read<Taskscontroller>();
                  return TaskListWidget(
                    tasks: value.highprioritytask,
                    ontap: (value, index) async {
                      Controller.changehighpriortyetate(value, index);
                    },
                    onDelete: (int p1) {
                      Controller.onDelete(p1);
                      Controller.loadhighpriortytasks();
                    },
                    onedit: () {
                      Controller.loadhighpriortytasks();
                    },
                  );
                },
          ),
        ),
      ),
    );
  }
}
