import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tasky/Feature/Home/component/highprepiortywidget.dart';
import 'package:tasky/core/constant/storage_keys.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/Feature/addTask/add_task.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/Feature/Home/component/archived_task.dart';
import 'package:tasky/core/component/task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];
  List<TaskModel> completetasks = [];
  List<TaskModel> high_preiorty_tasks = [];
  String? name;
  String mvQoute = "One task at a time. One step closer.";
  double precetage = 0;
  File? selectedimage;

  @override
  void initState() {
    super.initState();
    _loadusername();
    _loadMotivationQuote();
    _loadTasks();
  }

  Future<void> _loadusername() async {
    setState(() {
      name = PrefrenceManager().getstring(StorageKeys.username);
      String? imagePath = PrefrenceManager().getstring("imageprofile");
      if (imagePath != null) {
        selectedimage = File(imagePath);
      }
    });
  }

  Future<void> _loadMotivationQuote() async {
    setState(() {
      mvQoute =
          PrefrenceManager().getstring("mvQoute") ??
          "One task at a time. One step closer.";
    });
  }

  void _numberofcompeletedTask() {
    setState(() {
      completetasks = tasks.where((e) => e.ischecked == true).toList();
      if (tasks.isEmpty) {
        precetage = 0;
      } else {
        precetage = (completetasks.length / tasks.length) * 100;
      }
    });
  }

  Future<void> _loadTasks() async {
    final listTasks = PrefrenceManager().getstring("task");
    if (listTasks != null) {
      final decodedTasks = jsonDecode(listTasks) as List;
      setState(() {
        tasks = decodedTasks.map((e) => TaskModel.fromJson(e)).toList();
        high_preiorty_tasks = tasks.where((e) {
          return e.isHighPeriorty == true;
        }).toList();
      });
      _numberofcompeletedTask();
    }
  }

  Future<void> onDelete(id) async {
    setState(() {
      tasks.removeWhere((e) => e.id == id);
      final tasksdecode = tasks.map((e) {
        return e.toJson();
      }).toList();

      PrefrenceManager().setstring("task", jsonEncode(tasksdecode));
    });
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 167,
        height: 40,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          icon: const Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff15B86C),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => const AddTask()),
            );
            _loadTasks();
          },
          label: const Text("Add New Task"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            child: Image(
                              image: selectedimage == null
                                  ? AssetImage("assets/images/image.png")
                                  : FileImage(selectedimage!),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Evening, ${name ?? 'Guest'}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                mvQoute,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Text(
                        "Yuhuu, Your work is ",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            "almost done! ",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Image(
                            image: AssetImage("assets/images/waving_hand.png"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        height: 72,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: archived_task(
                          completetasks: completetasks,
                          tasks: tasks,
                          precetage: precetage,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Highprepiortywidget(
                        ontap: (p1, p2) async {
                          await _done_task(p2, p1);
                        },
                        tasks: high_preiorty_tasks,
                        refresh: () {
                          _loadTasks();
                        },
                      ),
                      const SizedBox(height: 24),

                      Text(
                        "My Tasks",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      const SizedBox(height: 16),

                      // 📋 Tasks List
                      Padding(
                        padding: const EdgeInsets.only(bottom: 65.0),
                        child: TaskListWidget(
                          tasks: tasks,
                          ontap: (value, index) async {
                            setState(() {
                              tasks[index!].ischecked = value;
                              _numberofcompeletedTask();
                            });
                            PrefrenceManager().setstring(
                              "task",
                              jsonEncode(tasks.map((e) => e.toJson()).toList()),
                            );
                          },
                          onDelete: (int p1) {
                            onDelete(p1);
                            _numberofcompeletedTask();
                          },
                          onedit: () {
                            _loadTasks();
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _done_task(int? p2, bool? p1) async {
    int currentindex = tasks.indexWhere((e) {
      return e.id == high_preiorty_tasks[p2!].id;
    });
    tasks[currentindex].ischecked = p1;
    setState(() {
      _numberofcompeletedTask();
    });

    print(tasks[currentindex].ischecked);

    PrefrenceManager().setstring(
      "task",
      jsonEncode(tasks.map((e) => e.toJson()).toList()),
    );
  }
}
