import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Feature/Home/home_controller/homeController.dart';
import 'package:tasky/core/constant/appsizes.dart';
import 'package:tasky/core/component/customCheckBox.dart';
import 'package:tasky/Feature/Tasks/highperiorty_screen.dart';

class Highprepiortywidget extends StatelessWidget {
  // Function(bool?, int?) ontap;
  // Function refresh;
  // List<TaskModel> tasks;
  // @override

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,

        borderRadius: BorderRadius.circular(Appsizes.r20),
      ),
      child: Consumer<Homecontroller>(
        builder: (BuildContext context, value, Widget? child) {
          final controller = context.read<Homecontroller>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(Appsizes.w8),
                child: Text(
                  "High Priority Tasks",
                  style: TextStyle(
                    color: Color(0xff15B86C),
                    fontSize: Appsizes.fs16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          reverse: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomCheckBox(
                                  value:
                                      value
                                          .high_preiorty_tasks[index]
                                          .ischecked ??
                                      false,
                                  onChanged: (value) {
                                    controller.donetask(index, value);
                                  },
                                ),

                                Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    value.high_preiorty_tasks[index].taskname,
                                    style:
                                        value
                                                .high_preiorty_tasks[index]
                                                .ischecked ==
                                            true
                                        ? Theme.of(
                                            context,
                                          ).textTheme.headlineSmall
                                        : Theme.of(
                                            context,
                                          ).textTheme.headlineMedium,
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: value.high_preiorty_tasks.isEmpty
                              ? 0
                              : value.high_preiorty_tasks.length > 4
                              ? 4
                              : value.high_preiorty_tasks.length,
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => HighperiortyScreen(),
                        ),
                      );
                      controller.loadTasks();
                    },
                    child: Container(
                      margin: EdgeInsets.all(Appsizes.pw8),
                      padding: EdgeInsets.all(Appsizes.pw10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: BoxBorder.all(
                          color: Color(0xff6E6E6E),
                          width: 2,
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/images/arrowleft.svg",
                        colorFilter: ColorFilter.mode(
                          Color(
                            Theme.of(
                              context,
                            ).textTheme.titleSmall!.color!.value,
                          ),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
