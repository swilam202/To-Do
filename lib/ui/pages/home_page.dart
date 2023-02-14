import 'dart:io';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';
import 'package:todoapp/ui/widgets/button.dart';
import 'package:get/get.dart';

import 'add_task_page.dart';

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
            notifyHelper.displyNotifcation(title: '', body: 'Theme Changed');
            notifyHelper.sechduleNotification();

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
            ),
            Expanded(
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
                      width: SizeConfig.orientation == Orientation.portrait
                          ? 200
                          : 50,
                      height: SizeConfig.orientation == Orientation.portrait
                          ? 200
                          : 50,
                    ),
                    Text(
                      'No tasks for today!',
                      style: headingStyle,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
