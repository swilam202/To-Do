import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, required this.passedata}) : super(key: key);
  String passedata;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode? Themes.darkTheme.primaryColor:Themes.lightTheme.primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          widget.passedata.split('|')[0],
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Get.isDarkMode?Colors.black:Colors.teal,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Hello Mahmoud',
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'You have a new task!',
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                margin:
                    EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color:  Get.isDarkMode ? Themes.darkTheme.canvasColor:Themes.lightTheme.canvasColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.title,
                            size: 40,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.passedata.split('|')[1],
                            style: TextStyle(
                              fontSize: 30,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            size: 40,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.passedata.split('|')[2],
                            style: TextStyle(
                              fontSize: 30,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 40,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.passedata.split('|')[3],
                            style: TextStyle(
                              fontSize: 30,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
