import 'package:flutter/material.dart';
import 'package:single_vendor_admin/main.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/SignUp/vendor_sign_up_form.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppBackgroudWidget.dart';
import 'package:single_vendor_admin/presentation/Widgets/IconButtonWidget.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

class VendorSignUp extends StatelessWidget {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return AppBackgroundWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sign_up_text(),
          _account_for(),
          AppSpaces.spaces_height_5,
          _body(),
        ],
      ),
    );
  }

  _sign_up_text() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpaces.spaces_width_10,
        Text(
          language.sign_up,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }

  _account_for() {
    return Column(
      children: [
        Text(
          language.account_for,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        AppSpaces.spaces_height_15,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                IconButtonWidget(
                  isSelected: true,
                  icon: Icons.storefront,
                ),
                AppSpaces.spaces_height_5,
                Text(
                  language.restaurants,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            AppSpaces.spaces_width_5,
            Column(
              children: [
                IconButtonWidget(
                  icon: Icons.directions_car_sharp,
                ),
                AppSpaces.spaces_height_5,
                Text(
                  language.catering,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            AppSpaces.spaces_width_5,
            Column(
              children: [
                IconButtonWidget(
                  icon: Icons.delivery_dining,
                ),
                AppSpaces.spaces_height_5,
                Text(
                  language.grocery,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  _body() {
    return Expanded(child: VendorSignUpForm());
  }
}
