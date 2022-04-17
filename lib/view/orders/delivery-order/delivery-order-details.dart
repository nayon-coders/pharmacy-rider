import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/update-order-status-api.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/delivery-orders.dart';
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
          child: FutureBuilder(

              future: _orderService.fromOrdersDetails("${widget.OrderId}"),
              builder: (context, AsyncSnapshot<dynamic> snapshot){
                if(!snapshot.hasData){
                  return  const Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: SpinKitCircle(
                      color: customColor.primaryColor,
                      duration: Duration(seconds: 1),
                    ),
                  );
                }else{
                  amount = double.parse(snapshot.data['data']['amount']);
                  shipping = double.parse(snapshot.data['data']['shipping']);
                  totalAmount = amount + shipping;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Stack(
                       children:[ 
                         Column(
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
                         ],
                       ),
                         
                         Align(
                           alignment: Alignment.topRight,
                           child: Image.asset("assets/images/complete.png", height: 100, width: 100,),
                         )
                       ],
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