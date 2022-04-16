import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/services/update-order-status-api.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';

class GoForDelivery extends StatefulWidget {
  final String Name;
  final String Email;
  final String Phone;
  final String OrderId;
  const GoForDelivery({
    required this.Name,
    required this.Email,
    required this.Phone,
    required this.OrderId,
  });

  @override
  State<GoForDelivery> createState() => _GoForDeliveryState();
}

class _GoForDeliveryState extends State<GoForDelivery> {
  bool _isDeliveryConfirmed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 30),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Customer Info",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                userInfo("Name: ${widget.Name}"),
                Divider(),
                userInfo("Email: ${widget.Email}"),
                Divider(),
                FlatButton(
                  onPressed: () async{
                    //call phone number
                    launch("tel: ${widget.Phone}");
                  },
                  color: Colors.blueAccent,
                  child: Text("Call", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
          ),
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: FlatButton(
                      onPressed: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Are You Sur?'),
                            content:  const Text('Make sure, You Delivery This Order Successfully.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: (){
                                  _orderDelivery(widget.OrderId);
                                },
                                child: const Text("Yes, I do. "),
                              )

                            ],
                          ),
                        );

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>GoForDelivery()));
                      },
                      color: customColor.confirmColor,
                      child: const Text("Delivery Complete", style: TextStyle(color: Colors.white),),
                    )
                ),
              ],
            ),
          ),
        )
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

  void _orderDelivery(String OrderId) async{

    setState(() {
      _isDeliveryConfirmed = true;
    });
    var OrderStatus = {
      "status":"Delivered",
    };

    var response = await UpdateService().UpdateData(OrderStatus, OrderId);
    var body = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Order Delivery Success.'),
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

      print(body);
    }else{
      print("error");
    }
    setState(() {
      _isDeliveryConfirmed = false;
    });
  }


}
