import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Feature/addTask/addtaskController.dart';
import 'package:tasky/core/widgets/custom_form_field.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Addtaskcontroller(),
      builder: (context, child) {
        final Addtaskcontroller addtaskcontroller = context
            .read<Addtaskcontroller>();
        return Scaffold(
          appBar: AppBar(title: Text("New Task"), centerTitle: false),

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Form(
              key: addtaskcontroller.globalKey,
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
                            controller: addtaskcontroller.tasknamecontroller,
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

                            controller: addtaskcontroller.taskdesccontroller,

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
                              Selector<Addtaskcontroller, bool>(
                                builder:
                                    (
                                      BuildContext context,
                                      value,
                                      Widget? child,
                                    ) {
                                      return Switch(
                                        value: value,
                                        onChanged: (values) {
                                          addtaskcontroller.chgswitch(values);
                                        },
                                        activeTrackColor: Color(0xff15B86C),
                                      );
                                    },
                                selector: (BuildContext p1, p2) =>
                                    p2.ishighPreiorty,
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
                      addtaskcontroller.addtask(context);
                    },
                    label: Text(
                      "Add Task",
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
          ),
        );
      },
    );
  }
}
