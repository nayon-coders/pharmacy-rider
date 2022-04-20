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
                        return const Center(child: Text(""));
                      }else if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(
                          child: SpinKitCircle(
                            color: customColor.primaryColor,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }else{
                        //user attendance
                        //for(var i = 0; i > snapshot.data['data'].length; i++) {
                          if(snapshot.data['data'].length < 0) {
                               _isTimeIn = true;
                               _isTimeOut = true;
                            return const Center();

                          } else if(snapshot.data['data']['date'] != dateFormat.format(date)) {
                            _isTimeIn = false;
                            _isTimeOut = false;
                          } else {
                          _isTimeIn = true;
                          _isTimeOut = true;
                          return const Center();

                          }


                        // }//end for
                        return Text("");
                      }
                    },
                  )
              ),
              /////// end future builder /////////

              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _isTimeIn == true ? null: () {
                      _ClockingIn();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF051C4B),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    child: Text("Check In",),
                  ),
                  ElevatedButton(
                    onPressed: _isTimeOut == true ? null : (){
                      _CheckOut();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFF5630),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    child: Text("Check Out",),
                  ),
                ],
              ),

              SizedBox(height: 40,),

              Text("Courrent Time",
                style: const TextStyle(
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
          SnackBar(
              content: Text("You are checking", ),
            backgroundColor: Color(0xFF051C4B),
          ));
    });
  }else{
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You are already in. Next Day Try again.", ),
            backgroundColor: Color(0xFFFA0202),
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
            SnackBar(
              content: Text("You are already in. Next Day Try again.", ),
              backgroundColor: Color(0xFFE63F31),
            ));
      });
    }else{
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You are already in.", ),
              backgroundColor: Color(0xFFFA0202),
            ));
      });
    }

  }
}
