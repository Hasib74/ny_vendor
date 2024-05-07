import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';

import '../../core/map/MapView/map_view.dart';

class OrderItemPickedWidget extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  final customer_name;

  final customer_address;

  final customer_number;

  // final List order_items;

  final total_price;

  final buttonName;

  final orderId;

  VoidCallback? onAccept;

  final date;

  final time;

  final VoidCallback? productListOnTab;


  final LatLng? pickUpLocation;

  OrderItemPickedWidget(


      {this.customer_name = "Hasib Akon",
      this.customer_address = "12/A Kazipara, Mirpur, Dhaka",
      this.customer_number = "+880172712374",
      // this.order_items = const ["1 pis berger", "3 pis poteto", "7 pis cheken"],
      this.buttonName: "Accept",
      this.total_price = 120,
      this.onAccept,
      this.orderId,
      this.productListOnTab,
      this.date,
      this.time ,


      required this.pickUpLocation


      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: Get.width,
        height: 220,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 0.5,
            blurRadius: 0.5,
          )
        ]),
        child: Column(
          children: [
            Expanded(child: _body()),
            AppSpaces.spaces_height_5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ListTile(
                //   leading: Icon(Icons.map),
                //   title: Text("View on Map"),
                //   onTap: () {
                //     Get.to(() => AppMapView());
                //   },
                // ),

                InkWell(
                  onTap: () {
                    Get.to(() => AppMapView(



                   orderAddressLatLng: pickUpLocation,



                    ));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.map),
                      AppSpaces.spaces_width_5,
                      Text(
                        "View on Map",
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: productListOnTab,
                  child: Text(
                    "Product list ->",
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.orange, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            AppSpaces.spaces_height_5,
            _accept_button(),
          ],
        ),
      ),
    );
  }

  _body() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order From",
                          style: Get.textTheme.bodyText1,
                        ),
                        AppSpaces.spaces_height_5,
                        Container(
                          width: 75,
                          height: 1,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        AppSpaces.spaces_height_5,
                        Text(customer_name),
                        AppSpaces.spaces_height_5,
                        Text(customer_number),
                        AppSpaces.spaces_height_5,
                        Text(customer_address),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, right: 16, left: 16, bottom: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Container(
                        height: 80,
                        child: SingleChildScrollView(
                          child: Column(
                            children: order_items
                                .map((e) =>
                                    Text(e, style: Get.textTheme.bodyText2))
                                .toList(),
                          ),
                        ),
                      ),*/

                      Text("Date : ${date.toString()}"),
                      AppSpaces.spaces_height_10,
                      Text("Time : ${time.toString()}"),

                      Expanded(
                        child: Text(
                          "Order Id: ${orderId.toString() ?? "40"}",
                          style: Get.textTheme.headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      /* Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.6),
                      ),*/
                      // AppSpaces.spaces_height_5,
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  _accept_button() {
    return InkWell(
      onTap: onAccept,
      child: SizedBox(
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 1,
              color: AppColors.gray,
            ),
            Spacer(),
            InkWell(
                child: Text(
              "${buttonName}",
              style: Get.textTheme.bodyText2!.copyWith(
                  color: AppColors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
