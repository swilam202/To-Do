import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'services/theme_services.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/notification_screen.dart';
import 'ui/theme.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeServices().mode,
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}