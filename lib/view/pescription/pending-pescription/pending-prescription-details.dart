import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/UpdatePrescription.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/prescription-service.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:pharmacy_rider_apps/view/pescription/add-product/add-product.dart';

class PendingPescriptionDetails extends StatefulWidget {
  final String id;
  const PendingPescriptionDetails({Key? key, required this.id}) : super(key: key);

  @override
  _PendingPescriptionDetailsState createState() => _PendingPescriptionDetailsState();
}

class _PendingPescriptionDetailsState extends State<PendingPescriptionDetails> {
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
                            content:  Container(
                              height: 120,
                              child: Column(
                                children: [
                                  Text('You Want to Cancel This Order.?'),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    controller: _notes,
                                    decoration: InputDecoration(
                                        hintText: "Type Note...",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1,),
                                        ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: (){
                                  _Cancel("${widget.id}");
                                },
                                child: Text("Ok"),
                              )

                            ],
                          ),
                        );

                      },
                      color: customColor.cancelColor,
                      child: Text("Cancel", style: TextStyle(color: Colors.white),),
                    )
                ),

                SizedBox(width: 10,),
                Expanded(
                    flex: 2,
                    child: FlatButton(
                      onPressed: (){
                        _acpectOrder("${widget.id}");
                       // _acpectOrder(widget.OrderId);
                      },
                      color: customColor.confirmColor,
                      child: Text("Accpect", style: TextStyle(color: Colors.white),),
                    )
                ),
              ],
            ),
          ),
        )
    );

  }

  void _Cancel(String pId) async{

    print(pId);
    setState(() {
       _isLoding = true;
    });

    var Prescription = {
      "status":"Canceled",
      "note":_notes.text,
    };

    var response = await UpdatePerscription().UpdatePerscriptionData(Prescription, pId);
    var body = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      setState(() {
        _isLoding = false;
      });
    }else{
      print(body['massage']);
    }


  }


  void _acpectOrder(String PID) async{
    setState(() {
      _isLoding = true;
    });
    var Prescription = {
      "status": "Confirmed",
    };

    var response = await UpdatePerscription().UpdatePerscriptionData(Prescription, PID);
    var body = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      print("succes Confiremd");
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Prescription Accepted.'),
          content:  Text('${body['message']}'),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Addproduct( PID: PID,)));
              },
              child: Text("Ok"),
            )

          ],
        ),
      );
    }else{
      print("error");
    }
    setState(() {
      _isLoding = false;
    });
  }

}

