import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasky/core/constant/storage_keys.dart';
import 'package:tasky/core/services/FileStroageManger.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/model/task_model.dart';

class Homecontroller extends ChangeNotifier {
  List<TaskModel> task = [];
  List<TaskModel> completetasks = [];
  List<TaskModel> high_preiorty_tasks = [];
  String? name;
  String mvQoute = StorageKeys.mvQoute;
  double precetage = 0;
  File? selectedimage;

  void init() {
    loadTasks();
    loadusername();
    loadMotivationQuote();
    numberofcompeletedTask();
  }

  Future<void> loadusername() async {
    name = PrefrenceManager().getstring(StorageKeys.username);
    String? imagePath = PrefrenceManager().getstring("imageprofile");
    if (imagePath != null) {
      selectedimage = File(imagePath);
    }

    notifyListeners();
  }

  Future<void> loadMotivationQuote() async {
    mvQoute =
        PrefrenceManager().getstring(StorageKeys.kyesQoute) ??
        "One task at a time. One step closer.";
    notifyListeners();
  }

  void numberofcompeletedTask() {
    completetasks = task.where((e) => e.ischecked == true).toList();
    if (task.isEmpty) {
      precetage = 0;
    } else {
      precetage = (completetasks.length / task.length) * 100;
    }
    notifyListeners();
  }

  Future<void> loadTasks() async {
    final listTasks = await FileStroageManager().loadtaks();
    if (listTasks.isNotEmpty) {
      task = listTasks.map((e) => TaskModel.fromJson(e)).toList();
      high_preiorty_tasks = task.where((e) {
        return e.isHighPeriorty == true;
      }).toList();

      numberofcompeletedTask();
    }
    notifyListeners();
  }

  Future<void> onDelete(id) async {
    task.removeWhere((e) => e.id == id);
    final tasksdecode = task.map((e) {
      return e.toJson();
    }).toList();

    FileStroageManager().saveTasks(tasksdecode);
    notifyListeners();
  }

  Future<void> donetask(int? p2, bool? p1) async {
    int currentindex = task.indexWhere((e) {
      return e.id == high_preiorty_tasks[p2!].id;
    });
    task[currentindex].ischecked = p1;

    numberofcompeletedTask();
    FileStroageManager().saveTasks(task.map((e) => e.toJson()).toList());

    notifyListeners();
  }
}
