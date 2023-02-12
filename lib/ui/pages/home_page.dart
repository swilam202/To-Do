import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/theme_services.dart';
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
  @override
  Widget build(BuildContext context) {
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
          },
        ),
      ),
      body: Center(
        child: OutlinedButton(
          child: Text('add'),
          onPressed: () => Get.to(AddTaskPage()),
        ),
      ),
    );
  }
}
