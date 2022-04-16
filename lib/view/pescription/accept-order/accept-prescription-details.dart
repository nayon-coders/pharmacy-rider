import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/UpdatePrescription.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/prescription-service.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:pharmacy_rider_apps/view/pescription/add-product/add-product.dart';

class AcceptPrescriptionDetails extends StatefulWidget {
  final String id;
  const AcceptPrescriptionDetails({Key? key, required this.id}) : super(key: key);

  @override
  _AcceptPrescriptionDetailsState createState() => _AcceptPrescriptionDetailsState();
}

class _AcceptPrescriptionDetailsState extends State<AcceptPrescriptionDetails> {
  bool _isLoding = false;

  TextEditingController _notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PrescriptionService _prescriptionService = PrescriptionService();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Files"),
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
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [

                Expanded(
                    flex: 2,
                    child: FlatButton(
                      onPressed: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Are You Sure? '),
                            content:   Text('You Want to Add More Product.?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Addproduct( PID: widget.id,)));
                                },
                                child: Text("Ok"),
                              )

                            ],
                          ),
                        );

                      },
                      color: customColor.confirmColor,
                      child: Text("Add Products", style: TextStyle(color: Colors.white),),
                    )
                ),

                Expanded(
                    flex: 2,
                    child: FlatButton(
                      onPressed: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Are You Sure? '),
                            content:   Text('You want to delete?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: (){
                                  _deletePrescription(widget.id);
                                },
                                child: Text("Delete"),
                              )

                            ],
                          ),
                        );

                      },
                      color: customColor.confirmColor,
                      child: Text("Add Products", style: TextStyle(color: Colors.white),),
                    )
                ),

                SizedBox(width: 10,),

              ],
            ),
          ),
        )
    );

  }

void _deletePrescription (id) async{

}


}

