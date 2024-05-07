import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AppLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 10,
                  blurRadius: 05)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new LoadingIndicator(

            colors: [
              AppColors.orange ,
            ],
            indicatorType: Indicator.lineSpinFadeLoader,
            strokeWidth: 0.1,
          ),
        ));
  }
}
