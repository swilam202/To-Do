import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/db/db_helper.dart';
import 'package:todoapp/models/task.dart';
import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/task_tile.dart';
import 'add_task_page.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime currentDate = DateTime.now();
  TaskController taskController = Get.put(TaskController());

  /// late NotifyHelper notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///notifyHelper = NotifyHelper();
    ///notifyHelper.initializeNotification();
    ///notifyHelper.requestIOSPermission();

    DBHelper.init();
    taskController.getTask();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.primaryColor,
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
        leading: IconButton(
          color: Get.isDarkMode ? Colors.white : Colors.black,
          icon:
              Icon(Get.isDarkMode ? Icons.nightlight_round_sharp : Icons.sunny),
          onPressed: () {
            ThemeServices().switchTheme();

            ///notifyHelper.displyNotifcation(title: 'title', body: 'theme changed');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              taskController.deleteAllTask();
            },
            icon: Icon(Icons.delete, color: Colors.blue),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: headingStyle,
                ),
                MyButton(fun: () => Get.to(AddTaskPage()), title: 'Add task')
              ],
            ),
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              width: 80,
              height: 100,
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              monthTextStyle: subTitleStyle,
              dayTextStyle: subTitleStyle,
              dateTextStyle: headingStyle,
              onDateChange: (newVal) => setState(() {
                currentDate = newVal;
              }),
            ),
            Expanded(
              child: tasks(),
            ),
          ],
        ),
      ),
    );
  }

  showButtomSheet(Task task) {
    return Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.30
                : SizeConfig.screenHeight * 0.39),
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            task.isCompleted == 0
                ? buttomsheetbutton(
                    label: 'Completed',
                    tab: () {
                      taskController.updateTask(task.id!);
                      Get.back();
                    },
                    colour: Colors.blue)
                : Container(),
            buttomsheetbutton(
                label: 'Delete',
                tab: () {
                  taskController.deleteTask(task.id!);
                  Get.back();
                },
                colour: Colors.red),
            buttomsheetbutton(
                label: 'Cancel', tab: () => Get.back(), colour: Colors.green),
          ],
        ),
      ),
    ));
  }

  buttomsheetbutton(
      {required String label,
      required Function() tab,
      required Color colour,
      bool isColse = false}) {
    return GestureDetector(
      onTap: tab,
      child: Container(
        width: SizeConfig.screenWidth * 0.9,
        height: 65,
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: headingStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  tasks() {
    taskController.getTask();
    return Obx(
      () {
        if (taskController.taskList.isNotEmpty)
          return RefreshIndicator(
            onRefresh: () => taskController.getTask(),
            child: ListView.builder(
              // scrollDirection: SizeConfig.orientation == Orientation.landscape ? Axis.horizontal:Axis.horizontal,
              itemBuilder: (_, index) {
                var task = taskController.taskList[index];
                if (task.date == DateFormat.yMd().format(currentDate) ||
                    task.repeat == 'Daily' ||
                    (task.repeat == 'Weekly' &&
                        currentDate
                                    .difference(
                                        DateFormat.yMd().parse(task.date!))
                                    .inDays %
                                7 ==
                            0) ||
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date!).day ==
                            currentDate.day)) {
                  ///var hours = task.endTime.toString().split(':')[0];
                  ///var minute = task.endTime.toString().split(':')[1].substring(0, 2);
                  /// notifyHelper.scheduledNotification(int.parse(hours), int.parse(minute), task);
                  return AnimationConfiguration.staggeredList(
                    duration: Duration(milliseconds: 500),
                    position: index,
                    child: SlideAnimation(
                      verticalOffset: 500,
                      horizontalOffset: -500,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            showButtomSheet(task);
                          },
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
              itemCount: taskController.taskList.length,
            ),
          );
        else
          return RefreshIndicator(
            onRefresh: () => taskController.getTask(),
            child: SingleChildScrollView(
              child: Wrap(
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'No tasks for today!...',
                    style: headingStyle,
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
