import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {



  // DateTime selectedDate = DateTime.now();
  // String startDate = DateFormat('hh:mm a').format(DateTime.now());
  // String endDate = DateFormat('hh:mm a')
  //     .format(DateTime.now().add(const Duration(minutes: 20)));
  // int selectedRemind = 5;
  // List<int> remindList = [5, 10, 15, 20];
  // String selectedRepeat = 'None';
  // List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  // int selectedColor = 0;

    RxList<Task> taskList = <Task>[
    // Task(
    //   title: 'sfas',
    //   note: 'sasdf0',
    //   isCompleted: 0,
    //   date: '20:10',
    //   startTime: '10:15',
    //   endTime: '3:1',
    //   color: 1,
    //   repeat: 'None',
    //   remind: 5,
    // ),
  ].obs;


  addTask(Task task) async{
    await DBHelper.insert(task);
    getTask();
  }

  deleteTask(int id) async {
    await DBHelper.delete(id);
    getTask();
  }

  getTask() async {
    final List tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());

  }

  void updateTask(int id) async {
    await DBHelper.update(id);
    getTask();
  }
}
