import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Feature/Home/home_controller/homeController.dart';

class archived_task extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Homecontroller>(
      builder: (BuildContext context, Homecontroller value, Widget? child) {
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
                  "${value.completetasks.length} out of ${value.task.length} Done",
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
                      value: value.task.isEmpty
                          ? 0
                          : value.completetasks.length / value.task.length,
                      color: Color(0xff15B86C),
                      backgroundColor: Color(0xff6D6D6D),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(4),
                  child: Text(
                    "${value.precetage.toStringAsFixed(1)}%",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
