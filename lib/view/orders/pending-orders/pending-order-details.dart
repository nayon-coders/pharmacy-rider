import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/update-order-status-api.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:pharmacy_rider_apps/view/orders/order-details-controller.dart';
import '../../../services/order-details.drart.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/accpect-orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class PendingOrderDetails extends StatefulWidget {
  final String OrderId;

  PendingOrderDetails({required this.OrderId});


  @override
  State<PendingOrderDetails> createState() => _PendingOrderDetailsState();
}

class _PendingOrderDetailsState extends State<PendingOrderDetails> {

bool _isCancel = false;
@override
  Widget build(BuildContext context) {
    OrderService _orderService = OrderService();
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Order Details "),
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
              color: Colors.blue,
              duration: Duration(seconds: 1),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [

              Expanded(
                  flex: 2,
                  child: FlatButton(
                    onPressed: (){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Are You Sure? '),
                          content:  const Text('You Want to Cancel This Order.?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                print(widget.OrderId);
                                _Cancel(widget.OrderId);
                              },
                              child: const Text("Ok"),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: const Text("No"),
                            )

                          ],
                        ),
                      );

                    },
                    color: customColor.cancelColor,
                    child: const Text("Cancel", style: TextStyle(color: Colors.white),),
                  )
              ),

              SizedBox(width: 10,),
              Expanded(
                  flex: 2,
                  child: FlatButton(
                    onPressed: (){
                      _acpectOrder(widget.OrderId);
                    },
                    color: customColor.confirmColor,
                    child: Text("Accpect", style: TextStyle(color: Colors.white),),
                  )
              ),
            ],
          ),
        ),
      )
    );

  }




void _Cancel(String OrderId) async{
  setState(() {
    //print(OrderId);
    _isCancel = true;
  });
  var OrderStatus = {
    "status": "Canceled"
  };

  var response = await UpdateService().UpdateData(OrderStatus, OrderId);
  var body = jsonDecode(response.body.toString());
  print(response.statusCode );
  if(response.statusCode == 200){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
  }else{
    print("error");
  }
  setState(() {
    _isCancel = false;
  });
}


  void _acpectOrder(String OrderId) async{
    setState(() {
      _isCancel = true;
    });
    var OrderStatus = {
      "status":"Processing",
    };

    var response = await UpdateService().UpdateData(OrderStatus, OrderId);
    var body = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Order Accepted.'),
          content:  Text('${body['message']}'),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              },
              child: Text("Ok"),
            )

          ],
        ),
      );
    }else{
      print("error");
    }
    setState(() {
      _isCancel = false;
    });
  }

}

