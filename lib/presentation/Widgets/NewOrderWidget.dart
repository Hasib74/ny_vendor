import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/data/model/new_order_model.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:get/get.dart';


import '../../main.dart';

Widget NewOrderWidget(
    {
    required Orders anewOrder,
    VoidCallback? accept,
    VoidCallback? decline,
    VoidCallback? details,
    }) {
  return Padding(
    padding: const EdgeInsets.only(left: 0.0, right: 0, bottom: 6),
    child: Container(
      width: Get.width,
      height: 220,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.gray),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 10,
              blurRadius: 10,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: <Widget>[
             Container(
               padding: EdgeInsets.only(top: 5),
               decoration: BoxDecoration(),
               child:  Column(

                 children: <Widget>[

                   Text( anewOrder.paymentType == 1 ? 'Payment Type\n Cash on Delivery':'Payment Type\n Card',
                     style:TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 13,
                       color: Colors.black,
                     ),),
                 ],
               ),
             ),
             Container(
               padding: EdgeInsets.only(top: 10),
               child: Text(
                 ' Order Code: ${anewOrder.orderCode}\n Total Amount: ${anewOrder.totalAmount}\n Discount:${anewOrder.discount}',
                 style:  TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                 ),
             ),

            ],
          ),
          Row(
           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [


              Container(
                width: Get.width / 2 - 5,
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  'Delivery By : \nName: ${anewOrder.deliveryman.name}\nAddress: ${anewOrder.deliveryman.address}\nPhone: ${anewOrder.deliveryman.phone}',
                  style: TextStyle(fontSize: 12,),
                ),
              ),
              Container(
                width: Get.width / 2 - 5,
                padding: EdgeInsets.only(right: 10, top: 5),
                child: Text(
                  'Delivery To : \nName: ${anewOrder.customer.name}\nAddress: ${anewOrder.customer.address}\nPhone: ${anewOrder.customer.phone}',
                  style: TextStyle(fontSize: 12,),
                ),
              ),
              Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               InkWell(
                onTap: accept,
                
                child: Visibility(
                  visible: true,
                  child: Container(

                    decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Processing Done",
                          style: Get.textTheme.bodyText1!.copyWith(
                              color: AppColors.white,
                               fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              InkWell(
                onTap: decline,
                child: Visibility(
                  visible: false,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Decline",
                          style: Get.textTheme.bodyText1!.copyWith(
                              color: AppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: details,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "Details",
                        style: Get.textTheme.bodyText1!.copyWith(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AppSpaces.spaces_bottom_1,
        ],
        
      ),
      
    ),
  );
}
