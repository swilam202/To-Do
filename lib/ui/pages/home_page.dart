import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/theme_services.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          onPressed: () {
            ThemeServices().switchTheme();
          },
        ),
      ),
      body: Container(),
    );
  }
}
