

import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/NewOrder/OrderDetails/Controller/OrderDetailsController.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:get/get.dart';



class OrderDetailsScreen extends StatelessWidget {

  int? orderId;
  OrderDetailsScreen({Key? key, this.orderId}):super(key: key);

  // In the constructor, require a Todo.
 // DetailScreen({Key? key, required this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Get.put(OrderDetailsController());
    OrderDetailsController.to.getOrderDetails(orderId);
     return Scaffold(
       appBar: AppBar(
         title:Text('New Order Details'),
         backgroundColor: AppColors.orange,
       ),
       body: SafeArea(
        // child: SingleChildScrollView(
           child: Obx(
                 () => Container(
             color:Colors.white,
             width:Get.width,
             height: Get.height,
             //height: Get.height,
             child: OrderDetailsController.to.dataLoading == true?
             Center(
                     child: AppLoading(),
             )
             :
             Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[

                 Obx(() => SingleChildScrollView(
                   child: Container(
                     width: Get.width,
                     margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                     child: OrderDetailsController.to.dataLoading == true ?
                       Center(
                          child: AppLoading(),

                       )

                     :
                     Column(
                       children: <Widget>[
                         Container(
                           padding:EdgeInsets.fromLTRB(15, 8, 00, 00),
                           color: Colors.deepOrange[400],
                           width: Get.width,
                           height: 35,
                           child: Text('New Order Details',
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w800,
                               color: Colors.white,
                             ),),
                         ),
                         Container(
                           width: Get.width,
                           color: Colors.deepOrange[100],
                           padding: EdgeInsets.fromLTRB(15, 7, 10, 5),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Text('Ship To:',
                                 style:TextStyle(
                                   fontWeight: FontWeight.w900,
                                   fontSize: 16,
                                   color: Colors.black,
                                 ),),
                               SizedBox(height: 5,),
                               Text('${OrderDetailsController.to.anOrderDetails.customer.name}',
                                 style:TextStyle(
                                   fontWeight: FontWeight.w900,
                                   fontSize: 12,
                                   color: Colors.black,
                                 ),),
                               SizedBox(height: 3,),
                               Text('${OrderDetailsController.to.anOrderDetails.customer.address}',
                                 style:TextStyle(
                                   fontWeight: FontWeight.w600,
                                   fontSize: 12,
                                   color: Colors.black,
                                 ),),
                               SizedBox(height: 3,),
                               Text('${OrderDetailsController.to.anOrderDetails.customer.email}',
                                 style:TextStyle(
                                   fontWeight: FontWeight.w600,
                                   fontSize: 12,
                                   color: Colors.black,
                                 ),),
                               SizedBox(height: 3,),
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: <Widget>[
                                   Text('${OrderDetailsController.to.anOrderDetails.customer.phone}',
                                     style:TextStyle(
                                       fontWeight: FontWeight.w600,
                                       fontSize: 12,
                                       color: Colors.black,
                                     ),),
                                   SizedBox(width: 100,),
                                   Container(
                                     color: Colors.deepOrange[200],
                                     height: 23,
                                     width: 130,
                                     padding: EdgeInsets.all(0),
                                     child: ElevatedButton(
                                       onPressed: (){},
                                       // elevation: 20,
                                       // splashColor: Colors.cyanAccent,
                                       // color: Colors.deepOrange[400],
                                       child: Text('View Details',
                                         style:TextStyle(
                                           fontWeight: FontWeight.w900,
                                           fontSize: 14,
                                           color: Colors.white,
                                         ),),

                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                         Container(
                           width: Get.width,
                           color: Colors.greenAccent[100],
                           padding: EdgeInsets.fromLTRB(15, 7, 10, 5),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Text('Selected Deliveryman:',
                                     style:TextStyle(
                                       fontWeight: FontWeight.w900,
                                       fontSize: 16,
                                       color: Colors.black,
                                     ),),
                                   SizedBox(height: 5,),
                                   Text('${OrderDetailsController.to.anOrderDetails.deliveryman.name}',
                                     style:TextStyle(
                                       fontWeight: FontWeight.w800,
                                       fontSize: 12,
                                       color: Colors.black,
                                     ),),
                                   SizedBox(height: 3,),
                                   Text('${OrderDetailsController.to.anOrderDetails.deliveryman.phone}',
                                     style:TextStyle(
                                       fontWeight: FontWeight.w600,
                                       fontSize: 12,
                                       color: Colors.black,
                                     ),),
                                   SizedBox(height: 3,),
                                   Text('${OrderDetailsController.to.anOrderDetails.deliveryman.address}',
                                     style:TextStyle(
                                       fontWeight: FontWeight.w600,
                                       fontSize: 12,
                                       color: Colors.black,
                                     ),),
                                   SizedBox(height: 3,),
                                 ],
                               ),
                               // SizedBox(width:40),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.end,
                                 children: <Widget>[
                                   Image.network(OrderDetailsController.to.anOrderDetails.deliveryman.deliverymanPhoto == null ?
                                   'https://images.unsplash.com/photo-1533518463841-d62e1fc91373?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'
                                       : OrderDetailsController.to.anOrderDetails.deliveryman.deliverymanPhoto,
                                     height: 50,
                                     width: 50,
                                     fit: BoxFit.contain,
                                   ),
                                   SizedBox(height: 10,),
                                   Container(
                                     color: Colors.deepOrange[200],
                                     height: 23,
                                     width: 130,
                                     padding: EdgeInsets.all(0),
                                     child: ElevatedButton(
                                       onPressed: (){},
                                       // elevation: 20,
                                       // splashColor: Colors.cyanAccent,
                                       // color: Colors.deepOrange[400],
                                       child: Text('View Profile',
                                         style:TextStyle(
                                           fontWeight: FontWeight.w900,
                                           fontSize: 14,
                                           color: Colors.white,
                                         ),),

                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                         SizedBox(height: 5,),
                         Container(
                           padding:EdgeInsets.fromLTRB(15, 8, 00, 00),
                           color: Colors.deepOrange[400],
                           width: Get.width,
                           height: 35,
                           child: Text('Order Details',
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w800,
                               color: Colors.white,
                             ),),
                         ),
                         Container(
                           decoration: BoxDecoration(
                               border: Border.all(color: Colors.grey[200]!,width:3,)
                           ),
                           child: Column(
                             children: <Widget>[
                               Container(
                                 width: Get.width,
                                 padding: EdgeInsets.fromLTRB(15, 7, 10, 5),

                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                   children: <Widget>[
                                     Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Text('Order Code: ${OrderDetailsController.to.anOrderDetails.orderCode}',
                                           style:TextStyle(
                                             fontWeight: FontWeight.w900,
                                             fontSize: 16,
                                             color: Colors.black,
                                           ),),
                                         SizedBox(height: 5,),
                                         Text('Total Amount: \$${OrderDetailsController.to.anOrderDetails.totalAmount} .',
                                           style:TextStyle(
                                             fontWeight: FontWeight.w800,
                                             fontSize: 12,
                                             color: Colors.red[600],
                                           ),),
                                         SizedBox(height: 3,),
                                         Text('Paid Amount:\$${OrderDetailsController.to.anOrderDetails.paidAmount}.',
                                           style:TextStyle(
                                             fontWeight: FontWeight.w600,
                                             fontSize: 12,
                                             color: Colors.black,
                                           ),),
                                         SizedBox(height: 3,),
                                         Text('Order Time: ${OrderDetailsController.to.anOrderDetails.orderDateTime}',
                                           style:TextStyle(
                                             fontWeight: FontWeight.w600,
                                             fontSize: 12,
                                             color: Colors.black,
                                           ),),
                                         SizedBox(height: 3,),
                                         Text('--------',
                                           style:TextStyle(
                                             fontWeight: FontWeight.w600,
                                             fontSize: 12,
                                             color: Colors.black,
                                           ),),
                                         SizedBox(height: 5,),
                                         Container(
                                           padding: EdgeInsets.fromLTRB(6,3,3,3),
                                           height: 36,
                                           width: 160,
                                           decoration: BoxDecoration(
                                               color: Colors.deepOrange[100],
                                               border: Border.all(color:Colors.deepOrange[300]!,width:2, )
                                           ),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment:CrossAxisAlignment.start,
                                             children: <Widget>[
                                               Text('Home Delivery',
                                                 style:TextStyle(
                                                   fontWeight: FontWeight.w800,
                                                   fontSize: 12,
                                                   color: Colors.black,
                                                 ),),
                                               Text('---',
                                                 style:TextStyle(
                                                   fontWeight: FontWeight.w600,
                                                   fontSize: 10,
                                                   color: Colors.black54,
                                                 ),),
                                             ],
                                           ),
                                         ),
                                         SizedBox(height: 3,),
                                       ],
                                     ),
                                     // SizedBox(width:40),
                                     Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       crossAxisAlignment: CrossAxisAlignment.end,
                                       children: <Widget>[

                                         //SizedBox(height: 60,),
                                         Container(
                                           padding: EdgeInsets.fromLTRB(6,3,3,3),
                                           height: 36,
                                           width: 160,
                                           decoration: BoxDecoration(
                                               color: Colors.deepOrange[100],
                                               border: Border.all(color:Colors.deepOrange[300]!,width:2, )
                                           ),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment:CrossAxisAlignment.start,
                                             children: <Widget>[
                                               Text('Payment Type ',
                                                 style:TextStyle(
                                                   fontWeight: FontWeight.w800,
                                                   fontSize: 12,
                                                   color: Colors.black,
                                                 ),),
                                               Text( OrderDetailsController.to.anOrderDetails.paymentType == 1 ? 'Cash on Delivery':'Card',
                                                 style:TextStyle(
                                                   fontWeight: FontWeight.w600,
                                                   fontSize: 10,
                                                   color: Colors.black54,
                                                 ),),
                                             ],
                                           ),
                                         ),
                                         SizedBox(height: 3,),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                               SizedBox(height: 10,),
                               Container(
                                 padding:EdgeInsets.fromLTRB(15, 00, 200, 00),
                                 margin: EdgeInsets.fromLTRB(15, 0, 13, 0),
                                 color: Colors.deepOrange[100],
                                 width: Get.width,
                                 height:55,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children:<Widget> [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text('Item Cost:',
                                           style:TextStyle(
                                             fontWeight: FontWeight.w800,
                                             fontSize: 12,
                                             color: Colors.black,
                                           ),),
                                         Text('\$48.00',
                                           style:TextStyle(
                                             fontWeight: FontWeight.w800,
                                             fontSize: 12,
                                             color: Colors.black,
                                           ),),
                                       ],
                                     ),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text('Shipping:',
                                           style:TextStyle(
                                             fontWeight: FontWeight.w800,
                                             fontSize: 12,
                                             color: Colors.black,
                                           ),),
                                         Text('\$5.00',
                                           style:TextStyle(
                                             fontWeight: FontWeight.w800,
                                             fontSize: 12,
                                             color: Colors.black,
                                           ),),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                               Container(
                                 padding:EdgeInsets.fromLTRB(15, 5, 200, 15),
                                 margin: EdgeInsets.fromLTRB(15, 0, 13, 0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text('Total Cost:',
                                       style:TextStyle(
                                         fontWeight: FontWeight.w800,
                                         fontSize: 12,
                                         color: Colors.black,
                                       ),),
                                     Text('\$53.00',
                                       style:TextStyle(
                                         fontWeight: FontWeight.w800,
                                         fontSize: 12,
                                         color: Colors.black,
                                       ),),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                         SizedBox(height: 50,),
                         Center(
                           child: Container(
                             margin: EdgeInsets.only(left: 30,right: 30,bottom: 25),
                             color: Colors.deepOrange[200],
                             height: 30,
                             width: Get.width,
                             padding: EdgeInsets.all(0),
                             child: ElevatedButton(
                               onPressed: (){},
                               // elevation: 10,
                               // splashColor: Colors.cyanAccent,
                               // color: Colors.deepOrange[400],
                               child: Text('Proceed to Confirm',
                                 style:TextStyle(
                                   fontWeight: FontWeight.w900,
                                   fontSize: 14,
                                   color: Colors.white,
                                 ),),

                             ),
                           ),

                         ),
                       ],
                     ),
                   ),
                 ) ),

                 Container(
                   color: Colors.deepOrange[400],
                   width: Get.width,
                   height: 15,
                 ),
               ],
             ),
           ),
       )
        // ),
       ),
     );
  }


}