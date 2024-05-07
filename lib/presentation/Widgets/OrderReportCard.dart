import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin/data/model/new_order_model.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';

Widget OrderReportCard({required Orders anOrder}) {
  return Card(
      child: Container(
    color: Colors.grey[100],
    padding: EdgeInsets.all(10),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            // Text( anOrder.paymentType == 1 ? 'Payment Type\n Cash on Delivery':'Payment Type\n Card',
            Text(
              'Payment Type\n Cash on Delivery',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            // Text(anOrder.orderDateTime == null ? '':anOrder.orderDateTime)
          ],
        ),
        Row(
          children: <Widget>[
            Text(
                'Order Amount: ${anOrder.totalAmount}\n Discount: ${anOrder.discount}')
          ],
        ),
        Row(
          children: <Widget>[Text('Paid By cash/Card')],
        ),
        Row(
          children: <Widget>[
            Text(
                'Delivery By ${anOrder.deliveryman.name},${anOrder.deliveryman.address},${anOrder.deliveryman.phone},'),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
                'Delivery To: ${anOrder.customer.name},${anOrder.customer.phone},'),
          ],
        ),
        Row(
          children: <Widget>[
            Text('Address: ${anOrder.customer.address}'),
          ],
        ),
      ],
    ),
  ));
}
