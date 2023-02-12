import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/ui/theme.dart';
import 'package:todoapp/ui/widgets/button.dart';
import 'package:todoapp/ui/widgets/input_field.dart';

import '../../controllers/task_controller.dart';

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
                hint: selectedDate.toString(),
                widget: Icon(Icons.calendar_today_rounded),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      label: 'Start Date',
                      hint: startDate,
                      widget: Icon(Icons.access_time),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InputField(
                      label: 'End Date',
                      hint: endDate,
                      widget: Icon(Icons.access_time),
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
                            style: TextStyle(),
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
                  MyButton(),
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
}
