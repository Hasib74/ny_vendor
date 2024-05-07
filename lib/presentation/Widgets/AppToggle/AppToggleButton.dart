import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppToggle/Controller/AppToggleController.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:get/get.dart';

typedef IsActive = Function(bool);

class AppToggleButton extends StatelessWidget {
  IsActive? isActive;
  double width, height, fontSize, toggleSize, borderRadius, padding;

  AppToggleButton(
      {this.isActive,
      this.height = 35,
      this.width = 70,
      this.fontSize = 16,
      this.borderRadius = 45,
      this.padding = 8.0,
      this.toggleSize = 16});

  @override
  Widget build(BuildContext context) {
    Get.put(AppToggleController(), permanent: true);

    return Obx(
      () => FlutterSwitch(
        width: width,
        height: height,
        valueFontSize: fontSize,
        toggleSize: toggleSize,
        value: AppToggleController.to.isActive.value,
        borderRadius: borderRadius,
        padding: padding,
        activeColor: AppColors.green,
        showOnOff: true,
        onToggle: (val) {
          AppToggleController.to.setToggleStatus(val);

          isActive!(val);

          // print("Toggle Value ::: =>  ${val}");
        },
      ),
    );
  }
}
