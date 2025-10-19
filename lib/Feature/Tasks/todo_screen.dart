import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/core/component/task_list_widget.dart';

import '../../core/constant/storage_keys.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TaskModel> todotasks = [];
  List<TaskModel> finaltasks = [];
  Future<void> onDelete(id) async {
    setState(() {
      finaltasks.removeWhere((e) => e.id == id);
      final tasks = finaltasks.map((e) {
        return e.toJson();
      }).toList();

      PrefrenceManager().setstring(StorageKeys.task, jsonEncode(tasks));
    });
  }

  _load_tasks() async {
    String? tasks = PrefrenceManager().getstring(StorageKeys.task);
    if (tasks != null) {
      setState(() {
        final tasksDecoded = jsonDecode(tasks) as List;
        finaltasks = tasksDecoded.map((e) => TaskModel.fromJson(e)).toList();

        todotasks = finaltasks.where((e) {
          return e.ischecked == false;
        }).toList();
      });
    } else {
      todotasks = [];

      finaltasks = [];
    }
  }

  @override
  void initState() {
    _load_tasks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskListWidget(
          tasks: todotasks,
          ontap: (value, index) async {
            int currentindex = finaltasks.indexWhere((e) {
              return e.id == todotasks[index!].id;
            });

            setState(() {
              todotasks[index!].ischecked = value;
              finaltasks[currentindex].ischecked = todotasks[index].ischecked;
            });

            PrefrenceManager().setstring(
              StorageKeys.task,
              jsonEncode(finaltasks.map((e) => e.toJson()).toList()),
            );

            _load_tasks();
          },
          onDelete: (int p1) {
            onDelete(p1);
            _load_tasks();
          },
          onedit: () {
            _load_tasks();
          },
        ),
      ),
      appBar: AppBar(title: Text("To Do tasks")),
    );
  }
}
