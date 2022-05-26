import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/update-order-status-api.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/delivery-orders.dart';
import 'package:pharmacy_rider_apps/view/orders/order-details-controller.dart';
import '../../../services/order-details.drart.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/accpect-orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class DeliveryOrderDetails extends StatefulWidget {
  final String OrderId;

  DeliveryOrderDetails({required this.OrderId});


  @override
  State<DeliveryOrderDetails> createState() => _DeliveryOrderDetailsState();
}

class _DeliveryOrderDetailsState extends State<DeliveryOrderDetails> {
  var totalAmount;
  var amount;
  var shipping;
  bool _isCancel = false;
  @override
  Widget build(BuildContext context) {
    OrderService _orderService = OrderService();
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Delivery Order Details "),
        backgroundColor: Colors.green,
      ),
      body: _isCancel != true
          ? SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Stack(
            children: [
              orderDetails(OrderId: widget.OrderId),
              Positioned(
                right: 0,
                child: ClipRRect(
                  child: Image.asset("assets/images/complete.png", width: 80, height: 80,),
                ),
              )
            ],
          ),
        ),
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCircle(
              color: Colors.red,
              duration: Duration(seconds: 1),
            ),
            SizedBox(height: 10,),
            Text("Canceling Orders...."),
          ],
        ),
      ),
    );

  }

  Widget userInfo(String? title){
    return Text('${title}',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    );
  }


}
