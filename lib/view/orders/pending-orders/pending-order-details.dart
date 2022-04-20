import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/update-order-status-api.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
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
var totalAmount;
var amount;
var shipping;
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
          child: FutureBuilder(
              future: _orderService.fromOrdersDetails("${widget.OrderId}"),
                builder: (context, AsyncSnapshot<dynamic> snapshot){
                  if(snapshot.hasData){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Id: ${snapshot.data['data']['order_number ']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Text("Date: ${snapshot.data['data']['date']}",
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),

                        //user information
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text("Customer Info",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              userInfo("Customer Name: ${snapshot.data['data']['name']}"),
                              userInfo("Customer Email: ${snapshot.data['data']['email']}"),
                              userInfo("Phone Number: ${snapshot.data['data']['phone']}"),
                              userInfo("Customer Address: ${snapshot.data['data']['address']}"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30,),
                        //product information
                        const Center(
                          child: Text("Product Info",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: const Text("Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                              child: const Center(
                                child: Text("Price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                              child: const Center(
                                child: Text("Quantity",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                              child: const Center(
                                child: Text("Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )
                                ),
                              ),
                            ),


                          ],
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data['data']['order_products '].length,

                            itemBuilder: (context,index){
                              var productlist = snapshot.data['data']['order_products '][index];

                              return  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 3,
                                    child: Text(productlist['product_name'].toString(),
                                        style: const TextStyle(
                                          color: customColor.primaryColor,
                                          fontSize: 18,
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 5,
                                    child: Center(
                                      child: Text(productlist['price'].toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 5,
                                    child: Center(
                                      child: Text(productlist['quantity'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 5,
                                    child: Center(
                                      child: Text(productlist['total'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          )
                                      ),
                                    ),
                                  ),


                                ],
                              );
                            }),

                        Divider(color: Colors.grey, height: 2,),
                        //total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Sub Total:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Text(snapshot.data['data']['amount'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Shipping:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Text(snapshot.data['data']['shipping'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            const Text("Total Amount:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Text(totalAmount.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );

                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return  const Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: SpinKitCircle(
                        color: customColor.primaryColor,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }else{
                    return  const Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Center(child: Text("No Data Found")),
                    );
                  }
                }
            ),
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
                          content:  Text('You Want to Cancel This Order.?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                _Cancel("${widget.OrderId}");
                              },
                              child: Text("Ok"),
                            )

                          ],
                        ),
                      );

                    },
                    color: customColor.cancelColor,
                    child: Text("Cancel", style: TextStyle(color: Colors.white),),
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

  Widget userInfo(String? title){
    return Text('${title}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
    );
  }


void _Cancel(String OrderId) async{



  setState(() {
    _isCancel = true;
  });
  var OrderStatus = {
    "status":"Cancel",
  };

  var response = await UpdateService().UpdateData(OrderStatus, OrderId);
  var body = jsonDecode(response.body.toString());
  if(response.statusCode == 200){

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

