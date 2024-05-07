import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/Screen/AppSetting/About/AboutScreenController.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width ,
      height: Get.height,
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: GetBuilder<AboutScreenController>(builder:(_){

       return  Container(
           child: Column(
               mainAxisAlignment: MainAxisAlignment.center,

             children: <Widget>[
               Text(

                 //  'App Build Version: 1.0.0',
                 (_.appName == null ? _.appName :' ')!,
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.deepOrangeAccent,

                 ),
               ),
               SizedBox(height: 10,),
               Text(
                 //  'App Build Version: 1.0.0',
                 _.appVersion != null ? 'App Version: '+_.appVersion! :'',
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.deepOrangeAccent,

                 ),
               ),
               SizedBox(height: 10,),
               Text(
                 //  'App Build Version: 1.0.0',
                 _.appBuildNumber != null ? 'Build Number: '+_.appBuildNumber! :'',
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.deepOrangeAccent,

                 ),
               ),
             ],
           ),
         );

      }),
    );
  }
}
