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


class AcpectOrderDetails extends StatefulWidget {
  final String OrderId;

  AcpectOrderDetails({required this.OrderId});


  @override
  State<AcpectOrderDetails> createState() => _AcpectOrderDetailsState();
}

class _AcpectOrderDetailsState extends State<AcpectOrderDetails> {

  bool _isCancel = false;
  @override
  Widget build(BuildContext context) {
    OrderService _orderService = OrderService();
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Accept Order Details "),
        backgroundColor: Colors.green,
      ),
      body: _isCancel != true
          ? SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: orderDetails(OrderId: widget.OrderId),
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
      bottomNavigationBar: Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: FlatButton(
              onPressed: (){
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Are You Sure?'),
                    content: const Text('Are you ready for shipping? '),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      FutureBuilder(
                          future: _orderService.fromOrdersDetails("${widget.OrderId}"),
                          builder: (context, AsyncSnapshot<dynamic> snapshot){
                            if(snapshot.hasData){
                              return TextButton(
                                onPressed: () => Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>GoForDelivery(
                                      Email: '${snapshot.data['data']['email']}',
                                      Phone: '${snapshot.data['data']['phone']}',
                                      Name: '${snapshot.data['data']['name']}',
                                      OrderId: '${snapshot.data['data']['id']}',
                                    ))),
                                child: const Text('OK'),
                              );
                            }else{
                              return Center();
                            }
                          }
                      ),

                    ],
                  ),
                );
              },
              color: customColor.confirmColor,
              child: Text("Ready For Shipping?", style: TextStyle(color: Colors.white),),
            )
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