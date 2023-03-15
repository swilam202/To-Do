import 'package:flutter/material.dart';
import 'package:todoapp/ui/theme.dart';
import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task, {Key? key}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: task.color == 0
              ? Colors.red
              : task.color == 1
                  ? Colors.green
                  : Colors.blue),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    task.title!,
                    style: headingStyle.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      Text(
                        task.startTime!,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        task.endTime!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    task.note!,
                    overflow: TextOverflow.clip,
                    style: subTitleStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 160,
            width: 0.5,
            color: Colors.white,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted == 0 ? 'To be done' : 'Completed',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
