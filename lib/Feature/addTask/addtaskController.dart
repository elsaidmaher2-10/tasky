import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constant/storage_keys.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/model/task_model.dart';

class Addtaskcontroller extends ChangeNotifier {
  final TextEditingController tasknamecontroller = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController taskdesccontroller = TextEditingController();
  bool ishighPreiorty = true;
  chgswitch(bool value) {
    ishighPreiorty = !ishighPreiorty;
    notifyListeners();
  }

  void addtask(context) {
    if (globalKey.currentState?.validate() ?? false) {
      List tasks = [];

      final listTasks = PrefrenceManager().getstring(StorageKeys.task);

      if (listTasks != null) {
        tasks = jsonDecode(listTasks);
      }
      final Map<String, dynamic> task = TaskModel(
        ischecked: false,
        id: tasks.length,
        taskname: tasknamecontroller.text,
        taskdescription: taskdesccontroller.text,
        isHighPeriorty: ishighPreiorty,
      ).toJson();
      tasks.add(task);

      final taskencode = jsonEncode(tasks);

      PrefrenceManager().setstring(StorageKeys.task, taskencode);
      Navigator.pop(context);
    }
  }
}
