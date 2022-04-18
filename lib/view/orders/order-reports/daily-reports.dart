import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/model/OrderListModel.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:pharmacy_rider_apps/view/orders/order-reports/search-order-reports.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-orders.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../accpect-orders/accpect-orders.dart';
import '../cancle/cancel-order-list.dart';
import '../delivery-order/delivery-orders-list.dart';

class DailyReports extends StatefulWidget {
  const DailyReports({Key? key}) : super(key: key);

  @override
  _DailyReportsState createState() => _DailyReportsState();
}

class _DailyReportsState extends State<DailyReports> with TickerProviderStateMixin {

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
            FutureBuilder(
                future: _allOrders.fromOrders(),
                builder: (context, AsyncSnapshot<dynamic> snapshot){
                  if(snapshot.hasData){


                    if(_controllerSearch.text.isNotEmpty){
                      String UpDate;
                      for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                        if(snapshot.data['data'][i]['status'] == 'Canceled'){
                          UpDate = snapshot.data['data'][i]['updated_at'];
                        }
                      }
                      UpDate = snapshot.data['data'][0]['updated_at'];
                      if(UpDate.contains(_controllerSearch.text)){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              PieChart(
                                dataMap: const {
                                  "Pending" : 100,
                                  "Accept" : 100,
                                  "Canceled" : 100,
                                  "Delivered" : 100,
                                },
                                colorList: const [
                                  customColor.pendingColor,
                                  Colors.green,
                                  customColor.confirmColor,
                                  customColor.cancelColor,
                                ],
                                animationDuration: const Duration(seconds: 1),
                                chartType: ChartType.ring,
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                              ),
                              const SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // pending orders count
                                  Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>PendingOrders()));
                                        },
                                        child: FutureBuilder(
                                            future: _allOrders.fromOrders(),
                                            builder: (context, AsyncSnapshot<dynamic> snapshot){
                                              if(snapshot.hasData){
                                                int length = 0;
                                                for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                                  if(snapshot.data['data'][i]['status'] == 'Pending'){
                                                    length += 1;
                                                  }
                                                }
                                                return DashboardBox(length, "Pending", customColor.pendingColor);
                                              }else{
                                                return DashboardBox(0, "Pending", customColor.pendingColor);
                                              }

                                            }
                                        ),
                                      )
                                  ),


                                  SizedBox(width: 10,),
                                  //processing order count
                                  Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>const acpectOrders()));
                                        },
                                        child: FutureBuilder(
                                            future: _allOrders.fromOrders(),
                                            builder: (context, AsyncSnapshot<dynamic> snapshot){
                                              if(snapshot.hasData){
                                                int ConfiremdOrdersLength = 0;
                                                for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                                  if(snapshot.data['data'][i]['status'] == 'Processing'){
                                                    ConfiremdOrdersLength += 1;
                                                  }
                                                }
                                                return DashboardBox(ConfiremdOrdersLength, "Accept", Colors.green);
                                              }else{
                                                return DashboardBox(0, "Pending", customColor.pendingColor);
                                              }

                                            }
                                        ),
                                      )
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //confirmed order count
                                  Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryOrdersList()));
                                        },
                                        child: FutureBuilder(
                                            future: _allOrders.fromOrders(),
                                            builder: (context, AsyncSnapshot<dynamic> snapshot){
                                              if(snapshot.hasData){
                                                int length = 0;
                                                for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                                  if(snapshot.data['data'][i]['status'] == 'Delivered'){
                                                    length += 1;
                                                  }
                                                }
                                                return DashboardBox(length, "Delivered", customColor.confirmColor);
                                              }else{
                                                return DashboardBox(0, "Delivered", customColor.confirmColor);
                                              }

                                            }
                                        ),
                                      )
                                  ),


                                  SizedBox(width: 10,),
                                  //cancel order count
                                  Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CancelOrdersList()));
                                        },
                                        child: FutureBuilder(
                                            future: _allOrders.fromOrders(),
                                            builder: (context, AsyncSnapshot<dynamic> snapshot){
                                              if(snapshot.hasData){
                                                int length = 0;
                                                for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                                  if(snapshot.data['data'][i]['status'] == 'Canceled'){
                                                    length += 1;
                                                  }
                                                }
                                                return DashboardBox(length, "Canceled", customColor.cancelColor);
                                              }else{
                                                return DashboardBox(0, "Canceled", customColor.cancelColor);
                                              }

                                            }
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }else{
                        return const Text("o");
                      }
                    }else{
                      return Center(child: Text("Please search"));
                    }


                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        color: customColor.primaryColor,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }else{
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
}


