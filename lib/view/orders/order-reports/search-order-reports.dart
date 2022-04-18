import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-order-details.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-orders.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../accpect-orders/accpect-orders.dart';
import '../cancle/cancel-order-list.dart';
import '../delivery-order/delivery-orders-list.dart';

class OrdersReportsByDate extends StatefulWidget {
  const OrdersReportsByDate({Key? key}) : super(key: key);

  @override
  _OrdersReportsByDateState createState() => _OrdersReportsByDateState();
}

class _OrdersReportsByDateState extends State<OrdersReportsByDate> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  late  String PickDate;
  TextEditingController _controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AllOrders _allOrders = AllOrders();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders Reports"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: TextFormField(
                  onChanged: (value){
                    setState(() { });
                  },
                  keyboardType: TextInputType.datetime,
                  controller: _controllerSearch,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Filter Orders",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Icon(
                        Icons.date_range,
                        color: Colors.white,
                        size: 27,
                      )
                  ),
                )
            ),
            Expanded(
              child: FutureBuilder(
                  future: _allOrders.fromOrders(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data['data'].length,
                            itemBuilder: (context, index){
                              String date = snapshot.data['data'][index]['updated_at'];
                              if(_controllerSearch.text.isEmpty){
                                return OrderList(
                                  orderId: snapshot.data['data'][index]['order_number '].toString(),
                                  date: snapshot.data['data'][index]['date'].toString(),
                                  id: snapshot.data['data'][index]['id'].toString(),
                                  status: snapshot.data['data'][index]['status'].toString(),
                                  shipping: snapshot.data['data'][index]['shipping'].toString(),
                                  amount: snapshot.data['data'][index]['amount'].toString(),
                                );

                              }else if(date.contains(_controllerSearch.text)){
                                return OrderList(
                                  orderId: snapshot.data['data'][index]['order_number '].toString(),
                                  date: snapshot.data['data'][index]['date'].toString(),
                                  id: snapshot.data['data'][index]['id'].toString(),
                                  status: snapshot.data['data'][index]['status'].toString(),
                                  shipping: snapshot.data['data'][index]['shipping'].toString(),
                                  amount: snapshot.data['data'][index]['amount'].toString(),
                                );
                              }else{
                                return Center();

                              }
                            }
                        );
                    }else if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: SpinKitCircle(
                          color: customColor.primaryColor,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }else{
                      return const Center(
                        child: SpinKitCircle(
                          color: customColor.primaryColor,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget getOrderdetails(String title, int number, Color color, ){
    return Container(
      padding: const EdgeInsets.all(10),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${title}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("${number}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final String orderId, date, id, status, amount, shipping ;
  OrderList({required this.orderId, required this.date, required this.id, required this.status, required this.amount, required this.shipping});

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
                Text("Status: $status",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}

