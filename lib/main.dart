import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/controllers/task_controller.dart';

import 'db/db_helper.dart';
import 'services/notification_services.dart';
import 'services/theme_services.dart';
import 'ui/pages/add_task_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/notification_screen.dart';
import 'ui/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
GetStorage.init();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeServices().mode,
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
