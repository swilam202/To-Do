import 'package:get/get.dart';
import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  RxList<Task> taskList = <Task>[].obs;

  addTask(Task task) async {
    await DBHelper.insert(task);
    getTask();
  }

  deleteTask(int id) async {
    await DBHelper.delete(id);
    getTask();
  }

  deleteAllTask() async {
    await DBHelper.deleteAll();
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
