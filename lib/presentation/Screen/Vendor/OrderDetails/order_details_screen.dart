import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_vendor_admin/data/model/order_details.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/OrderDetails/Controller/order_details_controller.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';

import '../../../utils/AppColors.dart';
import '../../../utils/AppSpaces.dart';

class OrderDetailsProductListScreen extends StatelessWidget {
  OrderDetailsProductListScreen({Key? key}) : super(key: key);
  int? orderId;

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsProductListController());

    orderId = Get.arguments;

    OrderDetailsProductListController.to.orderedProductListDetails.value =
        OrderedProductListDetailsModel();

    OrderDetailsProductListController.to.getOrderDetails(orderId: orderId);

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Order Id: ${orderId}",
              style: Get.textTheme.headline5!.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: Container(),
            actions: [
              InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.clear,
                  color: AppColors.black,
                ),
              ),
              AppSpaces.spaces_width_15,
            ],
          ),
          _ordered_products(),
        ],
      ),
    ));
  }

  _ordered_products() {
    return Obx(() {
      printInfo(
          info:
              "OrderDetailsProductListController.to.orderedProductListDetails.value :::: ${OrderDetailsProductListController.to.orderedProductListDetails.value.productDetails}");
      if (OrderDetailsProductListController
              .to.orderedProductListDetails.value.productDetails !=
          null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 10),
              child: Text(
                "Ordered Products",
                style: Get.textTheme.headline6!.copyWith(color: AppColors.black),
              ),
            ),
            Divider(),
            AppSpaces.spaces_height_15,
            Table(
              border: TableBorder.all(color: Colors.transparent),
              children: [
                TableRow(children: [
                  Center(child: Text('Product Name')),
                  Center(child: Text('Quantity')),
                  Center(child: Text('Price')),
                ]),
              ],
            ),
            Table(
              border: TableBorder.all(color: Colors.transparent),
              children: OrderDetailsProductListController
                  .to.orderedProductListDetails.value.message!.orderDetails!
                  .map((e) => TableRow(children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${OrderDetailsProductListController.to.orderedProductListDetails.value.productDetails!.where((element) => element.productNameId == e.productNameId).first.productName}'),
                        )),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${e.quantity}'),
                        )),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '\$${e.quantity! * double.parse(e.amount.toString())} '),
                        )),
                      ]))
                  .toList(),
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Total : ",
                  style: Get.textTheme.bodyText1,
                ),
                Text(
                    "\$${OrderDetailsProductListController.to.priceCalculation()} ",
                    style: Get.textTheme.bodyText1),
                AppSpaces.spaces_width_25,
              ],
            ),
            AppSpaces.spaces_height_30,
          ],
        );
      } else {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                top: (Get.height - Get.statusBarHeight) / 2 - 15),
            child: AppLoading(),
          ),
        );
      }
    });
  }
}
