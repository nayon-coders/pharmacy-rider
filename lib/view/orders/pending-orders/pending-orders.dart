import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-order-details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {

  var length;
  @override
  Widget build(BuildContext context) {
    AllOrders _allOrders = AllOrders();
    return Scaffold(
      appBar: AppBar(

        title: const Text("Pending Orders List"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10,),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Expanded(child: FutureBuilder(
              future: _allOrders.fromOrders(),
                builder: (context, AsyncSnapshot<dynamic> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, index){
                        if(snapshot.data['data'][index]['status'] == 'Pending'){
                          length = index;
                          return OrderList(
                            orderId: snapshot.data['data'][index]['order_number '].toString(),
                            date: snapshot.data['data'][index]['date'].toString(),
                            OrderId: snapshot.data['data'][index]['id'].toString(),
                          );
                        }else{
                          return Center();
                        }


                      }
                  );

                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(
                      color: customColor.primaryColor,
                      duration: Duration(seconds: 1),
                    ),
                  );
                }else{
                  //show data;
                  return Center(
                    child:Text("No Data Fpound"),
                  );
                }

              }
            )
            ),

          ],
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final String orderId, date, OrderId;
  OrderList({required this.orderId, required this.date, required this.OrderId});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Id: ${orderId}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text("Date: $date",
                  style: TextStyle(
                    fontSize: 15,

                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>PendingOrderDetails(OrderId: OrderId)));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: customColor.primaryColor,
                ),
                child: Text("Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

