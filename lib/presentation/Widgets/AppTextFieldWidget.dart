import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

Widget AppTextFieldWidget(
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
    int? maxLines,
    int minLines = 1,
    int? maxLength,
    TextStyle? textStyle,
    TextEditingController? controller,
    bool isDropDown = false,
    Function(String?)? selectedDropDownMenuFn,
    String selectedDropDownMenu = "",
    List<String>? dropDownMenus,
    String? selectedDropDownValue,
    TextInputType textInputType = TextInputType.text}) {
  return Container(
    color: maxLines != null ? fillColor : Colors.transparent,
    height: maxLength != null ? 40 : null,
    margin: EdgeInsets.only(right: maxLength != null ? 16 : 0),
    padding: EdgeInsets.only(
        left: padding_left ?? padding, right: padding_right ?? padding),
    child: Stack(
      children: [
        TextField(
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          enabled: enable,
          keyboardType: textInputType,
          cursorColor: cursorColor,
          style: textStyle ?? TextStyle(color: Colors.black),
          obscureText: false,
          decoration: InputDecoration(
            counterText: "",
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
            border:
                OutlineInputBorder(borderSide: BorderSide(color: border_color)),
          ),
        ),
        isDropDown
            ? Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    Spacer(),
                    Text("${selectedDropDownValue}"),
                    // AppSpaces.spaces_width_5,
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        disabledHint: Container(),
                        isDense: false,
                        items: dropDownMenus!.map((String value) {
                          print("Value ===> ${value}");

                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: Get.textTheme.bodyText1,
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {
                          selectedDropDownMenuFn!(_);
                        },
                        /*   selectedItemBuilder: (context) {
                          return [
                            Text(
                              selectedDropDownValue,
                              style: Get.textTheme.bodyText1,
                            )
                          ];
                        },*/
                      ),
                    ),
                    AppSpaces.spaces_width_5,
                  ],
                ),
              )
            : Container()
      ],
    ),
  );
}
