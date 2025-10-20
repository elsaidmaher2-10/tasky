import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Feature/Home/component/highprepiortywidget.dart';
import 'package:tasky/Feature/Home/home_controller/homeController.dart';
import 'package:tasky/core/constant/storage_keys.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/Feature/addTask/add_task.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/Feature/Home/component/archived_task.dart';
import 'package:tasky/core/component/task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Homecontroller()..init(),
      builder: (context, child) {
        return Consumer<Homecontroller>(
          builder: (BuildContext context, Homecontroller value, Widget? child) {
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
                    value.loadTasks();
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
                                      image: value.selectedimage == null
                                          ? AssetImage(
                                              "assets/images/image.png",
                                            )
                                          : FileImage(value.selectedimage!),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Good Evening, ${value.name ?? 'Guest'}",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                      Text(
                                        value.mvQoute,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall,
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayLarge,
                                  ),
                                  Image(
                                    image: AssetImage(
                                      "assets/images/waving_hand.png",
                                    ),
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
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: archived_task(),
                              ),
                              const SizedBox(height: 8),

                              Highprepiortywidget(
                                ontap: (p1, p2) async {
                                  await value.donetask(p2, p1);
                                },
                                tasks: value.high_preiorty_tasks,
                                refresh: () {
                                  value.loadTasks();
                                },
                              ),
                              const SizedBox(height: 24),

                              Text(
                                "My Tasks",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),

                              const SizedBox(height: 16),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 65.0),
                                child: TaskListWidget(
                                  tasks: value.task,
                                  ontap: (value, index) async {
                                    context
                                            .read<Homecontroller>()
                                            .task[index!]
                                            .ischecked =
                                        value;
                                    context
                                        .read<Homecontroller>()
                                        .numberofcompeletedTask();

                                    PrefrenceManager().setstring(
                                      StorageKeys.task,
                                      jsonEncode(
                                        context
                                            .read<Homecontroller>()
                                            .task
                                            .map((e) => e.toJson())
                                            .toList(),
                                      ),
                                    );
                                  },
                                  onDelete: (int p1) {
                                    context.read<Homecontroller>().onDelete(p1);
                                    context
                                        .read<Homecontroller>()
                                        .numberofcompeletedTask();
                                    context.read<Homecontroller>().loadTasks();
                                  },
                                  onedit: () {
                                    context.read<Homecontroller>().loadTasks();
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
          },
        );
      },
    );
  }
}
