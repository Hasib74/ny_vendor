import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

Widget AppPasswordTextFieldWidget(
    {Color cursorColor = Colors.black,
      bool obscureText = false,
      IconData? prefixIcon,
      bool filled = true,
      Color fillColor = const Color(0xffd5d5d5),
      String? levelText,
      Color levelColor = const Color(0xffd5d5d5),
      Color border_color = const Color(0xffd5d5d5),
      Color focus_border_color = const Color(0xffd5d5d5),
      Function(String)? onSave,
      double horizontal_pading = 10,
      double vartical_pading = 0,
      String? hint,
      double padding = 16.0,
      double? padding_right,
      double? padding_left,
      double? width,
      double? height,
      bool enable = true,
      TextEditingController? controller,
      TextInputType textInputType = TextInputType.text}) {
  return Container(
    color:  Colors.transparent,
    height:  48,
    padding: EdgeInsets.only(
        left: padding_left ?? padding, right: padding_right ?? padding),
    child: TextField(
      controller: controller,
      enabled: enable,
      keyboardType: textInputType,
      cursorColor: cursorColor,
      style: TextStyle(color: Colors.black),
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          size: 40,
        )
            : null,
        filled: filled,
        fillColor: fillColor,
        labelText: levelText,
        hintText: hint,
        labelStyle: TextStyle(color: levelColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focus_border_color),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: vartical_pading, horizontal: horizontal_pading),
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: border_color)),
        border: OutlineInputBorder(borderSide: BorderSide(color: border_color)),
      ),
    ),
  );
}
