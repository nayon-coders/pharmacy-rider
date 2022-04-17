import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  var AllData;
  Future<void>fromOrders()async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //Store Data
    var token = localStorage.getString('token');

    var url = Uri.parse(ApiServise.orders);
    final response = await http.get(url,
      headers: {
        'Accept' : 'application/json',
        'Content-Type' : 'application/json',
        'X-Header-Token' : 'base64:KWyE5YqjEnsf0L+9R7unn5QimC8eTW21sm1WalIA2+Y=',
        'Authorization' : 'Bearer $token',
      },
    );

    if(response.statusCode == 200){
      AllData = jsonDecode(response.body.toString());

      return AllData;

    }else{
      throw Exception("Error");
    }
  }

  var toltAmount;
  var totalShipping;

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

            Expanded(
                child: FutureBuilder(
                    future: fromOrders(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot){
                      if(snapshot.hasData){

                        return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                            itemBuilder: (context, index){
                            if(snapshot.data['data'][index]['status'] == "Confirmed"){
                                toltAmount = snapshot.data['data'][index]['amount'];
                                totalShipping = snapshot.data['data'][index]['shipping'];
                              return  Column(

                              );
                            }else{
                              return Center();
                            }
                            }
                        );


                        return Text(snapshot.data['data'].length.toString());

                      }else if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
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
            ),


          ],
        ),
      ),
    );
  }
}
