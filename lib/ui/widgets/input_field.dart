import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.label,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);
  final String label;
  final TextEditingController? controller;
  final Widget? widget;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20, right: 10, bottom: 5),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            readOnly: widget == null ? true : false,
            decoration: InputDecoration(
              label: Text(label),
              labelStyle: titleStyle,
              hintText: hint,
              hintStyle: subTitleStyle,
              suffixIcon: widget ?? SizedBox(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Get.isDarkMode
                      ? Themes.darkTheme.canvasColor
                      : Themes.lightTheme.canvasColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Get.isDarkMode
                      ? Themes.lightTheme.canvasColor
                      : Themes.darkTheme.canvasColor,
                  width: 0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
