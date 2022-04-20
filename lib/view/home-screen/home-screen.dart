import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/auth.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pharmacy_rider_apps/services/prescription-service.dart';
import 'package:pharmacy_rider_apps/view/attendance/attendance.dart';
import 'package:pharmacy_rider_apps/view/auth/sign-in.dart';
import 'package:pharmacy_rider_apps/view/home-screen/widget/DashboardBox.dart';
import 'package:pharmacy_rider_apps/view/home-screen/widget/card-box-rows-widget-dart.dart';
import 'package:pharmacy_rider_apps/view/orders/order-reports/orders-reports.dart';
import 'package:pharmacy_rider_apps/view/pescription/accept-order/accept-prescription-list.dart';
import 'package:pharmacy_rider_apps/view/pescription/cancel/calcel-prescription-list.dart';
import 'package:pharmacy_rider_apps/view/pescription/pending-pescription/pending-pescription-list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth-useri.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {
  //user information


  bool _isLogout = false;
  var userData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _UserInfo();
  }

void _UserInfo() async{
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  //Store Data
  var userJson = localStorage.getString('user');
    var user = jsonDecode(userJson!);
    setState(() {
      userData =user;
    });
}

  @override
  Widget build(BuildContext context) {
    AllOrders _allOrders = AllOrders();
    PrescriptionService _prescriptionService = PrescriptionService();

    return RefreshIndicator(
      onRefresh: ()async{
        await _allOrders.fromOrders();
        await _prescriptionService.formPrescriptionServiceList();
      },
      child: Scaffold(
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
                                Text("${userData!['name']}",
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

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendance()));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Attendance",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              Icon(Icons.file_present, color: Colors.deepOrangeAccent,)
                            ],
                          ),
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
                    //Order Length....
                    OrderLengthRows(),
                    //Order Length....

                    const SizedBox(height: 20,),
                    //Order reports Button....
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersReports()));
                      },
                      child: Card(
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
                              child: FutureBuilder(
                                  future: _prescriptionService.formPrescriptionServiceList(),
                                  builder: (context, AsyncSnapshot<dynamic> snapshot){
                                    if(snapshot.hasData){
                                      double length = 0;
                                      for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                        if(snapshot.data['data'][i]['status'] == 'Pending'){
                                          length += 1;
                                        }
                                      }
                                      return DashboardBox(length.toInt(), "Pending", customColor.pendingColor);
                                    }else{
                                      return DashboardBox(0, "Pending", customColor.pendingColor);
                                    }

                                  }
                              ),
                            )
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> AcceptPrescriptionList()));
                              },
                              child: FutureBuilder(
                                  future: _prescriptionService.formPrescriptionServiceList(),
                                  builder: (context, AsyncSnapshot<dynamic> snapshot){
                                    if(snapshot.hasData){
                                      double length = 0;
                                      for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                        if(snapshot.data['data'][i]['status'] == 'Confirmed'){
                                          length += 1;
                                        }
                                      }
                                      return DashboardBox(length.toInt(), "Accept", customColor.confirmColor);
                                    }else{
                                      return DashboardBox(0, "Accept", customColor.confirmColor);
                                    }

                                  }
                              ),
                            )
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [

                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CancelPrescriotionList()));
                              },
                              child: FutureBuilder(
                                  future: _prescriptionService.formPrescriptionServiceList(),
                                  builder: (context, AsyncSnapshot<dynamic> snapshot){
                                    if(snapshot.hasData){
                                      double length = 0;
                                      for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                                        if(snapshot.data['data'][i]['status'] == 'Canceled'){
                                          length += 1;
                                        }
                                      }
                                      return DashboardBox(length.toInt(), "Canceled", customColor.cancelColor);
                                    }else{
                                      return DashboardBox(0, "Canceled", customColor.cancelColor);
                                    }

                                  }
                              ),
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

