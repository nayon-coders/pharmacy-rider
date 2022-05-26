import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:pharmacy_rider_apps/view/home-screen/widget/DashboardBox.dart';
import 'package:pharmacy_rider_apps/view/orders/order-reports/search-order-reports.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-orders.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../accpect-orders/accpect-orders.dart';
import '../cancle/cancel-order-list.dart';
import '../delivery-order/delivery-orders-list.dart';

class DailyReports extends StatefulWidget {
  final String currentData;
  const DailyReports({Key? key, required this.currentData}) : super(key: key);

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
        title: Text("${widget.currentData} Reports"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [

            FutureBuilder(
                future: _allOrders.fromOrders(),
                builder: (context, AsyncSnapshot<dynamic> snapshot){
                  if(snapshot.hasData){
                      double Plength = 0;
                      double Alength = 0;
                      double Dlength = 0;
                      double Clength = 0;

                      double pendingPrice = 0;
                      double acceptPrice = 0;
                      double deliveredPrice = 0;
                      double cancelPrice = 0;
                      String amount;
                      for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                        String date = snapshot.data['data'][i]['updated_at'];
                        if(snapshot.data['data'][i]['status'] == 'Pending' && date == widget.currentData){
                          Plength += 1;
                           amount = snapshot.data['data'][i]['amount'];
                          pendingPrice += double.parse(amount);
                        }if(snapshot.data['data'][i]['status'] == 'Processing' && date == widget.currentData){
                          Alength += 1;
                           amount = snapshot.data['data'][i]['amount'];
                          acceptPrice += double.parse(amount);
                        }if(snapshot.data['data'][i]['status'] == 'Delivered' && date == widget.currentData){
                          Dlength += 1;
                          amount = snapshot.data['data'][i]['amount'];
                          deliveredPrice += double.parse(amount);
                        }if(snapshot.data['data'][i]['status'] == 'Canceled' && date == widget.currentData){
                          Clength += 1;
                          amount = snapshot.data['data'][i]['amount'];
                          cancelPrice += double.parse(amount);
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            PieChart(
                              dataMap:  {
                                "Pending" : Plength,
                                "Accept" : Alength,
                                "Canceled" : Dlength,
                                "Delivered" : Clength,
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
                                      child: DashboardBox(Plength.toInt(), "Pending", customColor.pendingColor),
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
                                      child: DashboardBox(Alength.toInt(), "Accept", Colors.green),
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
                                      child: DashboardBox(Dlength.toInt(), "Delivered", customColor.confirmColor),
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
                                      child: DashboardBox(Clength.toInt(), "Canceled", customColor.cancelColor),
                                    )
                                ),
                              ],
                            ),

                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Settle accounts info: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  ),
                                  Card(
                                    elevation: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Today Pending Order: ",
                                            style: TextStyle(
                                                color: customColor.pendingColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10.sp
                                            ),
                                          ),
                                          Text("${pendingPrice} ৳",
                                            style: TextStyle(
                                                color: customColor.pendingColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 2,
                                    child: Container(

                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:  [
                                          Text("Today Accept Order: ",
                                            style: TextStyle(
                                                color: Colors.green.shade800,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.sp
                                            ),
                                          ),
                                          Text("${acceptPrice} ৳",
                                            style: TextStyle(
                                                color: Colors.green.shade800,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 2,
                                    child: Container(

                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:  [
                                          Text("Today Delivered Order: ",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.sp
                                            ),
                                          ),
                                          Text("${deliveredPrice} ৳",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 2,
                                    child: Container(

                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:  [
                                          Text("Today Cancel Order: ",
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.sp
                                            ),
                                          ),
                                          Text("${cancelPrice} ৳",
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );
                    return const Center(child: Text("Please search"));
                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        color: customColor.primaryColor,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }else{
                    return const Center(child: Text("No Data"));
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



