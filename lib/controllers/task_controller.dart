

import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  RxList<Task> taskList = <Task>[].obs;

  addTask(Task task) {
   return DBHelper.insert(task);
  }

  deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTask();
  }

   getTask() async {
    final List tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

 void  updateTask(int id) async {
    await DBHelper.update(id);
    getTask();
  }
}
