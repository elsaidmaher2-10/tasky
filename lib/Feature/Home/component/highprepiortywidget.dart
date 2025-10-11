import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/widgets/customCheckBox.dart';
import 'package:tasky/model/task_model.dart';
import 'package:tasky/Feature/Highpriority/highperiorty_screen.dart';

// ignore: must_be_immutable
class Highprepiortywidget extends StatefulWidget {
  Highprepiortywidget({
    super.key,
    required this.ontap,
    required this.refresh,
    required this.tasks,
  });
  Function(bool?, int?) ontap;
  Function refresh;
  List<TaskModel> tasks;
  @override
  State<Highprepiortywidget> createState() => _HighprepiortywidgetState();
}

class _HighprepiortywidgetState extends State<Highprepiortywidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,

        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Text(
              "High Priority Tasks",
              style: TextStyle(
                color: Color(0xff15B86C),
                fontSize: 14,
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
                    SizedBox(
                      height: 208,

                      child: ListView.builder(
                        reverse: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomCheckBox(
                                value: widget.tasks[index].ischecked ?? false,
                                onChanged: (value) {
                                  widget.ontap(value, index);
                                },
                              ),

                              Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  widget.tasks[index].taskname,
                                  style: widget.tasks[index].ischecked == true
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
                        itemCount: widget.tasks.isEmpty
                            ? 0
                            : widget.tasks.length > 4
                            ? 4
                            : widget.tasks.length,
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => HighperiortyScreen()),
                  );
                  widget.refresh();
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: BoxBorder.all(color: Color(0xff6E6E6E), width: 2),
                  ),
                  child: SvgPicture.asset(
                    "assets/images/arrowleft.svg",
                    colorFilter: ColorFilter.mode(
                      Color(
                        Theme.of(context).textTheme.titleSmall!.color!.value,
                      ),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
