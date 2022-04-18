
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy_rider_apps/view/orders/delivery-order/delivery-order-details.dart';

class CancelOrdersList extends StatefulWidget {
  const CancelOrdersList({Key? key}) : super(key: key);

  @override
  State<CancelOrdersList> createState() => _CancelOrdersListState();
}

class _CancelOrdersListState extends State<CancelOrdersList> {


  @override
  Widget build(BuildContext context) {
    AllOrders _allOrders = AllOrders();
    return Scaffold(
      appBar: AppBar(

        title: const Text("Cancel Orders List"),
        backgroundColor: Colors.redAccent,
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
                      child: Text("No Cancel Data"),
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
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index){
                          if(snapshot.data['data'][index]['status'] == 'Cancel'){
                            return OrderList(
                              orderId: snapshot.data['data'][index]['order_number '].toString(),
                              date: snapshot.data['data'][index]['date'].toString(),
                              OrderId: snapshot.data['data'][index]['id'].toString(),
                              status: snapshot.data['data'][index]['status'].toString(),
                            );
                          }else{
                            return const Center(

                            );
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
  final String orderId, date, OrderId, status;
  OrderList({required this.orderId, required this.date, required this.OrderId, required this.status});

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
                ),
                Text("Status: ${status}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>DeliveryOrderDetails(OrderId: OrderId)));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: customColor.cancelColor,
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

