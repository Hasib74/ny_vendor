import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget RingButtonWidget(
        {String? title, required String iconAsset, double buttonSize = 110}) =>
    Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 60,
            height: 60,
            alignment: Alignment.center,
          ),
          Text(
            '${title}',
            style: TextStyle(color: Colors.deepOrange, fontSize: 15),
          )
        ],
      ),
    );
