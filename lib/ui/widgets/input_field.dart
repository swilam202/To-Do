import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: titleStyle,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 2.5)),
          child: TextFormField(
            controller: controller,
            readOnly: widget != null ? true : false,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: subTitleStyle,
              suffixIcon: widget ?? SizedBox(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
