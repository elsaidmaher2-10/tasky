import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constant/storage_keys.dart';
import 'package:tasky/core/services/FileStroageManger.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/model/task_model.dart';

class Taskscontroller extends ChangeNotifier {
  Taskscontroller() {
    init();
  }
  List<TaskModel> todotasks = [];
  List<TaskModel> alltasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> highprioritytask = [];

  init() {
    loadtasks();
    loadcompletetasks();
    loadhighpriortytasks();
  }

  loadcompletetasks() async {
    final tasks = await FileStroageManager().loadtaks();
    if (tasks.isNotEmpty) {
      alltasks = tasks.map((e) => TaskModel.fromJson(e)).toList();

      completeTasks = alltasks.where((e) {
        return e.ischecked == true;
      }).toList();
    } else {
      completeTasks = [];

      alltasks = [];
    }
    notifyListeners();
  }

  loadtasks() async {
    final tasks = await FileStroageManager().loadtaks();
    if (tasks.isNotEmpty) {
      alltasks = tasks.map((e) => TaskModel.fromJson(e)).toList();

      todotasks = alltasks.where((e) {
        return e.ischecked == false;
      }).toList();
    } else {
      todotasks = [];

      alltasks = [];
    }

    notifyListeners();
  }

  loadhighpriortytasks() async {
    final tasks = await FileStroageManager().loadtaks();
    if (tasks.isNotEmpty) {
      alltasks = tasks.map((e) => TaskModel.fromJson(e)).toList();

      highprioritytask = alltasks.where((e) {
        return e.isHighPeriorty == true;
      }).toList();
    } else {
      highprioritytask = [];
      alltasks = [];
    }

    notifyListeners();
  }

  Future<void> onDelete(id) async {
    alltasks.removeWhere((e) => e.id == id);
    final tasks = alltasks.map((e) {
      return e.toJson();
    }).toList();
    FileStroageManager().saveTasks(tasks);

    notifyListeners();
  }

  changetodostate(bool? value, int? index) {
    int currentindex = alltasks.indexWhere((e) {
      return e.id == todotasks[index!].id;
    });

    todotasks[index!].ischecked = value;
    alltasks[currentindex].ischecked = todotasks[index].ischecked;
    FileStroageManager().saveTasks(alltasks.map((e) => e.toJson()).toList());

    loadtasks();
  }

  changecompletetate(bool? value, int? index) {
    int currentindex = alltasks.indexWhere((e) {
      return e.id == completeTasks[index!].id;
    });

    completeTasks[index!].ischecked = value;

    alltasks[currentindex].ischecked = completeTasks[index].ischecked;

    FileStroageManager().saveTasks(alltasks.map((e) => e.toJson()).toList());

    loadcompletetasks();
  }

  changehighpriortyetate(bool? value, int? index) {
    int currentindex = alltasks.indexWhere((e) {
      return e.id == highprioritytask[index!].id;
    });

    highprioritytask[index!].ischecked = value;
    alltasks[currentindex].ischecked = highprioritytask[index].ischecked;

    FileStroageManager().saveTasks(alltasks.map((e) => e.toJson()).toList());

    loadhighpriortytasks();
    notifyListeners();
  }
}
