import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

class AssignToDelivery extends StatelessWidget {
  const AssignToDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Select Delivery Man",style: TextStyle(color: AppColors.black),),
        leading: Container(),
        actions: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close ,color: AppColors.black,)),
          AppSpaces.spaces_width_20
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                backgroundColor: Colors.transparent,
              ),
              title: Text("Alamain Shikder"),
              subtitle: Text("Mirpur, \nCurrent Order(3)"),
            ),
          );
        },
      ),
    );
  }
}
