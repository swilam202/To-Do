import 'dart:io';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/models/task.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';
import 'package:todoapp/ui/widgets/button.dart';
import 'package:get/get.dart';

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
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermission();
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
            //  notifyHelper.displyNotifcation(title: '', body: 'Theme Changed');
            // notifyHelper.sechduleNotification();
          },
        ),
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
            ),
            Expanded(
              child: tasks(),
            ),
          ],
        ),
      ),
    );
  }

  Expanded emptyFunction() {
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          direction: SizeConfig.orientation == Orientation.landscape
              ? Axis.horizontal
              : Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(height: 50),
            SvgPicture.asset(
              'images/task.svg',
              color: primaryClr.withOpacity(0.7),
              semanticsLabel: 'Task image',
              width: SizeConfig.orientation == Orientation.portrait ? 200 : 50,
              height: SizeConfig.orientation == Orientation.portrait ? 200 : 50,
            ),
            Text(
              'No tasks for today!',
              style: headingStyle,
            ),
          ],
        ),
      ),
    );
  }

  taskFunction() {
    return ListView.builder(
      itemBuilder: (_, index) {
        return TaskTile(
          Task(
            title: 'title',
            note:
                'iih uehuyewi hu iuyrew eheuewfiuyefwfu whfuweiuyfhefiheuf uyfefgewiuh note jjoflsdjefoi jh uhfiekhf if ',
            isCompleted: 0,
            startTime: '10:10',
            endTime: '20:50',
            color: 0,
          ),
        );
      },
      itemCount: 3,
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
                    label: 'Completed', tab: () {}, colour: Colors.blue)
                : Container(),
            buttomsheetbutton(label: 'Delete', tab: () {}, colour: Colors.red),
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
        )),
      ),
    );
  }

  tasks() {
    if (!taskController.taskList.isEmpty) {
      return ListView.builder(
        // scrollDirection: SizeConfig.orientation == Orientation.landscape ? Axis.horizontal:Axis.horizontal,
        itemBuilder: (_, index) {
          var task = taskController.taskList[index];
          var hours = task.endTime.toString().split(':')[0];
          var minute = task.endTime.toString().split(':')[1];
          notifyHelper.scheduledNotification(
              int.parse(hours), int.parse(minute), task);
          notifyHelper.displyNotifcation(title: '', body: 'Theme ');
          return AnimationConfiguration.staggeredList(
            duration: Duration(seconds: 1),
            position: index,
            child: SlideAnimation(
              verticalOffset: 500,
              horizontalOffset: -500,
              child: FadeInAnimation(
                child: GestureDetector(
                    onTap: () => showButtomSheet(task), child: TaskTile(task)),
              ),
            ),
          );
        },
        itemCount: taskController.taskList.length,
      );
    }
    else {
      return Container();
      // return Expanded(
      //   child: SingleChildScrollView(
      //     child: Wrap(
      //       direction: SizeConfig.orientation == Orientation.landscape
      //           ? Axis.horizontal
      //           : Axis.vertical,
      //       alignment: WrapAlignment.center,
      //       crossAxisAlignment: WrapCrossAlignment.center,
      //       children: [
      //         SizedBox(height: 50),
      //         SvgPicture.asset(
      //           'images/task.svg',
      //           color: primaryClr.withOpacity(0.7),
      //           semanticsLabel: 'Task image',
      //           width:
      //               SizeConfig.orientation == Orientation.portrait ? 200 : 50,
      //           height:
      //               SizeConfig.orientation == Orientation.portrait ? 200 : 50,
      //         ),
      //         Text(
      //           'No tasks for today!',
      //           style: headingStyle,
      //         ),
      //       ],
      //     ),
      //   ),
      // );
    }
  }
}
