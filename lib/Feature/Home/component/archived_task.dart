import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/model/task_model.dart';

class archived_task extends StatelessWidget {
  const archived_task({
    super.key,
    required this.completetasks,
    required this.tasks,
    required this.precetage,
  });

  final List<TaskModel> completetasks;
  final List<TaskModel> tasks;
  final double precetage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Achieved Tasks",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "${completetasks.length} out of ${tasks.length} Done",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -pi / 2,

              child: SizedBox(
                height: 55,
                width: 55,
                child: CircularProgressIndicator(
                  strokeWidth: 4.5,
                  value: tasks.isEmpty
                      ? 0
                      : completetasks.length / tasks.length,
                  color: Color(0xff15B86C),
                  backgroundColor: Color(0xff6D6D6D),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(4),
              child: Text(
                "${precetage.toStringAsFixed(1)}%",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
