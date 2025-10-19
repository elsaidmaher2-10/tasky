import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/enum/item_action_enum.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/core/theme/themecontroller.dart';
import 'package:tasky/core/widgets/customCheckBox.dart';
import 'package:tasky/core/widgets/custom_form_field.dart';
import 'package:tasky/model/task_model.dart';

// ignore: must_be_immutable
class TaskListWidget extends StatefulWidget {
  TaskListWidget({
    super.key,
    required this.tasks,
    required this.ontap,
    required this.onDelete,
    required this.onedit,
  });
  List<TaskModel> tasks;
  Function(bool?, int?) ontap;
  Function(int) onDelete;
  Function() onedit;
  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.tasks.length,
      itemBuilder: (ctx, index) {
        return Container(
          padding: EdgeInsets.all(8),
          height: 72,
          decoration: BoxDecoration(
            border: Border.all(
              color: Themecontroller.isDark()
                  ? Colors.transparent
                  : Color(0xffD1DAD6),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCheckBox(
                value: widget.tasks[index].ischecked ?? false,
                onChanged: (value) {
                  widget.ontap(value, index);
                },
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      widget.tasks[index].taskname,
                      style: widget.tasks[index].ischecked == true
                          ? Theme.of(context).textTheme.headlineSmall
                          : Theme.of(context).textTheme.headlineMedium,
                    ),
                    widget.tasks[index].ischecked! ||
                            widget.tasks[index].taskdescription.isEmpty
                        ? SizedBox.shrink()
                        : Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.tasks[index].taskdescription,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                  ],
                ),
              ),

              PopupMenuButton<ItemActionEnum>(
                onSelected: (value) async {
                  switch (value) {
                    case ItemActionEnum.edit:
                      {
                        await showmodalbottomsheet(
                          context,
                          widget.tasks[index],
                        );

                        widget.onedit();
                      }
                    case ItemActionEnum.delete:
                      {
                        final result = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete Task"),
                              content: Text("Are You Sure To Delete Task"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: WidgetStatePropertyAll(
                                      Colors.red,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                    widget.onDelete(widget.tasks[index].id);
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            );
                          },
                        ); //

                        // widget.onDelete(widget.tasks[index].id);
                        print(result);
                      }
                    case ItemActionEnum.markAsDone:
                      {
                        widget.ontap(!(widget.tasks[index].ischecked!), index);
                      }
                  }
                },
                itemBuilder: (context) => ItemActionEnum.values.map((e) {
                  return PopupMenuItem(value: e, child: Text(e.name));
                }).toList(),
              ),

              // IconButton(
              //   onPressed: () {},
              //   icon: SvgPicture.asset(
              //     "assets/images/menu.svg",
              //     colorFilter: ColorFilter.mode(
              //       widget.tasks[index].ischecked == true
              //           ? Color(
              //               Theme.of(
              //                 context,
              //               ).textTheme.headlineSmall!.color!.value,
              //             )
              //           : Color(
              //               Theme.of(
              //                 context,
              //               ).textTheme.titleSmall!.color!.value,
              //             ),
              //       BlendMode.srcIn,
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 4);
      },
    );
  }

  Future showmodalbottomsheet(BuildContext context, TaskModel task) {
    GlobalKey<FormState> globalKey = GlobalKey();
    TextEditingController tasknamecontroller = TextEditingController(
      text: task.taskname,
    );
    TextEditingController taskdesccontroller = TextEditingController(
      text: task.taskdescription,
    );
    return showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Task Name",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 8),
                            CustomFormField(
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return "Please Enetr TaskName";
                                }
                                return null;
                              },
                              controller: tasknamecontroller,
                              hinttext: 'Finish UI design for login screen',
                            ),

                            SizedBox(height: 16),

                            Text(
                              "Task Description",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 8),
                            CustomFormField(
                              maxLines: 5,

                              controller: taskdesccontroller,

                              hinttext:
                                  "Finish onboarding UI and hand off to devs by Thursday.",
                            ),
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "High Priority  ",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),
                                Switch(
                                  value: task.isHighPeriorty,
                                  onChanged: (value) {
                                    setState(() {
                                      task.isHighPeriorty = value;
                                    });
                                  },
                                  activeTrackColor: Color(0xff15B86C),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(3430, 40),
                        backgroundColor: Color(0xff15B86C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: Color(0xffFFFCFC),
                      ),
                      onPressed: () async {
                        if (globalKey.currentState?.validate() ?? false) {
                          List tasks = [];

                          final listTasks = PrefrenceManager().getstring(
                            "task",
                          );

                          if (listTasks != null) {
                            tasks = jsonDecode(listTasks);
                          }
                          final updatedtask = TaskModel(
                            ischecked: task.ischecked,
                            id: tasks.length,
                            taskname: tasknamecontroller.text,
                            taskdescription: taskdesccontroller.text,
                            isHighPeriorty: task.isHighPeriorty,
                          );

                          int index = tasks.indexWhere((e) {
                            return e["id"] == task.id;
                          });

                          tasks[index] = updatedtask.toJson();
                          final taskencode = jsonEncode(tasks);

                          PrefrenceManager().setstring("task", taskencode);
                          Navigator.pop(context);
                        }
                      },
                      label: Text(
                        "Edit Task",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      icon: Icon(Icons.add),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
