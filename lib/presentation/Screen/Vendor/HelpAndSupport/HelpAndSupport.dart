
import 'package:flutter/material.dart';
class HelpAndSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Please Call +8801700000',
           style: TextStyle(
             fontSize: 25,
             fontWeight: FontWeight.bold,
             color: Colors.deepOrangeAccent,

           ),
        ),
      ),
    );
  }
}
