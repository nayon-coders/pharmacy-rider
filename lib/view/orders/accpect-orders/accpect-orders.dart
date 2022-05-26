import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/accpect-order-details.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-order-details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class acpectOrders extends StatefulWidget {
  const acpectOrders({Key? key}) : super(key: key);

  @override
  State<acpectOrders> createState() => _acpectOrdersState();
}

class _acpectOrdersState extends State<acpectOrders> {


  @override
  Widget build(BuildContext context) {
    AllOrders _allOrders = AllOrders();
    return Scaffold(
      appBar: AppBar(

        title: const Text("Accpet Orders List"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10,),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Expanded(child: FutureBuilder(
                future: _allOrders.fromOrders(),
                builder: (context, AsyncSnapshot<dynamic> snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: SpinKitCircle(
                        color: customColor.primaryColor,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }else{
                    //show data;
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index){
                          if(snapshot.data['data'][index]['status'] == 'Processing'){
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
                    fontSize: 10.sp,
                  ),
                ),
                Text("Date: $date",
                  style: TextStyle(
                    fontSize: 10.sp,

                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>AcpectOrderDetails(OrderId: OrderId)));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: customColor.confirmColor,
                ),
                child: Text("Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
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

