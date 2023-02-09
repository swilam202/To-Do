import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  String _key = 'isDarkTheme';
  final GetStorage box = GetStorage();

  saveMode(bool isDarkTheme) => box.write(_key, isDarkTheme);

  loadMode() => box.read<bool>(_key) ?? false;

  ThemeMode get mode => loadMode() ? ThemeMode.dark : ThemeMode.light;

  switchTheme() {
    Get.changeThemeMode(loadMode() ? ThemeMode.light : ThemeMode.dark);
    saveMode(!loadMode());
  }
}
