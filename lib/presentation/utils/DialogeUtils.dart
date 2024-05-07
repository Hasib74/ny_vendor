import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/SignUp/user_sign_up.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';

class DialogUtils {
  static String? ShowDialog(BuildContext context) {
    /*
    * This function converts milliseconds to formatted string..
    * @param time: time in milliseconds
    * @return String: Formatted date (ex:jan 20,2020)
    * */

    showDialog(
        context: context,
        builder: (_) {
          return new AlertDialog(
            title: new TextField(
              decoration: InputDecoration(
                  fillColor: AppColors.orange,
                  border: InputBorder.none,
                  hintText: 'Enter a search term'),
            ),
            content: ElevatedButton(
              //  color: AppColors.orange,
              onPressed: () {
                print('click');
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => AuthenticationPage()));
              },
              child: Text('Send', style: TextStyle(fontSize: 20)),
            ),
          );
        });
  }
}
