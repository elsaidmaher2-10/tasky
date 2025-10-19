import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/core/component/task_list_widget.dart';

import '../../core/constant/storage_keys.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  List<TaskModel> completeTasks = [];
  List<TaskModel> finaltasks = [];

  _load_complete_tasks() async {
    String? tasks = PrefrenceManager().getstring(StorageKeys.task);
    if (tasks != null) {
      setState(() {
        final tasksDecoded = jsonDecode(tasks) as List;
        finaltasks = tasksDecoded.map((e) => TaskModel.fromJson(e)).toList();

        completeTasks = finaltasks.where((e) {
          return e.ischecked == true;
        }).toList();
      });
    } else {
      completeTasks = [];

      finaltasks = [];
    }
  }

  Future<void> onDelete(id) async {
    setState(() {
      finaltasks.removeWhere((e) => e.id == id);
      final tasks = finaltasks.map((e) {
        return e.toJson();
      }).toList();

      PrefrenceManager().setstring(StorageKeys.task, jsonEncode(tasks));
    });
  }

  @override
  void initState() {
    _load_complete_tasks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskListWidget(
          tasks: completeTasks,
          ontap: (value, index) async {
            int currentindex = finaltasks.indexWhere((e) {
              return e.id == completeTasks[index!].id;
            });

            setState(() {
              completeTasks[index!].ischecked = value;

              finaltasks[currentindex].ischecked =
                  completeTasks[index].ischecked;
            });

            PrefrenceManager().setstring(
              StorageKeys.task,
              jsonEncode(finaltasks.map((e) => e.toJson()).toList()),
            );

            _load_complete_tasks();
          },
          onDelete: (int p1) {
            onDelete(p1);
            _load_complete_tasks();
          },
          onedit: () {
            _load_complete_tasks();
          },
        ),
      ),
      appBar: AppBar(title: Text("Complete tasks")),
    );
  }
}
