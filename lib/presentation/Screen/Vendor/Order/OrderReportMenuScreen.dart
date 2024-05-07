import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/NewOrder/NewOrderScreen.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/Complete%20Orders/CompleteOrdersScreen.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/ProcessingOrders/ProcessingOrderScreen.dart';

class OrderReportMenuScreen extends StatelessWidget {
  List<String> reportMenus = [
    'New Orders',
    'Processing Orders',
    'Completed Orders',
    'Total Orders'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Get.width,
              height: Get.height - 300,
              color: Colors.white,
              child: ListView.builder(
                itemCount: reportMenus.length,
                itemBuilder: (context, int index) {
                  String title = reportMenus[index];
                  return Card(
                    color: Colors.white,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    borderOnForeground: true,
                    elevation: 0,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ListTile(
                      focusColor: Colors.amber,
                      hoverColor: Colors.deepOrange,
                      leading: Icon(Icons.reorder),
                      title: Text(
                        title,
                        textScaleFactor: 1,
                      ),
                      //trailing: Icon(Icons.done),
                      // subtitle: Text('This is subtitle'),
                      selected: false,
                      onTap: () {
                        print('Click on Menu ' + title);
                        if (index == 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewOrderScreen()));
                        } else if (index == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProcessingOrderScreen()));
                        } else if (index == 2) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompleteOrdersScreen()));
                        } else if (index == 3) {
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompleteOrdersScreen()));
                        }
                        //
                      },
                    ),
                  );
                },
              ),
            ),
            // Text('hello',textScaleFactor: 2,)
          ),
        ],
      ),
    );
  }
}
