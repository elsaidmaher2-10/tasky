import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constant/storage_keys.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/model/task_model.dart';

class Taskscontroller extends ChangeNotifier {
  Taskscontroller() {
    init();
  }
  List<TaskModel> todotasks = [];
  List<TaskModel> finaltasks = [];
  Future<void> onDelete(id) async {
    finaltasks.removeWhere((e) => e.id == id);
    final tasks = finaltasks.map((e) {
      return e.toJson();
    }).toList();

    PrefrenceManager().setstring(StorageKeys.task, jsonEncode(tasks));

    notifyListeners();
  }

  changestate(bool? value, int? index) {
    int currentindex = finaltasks.indexWhere((e) {
      return e.id == todotasks[index!].id;
    });

    todotasks[index!].ischecked = value;
    finaltasks[currentindex].ischecked = todotasks[index].ischecked;

    PrefrenceManager().setstring(
      StorageKeys.task,
      jsonEncode(finaltasks.map((e) => e.toJson()).toList()),
    );

    loadtasks();
  }

  loadtasks() async {
    String? tasks = PrefrenceManager().getstring(StorageKeys.task);
    if (tasks != null) {
      final tasksDecoded = jsonDecode(tasks) as List;
      finaltasks = tasksDecoded.map((e) => TaskModel.fromJson(e)).toList();

      todotasks = finaltasks.where((e) {
        return e.ischecked == false;
      }).toList();
    } else {
      todotasks = [];

      finaltasks = [];
    }

    notifyListeners();
  }

  init() {
    loadtasks();
  }
}
