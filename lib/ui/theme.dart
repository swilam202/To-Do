import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    canvasColor: Color.fromRGBO(187, 187, 187, 1.0),
  );
  static final darkTheme = ThemeData(
    primaryColor: Color(0xFF101023),
    brightness: Brightness.dark,
    canvasColor: Color.fromRGBO(93, 92, 92, 1.0),
  );

  TextStyle get headingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black));
  }

  TextStyle get titleStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black));
  }

  TextStyle get subTitleStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Get.isDarkMode ? Colors.white : Colors.black));
  }

  TextStyle get bodyStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Get.isDarkMode ? Colors.white : Colors.black));
  }

  TextStyle get body2Style {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Get.isDarkMode ? Colors.grey[200] : Colors.black));
  }
}
