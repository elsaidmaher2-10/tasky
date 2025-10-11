import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/core/component/task_list_widget.dart';

class HighperiortyScreen extends StatefulWidget {
  const HighperiortyScreen({super.key});

  @override
  State<HighperiortyScreen> createState() => _HighperiortyScreenState();
}

class _HighperiortyScreenState extends State<HighperiortyScreen> {
  List<TaskModel> highperiortytasks = [];
  List<TaskModel> finaltasks = [];
  @override
  void initState() {
    _load_tasks();

    super.initState();
  }

  _load_tasks() async {
    String? tasks = PrefrenceManager().getstring("task");
    if (tasks != null) {
      setState(() {
        final tasksDecoded = jsonDecode(tasks) as List;
        finaltasks = tasksDecoded.map((e) => TaskModel.fromJson(e)).toList();

        highperiortytasks = finaltasks.where((e) {
          return e.isHighPeriorty == true;
        }).toList();
      });
    } else {
      highperiortytasks = [];

      finaltasks = [];
    }
  }

  Future<void> onDelete(id) async {
    setState(() {
      finaltasks.removeWhere((e) => e.id == id);
      finaltasks = finaltasks.where((e) {
        return e.id == id;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskListWidget(
          tasks: highperiortytasks,
          ontap: (value, index) async {
            int currentindex = finaltasks.indexWhere((e) {
              return e.id == highperiortytasks[index!].id;
            });

            setState(() {
              highperiortytasks[index!].ischecked = value;
              finaltasks[currentindex].ischecked =
                  highperiortytasks[index].ischecked;
            });

            PrefrenceManager().setstring(
              "task",
              jsonEncode(finaltasks.map((e) => e.toJson()).toList()),
            );

            _load_tasks();
          },
          onDelete: (int p1) {
            onDelete(p1);
          },
          onedit: () {
            _load_tasks();
          },
        ),
      ),
    );
  }
}
