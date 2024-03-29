import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'services/theme_services.dart';
import 'ui/pages/home_page.dart';
import 'ui/theme.dart';

void main() async {
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
