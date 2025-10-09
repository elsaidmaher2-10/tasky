import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/core/widgets/custom_form_field.dart';
import 'package:tasky/model/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController tasknamecontroller = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController taskdesccontroller = TextEditingController();
  bool ishighPreiorty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task"), centerTitle: false),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Form(
          key: _globalKey,
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
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Switch(
                            value: ishighPreiorty,
                            onChanged: (value) {
                              setState(() {
                                ishighPreiorty = value;
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
                  if (_globalKey.currentState?.validate() ?? false) {
                    List tasks = [];

                    final listTasks = PrefrenceManager().getstring("task");

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

                    PrefrenceManager().setstring("task", taskencode);
                    Navigator.pop(context);
                  }
                },
                label: Text(
                  "Add Task",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),

                icon: Icon(Icons.add),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
