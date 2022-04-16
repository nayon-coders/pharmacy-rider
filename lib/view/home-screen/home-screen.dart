import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/auth.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pharmacy_rider_apps/view/auth/sign-in.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/accpect-order-details.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/accpect-orders.dart';
import 'package:pharmacy_rider_apps/view/orders/cancle/cancel-order-list.dart';
import 'package:pharmacy_rider_apps/view/orders/delivery-order/delivery-orders-list.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-order-details.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-orders.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-orders.dart';
import 'package:pharmacy_rider_apps/view/pescription/accept-order/accept-prescription-list.dart';
import 'package:pharmacy_rider_apps/view/pescription/pending-pescription/pending-pescription-list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth-useri.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {

  var toatalPendingOrders;
  bool _isLogout = false;
  @override
  Widget build(BuildContext context) {
    AllOrders _allOrders = AllOrders();

    return Scaffold(
      body:SingleChildScrollView(
        child: _isLogout != true
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Home top bar
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:  Image.asset("assets/images/user.jpg", height: 40, width: 40,),
                              ),
                              const SizedBox(width: 10,),
                              const Text("Nayon Talukder",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  fontSize: 22,
                                ),),
                            ],
                          ),
                          IconButton(
                              onPressed: (){
                                setState(() {

                                  _logOut();
                                });
                              },
                              icon: const Icon(Icons.logout, size: 30,)
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),
                  //Dashboard text
                  const Text("Orders",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 10,),
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
                                    for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                      if(snapshot.data['data'][i]['status'] == 'Pending'){
                                        return DashboardBox("${i}", "Pending", customColor.pendingColor);
                                      }
                                    }
                                  }else{
                                    return DashboardBox("0", "Pending", customColor.pendingColor);
                                  }
                                  return DashboardBox("0", "Pending", customColor.pendingColor);
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
                                    for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                      if(snapshot.data['data'][i]['status'] == 'Processing'){
                                        return DashboardBox("${i + 1}", "Accept", Colors.green);
                                      }
                                    }
                                  }else{
                                    return DashboardBox("0", "Accept", Colors.green);
                                  }
                                  return DashboardBox("0", "Accept", Colors.green);
                                }
                            ),
                          )
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
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
                                    for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                      if(snapshot.data['data'][i]['status'] == 'Confirmed'){
                                        return DashboardBox("${i + 1}", "Confirmed", customColor.confirmColor);
                                      }
                                    }
                                  }else{
                                    return DashboardBox("0", "Confirmed", customColor.confirmColor);
                                  }
                                  return DashboardBox("0", "Confirmed", customColor.confirmColor);
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
                                    for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                      if(snapshot.data['data'][i]['status'] == 'Cancel'){
                                        return DashboardBox("${i + 1}", "Cancel", customColor.cancelColor);
                                      }
                                    }
                                  }else{
                                    return DashboardBox("0", "Cancel", customColor.cancelColor);
                                  }
                                  return DashboardBox("0", "Cancel", customColor.cancelColor);
                                }
                            ),
                          )
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),
                  //Order reports....
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Order Reports",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Icon(Icons.report, color: Colors.deepOrangeAccent,)
                        ],
                      ),
                    ),
                  ),



                  //Recreation
                  const SizedBox(height: 10,),
                  //Recreation text
                  const Text("Recreations",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PendingPescriotionList()));
                            },
                            child: DashboardBox("1", "Pending", customColor.pendingColor),
                          )
                      ),


                      SizedBox(width: 10,),
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AcceptPrescriptionList()));
                            },
                            child: DashboardBox("1", "Accept", customColor.confirmColor),
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),


                ],
              ),
            )
            : SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 150),
                      child: const SpinKitCircle(
                      color: Colors.red,
                        duration: Duration(seconds: 1),
                      ),
                  ),
                  Text("Logout..."),
                ],
              ),
            )
      ),
    );
  }
  void _logOut()async{
    setState(() {
      _isLogout = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    //Store Data
    var token = localStorage.getString('token');
    // token == null ? Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn())): null;
    var response = await CallApi().postData("token", '/logout');
    var body = jsonDecode(response.body);


    if(response.statusCode == 200){
      print("logout success");
    }
    setState(() {
      token == null ? Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn())): null;
      _isLogout = false;
    });

  }
}


class DashboardBox extends StatelessWidget {
  String Number;
  String Value;
  dynamic color;
  DashboardBox(this.Number, this.Value, this.color);
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [

              Text("${Number}",
                style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),

              Text(Value,
                style:const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 10,),
              const Align(
                alignment: Alignment.bottomRight,
                child:Text("View",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
