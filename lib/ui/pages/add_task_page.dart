import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/db/db_helper.dart';
import 'package:todoapp/ui/theme.dart';
import 'package:todoapp/ui/widgets/button.dart';
import 'package:todoapp/ui/widgets/input_field.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String startDate = DateFormat('hh:mm a').format(DateTime.now());
  String endDate = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 20)));
  int selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int selectedColor = 0;
  DBHelper dbHelper = DBHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.primaryColor,
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('images/person.png'),
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              InputField(
                label: 'Title',
                hint: 'Enter the title here.',
                controller: titleController,
              ),
              InputField(
                label: 'Note',
                hint: 'Enter note  here',
                controller: noteController,
              ),
              InputField(
                label: 'Date',
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_rounded),
                  onPressed: () => selectDate(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      label: 'Start Date',
                      hint: startDate,
                      widget: IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: () => selectStartEndDate(true),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InputField(
                      label: 'End Date',
                      hint: endDate,
                      widget: IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: () => selectStartEndDate(false),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                label: 'Remind',
                hint: '$selectedRemind minutes early',
                widget: DropdownButton(
                  items: remindList
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(
                            '$e',

                          ),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (newVal) => setState(
                      () => selectedRemind = int.parse(newVal.toString())),
                ),
              ),
              InputField(
                label: 'Repeat',
                hint: selectedRepeat,
                widget: DropdownButton(
                  items: repeatList
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (newVal) =>
                      setState(() => selectedRepeat = newVal.toString()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Color'),
                  MyButton(
                    title: 'Add task',
                    fun: () {
                      validateData();
                      _taskController.getTask();
                    }
                  ),
                ],
              ),
              Row(
                children: List.generate(
                  3,
                  (index) => GestureDetector(
                    onTap: () => setState(() => selectedColor = index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CircleAvatar(
                        child: index == selectedColor
                            ? Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 18,
                              )
                            : null,
                        backgroundColor: index == 0
                            ? Colors.red
                            : index == 1
                                ? Colors.blueAccent
                                : Colors.green,
                        radius: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateData() async {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty ) {
      addTaskToDB();
      Get.back();
    }
    else  {
      Get.snackbar('Warning', 'the title, note fields must not be null and make sure Start Date is earlier than End Date',
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.warning_amber,
            color: Colors.red,
          ),
          colorText: Colors.red,
          backgroundColor: Get.isDarkMode ? Colors.black38 : Colors.white70);
    }


  }

  addTaskToDB() async {
    int val = await _taskController.addTask(Task(
      title: titleController.text,
      note: noteController.text,
      isCompleted: 0,
      date: DateFormat.yMd().format(selectedDate),
      endTime: endDate,
      startTime: startDate,
      remind: selectedRemind,
      repeat: selectedRepeat,
      color: selectedColor,
    ),);
  }

  selectDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (date != null) setState(() => selectedDate = date);
  }

  selectStartEndDate(bool isStart) async {
    var date;
    if (isStart)
      date = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(DateTime.now()),);
    else
      date = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
              DateTime.now().add(Duration(minutes: 15),),),);
    String formatted = date.format(context);
    if (isStart)
      setState(() => startDate = formatted);
    else if (!isStart) setState(() => endDate = formatted);
  }
}
