import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget RectangleButtonWidget(
        {Color fillColor = Colors.white,
        String? assetIcon,
        String? title,
        VoidCallback? onClick,
        double padding = 5,
        double buttonHeight = 80,
        double buttonWidth = 50}) =>
    InkWell(
      onTap: onClick,
      child: Container(
        /* width: buttonWidth,
        height: buttonHeight,*/
        decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                width: 50,
                height: 5,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.deepOrange),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.asset(
                assetIcon ?? "",
                width: 1,
                height: 40,
              ),
              Text(
                '${title}',
                style: TextStyle(color: Colors.deepOrange, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
