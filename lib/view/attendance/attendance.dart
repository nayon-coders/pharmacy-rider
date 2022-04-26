import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/model/AttendanceModel.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/attendance-service.dart';
import 'package:pharmacy_rider_apps/services/auth-useri.dart';
import 'package:pharmacy_rider_apps/view/attendance/current-time-clock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  //current date
  DateTime date = DateTime.now();


  //

  late bool _isTimeIn = false;
  late bool _isTimeOut = false;
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
    AttandenceDetails _attendanceDetails = AttandenceDetails();
    return RefreshIndicator(
      onRefresh: ()async{
        await _attendanceDetails.fromAttendance();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Attendance"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Text("Today: ${dateFormat.format(date)}",
                style: TextStyle(
                  color: Color(0xFF051C4B),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30,),
              Expanded(
                flex: 0,
                  child: FutureBuilder(
                    future: _attendanceDetails.fromAttendance(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot){
                      if(!snapshot.hasData){
                        return const Center();
                      }else if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(
                          child: SpinKitCircle(
                            color: customColor.primaryColor,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }else{
                        if(snapshot.data['data'].length == 0) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _ClockingIn();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF051C4B),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                child: Text("Check In",),
                              ),
                              ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFFF5630),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                child: const Text("Check Out",),
                              ),
                            ],
                          );
                        }else{
                          if (snapshot.data['data']["time"] != null ) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF051C4B),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  child: Text("Check In",),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _CheckOut();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFFFF5630),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  child: const Text("Check Out",),
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF051C4B),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  child: Text("Check In",),
                                ),
                                ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFFFF5630),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  child: const Text("Check Out",),
                                ),
                              ],
                            );
                          }


                        }


                        // }//end for
                        return Text("");
                      }
                    },
                  )
              ),
              /////// end future builder /////////

              SizedBox(height: 40,),

              const Text("Courrent Time",
                style: TextStyle(
                  color: Color(0xFF051C4B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              CurrentTime(),
            ],
          ),
        ),
      ),
    );
  }

  //clocking
  void _ClockingIn() async{

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //Store Data
    var token = localStorage.getString('token');

   // curentDate = dateFormat.format(date);
  var response =  await http.post(
    Uri.parse(ApiServise.AttendanceUpdate),
    headers: {
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
      'X-Header-Token' : 'base64:KWyE5YqjEnsf0L+9R7unn5QimC8eTW21sm1WalIA2+Y=',
      'Authorization' : 'Bearer $token',
    },
  );
  print(response.statusCode);
  if(response.statusCode == 200){
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("You are checking", ),
            backgroundColor: Color(0xFF051C4B),
          ));
    });
  }else{
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You are already in", ),
            backgroundColor: Color(0xFF051C4B),
          ));
    });
  }


  }

//clockout
  void _CheckOut() async{

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //Store Data
    var token = localStorage.getString('token');

    // curentDate = dateFormat.format(date);
    var response =  await http.post(
      Uri.parse(ApiServise.AttendanceUpdate),
      headers: {
        'Accept' : 'application/json',
        'Content-Type' : 'application/json',
        'X-Header-Token' : 'base64:KWyE5YqjEnsf0L+9R7unn5QimC8eTW21sm1WalIA2+Y=',
        'Authorization' : 'Bearer $token',
      },
    );
    print(response.statusCode);
    if(response.statusCode == 200){
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Check out success", ),
              backgroundColor: Color(0xFFE63F31),
            ));
      });
    }else{
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You are already in", ),
              backgroundColor: Color(0xFFE63F31),
            ));
      });
    }

  }
}
