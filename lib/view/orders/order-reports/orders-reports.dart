import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:pharmacy_rider_apps/view/home-screen/widget/card-box-rows-widget-dart.dart';
import 'package:pharmacy_rider_apps/view/orders/order-reports/daily-reports.dart';
import 'package:pharmacy_rider_apps/view/orders/order-reports/search-order-reports.dart';
import 'package:pharmacy_rider_apps/view/orders/order-reports/widgets/pie-chart-widget.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-orders.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../accpect-orders/accpect-orders.dart';
import '../cancle/cancel-order-list.dart';
import '../delivery-order/delivery-orders-list.dart';

class OrdersReports extends StatefulWidget {
  const OrdersReports({Key? key}) : super(key: key);

  @override
  _OrdersReportsState createState() => _OrdersReportsState();
}

class _OrdersReportsState extends State<OrdersReports> with TickerProviderStateMixin {

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
        child: ListView(
          children: [
            GestureDetector(
              onTap: (){
                _DatePicker();

              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Filter By Date",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.date_range,
                      color: Colors.white,
                      size: 27,
                    ),
                  ],
                )
              ),
            ),
           FutureBuilder(
              future: _allOrders.fromOrders(),
              builder: (context, AsyncSnapshot<dynamic> snapshot){
                if(snapshot.hasData){
                  return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                           //Pei chart
                            PeiChartWidget(),
                            //Pei chart



                            OrderLengthRows(),
                          ],
                        ),
                      );
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: SpinKitCircle(
                      color: customColor.primaryColor,
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
                else{
                  return Center(child: Text("No Data"));
                }
              }
          ),

          ],
        ),
      ),
    );
  }
  Widget getOrderdetails(String title, int number, Color color){
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


  _DatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050)
        ).then((value){
          if(value != null){
            PickDate = dateFormat.format(value);
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>DailyReports(currentData: PickDate)));

          }


    });
  }
}
