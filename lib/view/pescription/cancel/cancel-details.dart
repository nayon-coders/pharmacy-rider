import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/UpdatePrescription.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/prescription-service.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:pharmacy_rider_apps/view/pescription/add-product/add-product.dart';

class CanceledPescriptionDetails extends StatefulWidget {
  final String id;
  const CanceledPescriptionDetails({Key? key, required this.id, }) : super(key: key);

  @override
  _CanceledPescriptionDetailsState createState() => _CanceledPescriptionDetailsState();
}

class _CanceledPescriptionDetailsState extends State<CanceledPescriptionDetails> {
  bool _isLoding = false;

  TextEditingController _notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PrescriptionService _prescriptionService = PrescriptionService();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Files"),
          backgroundColor: Colors.redAccent,
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: _prescriptionService.formPrescriptionServiceListFile(widget.id),
                    builder: (context, AsyncSnapshot<dynamic> snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: snapshot.data['data'].length,
                            itemBuilder: (context, index){
                              print(snapshot.data['data'][index]["file"]);
                              return Container(
                                  child: Image(
                                    image: NetworkImage("${ApiServise.siteUrl}"+"${snapshot.data['data'][index]["file"]}"),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                  )
                              );
                              return Text("${snapshot.data['data'][index]["id"]}");
                            }
                        );

                      }else if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: SpinKitCircle(
                            color: customColor.primaryColor,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                      else{
                        print("no data");
                        return Center(child: Text("No Data Found"));
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

