import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/UpdatePrescription.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/prescription-service.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:pharmacy_rider_apps/view/pescription/add-product/add-product.dart';

class ProcessingPrescriptionDetails extends StatefulWidget {
  final String id;
  const ProcessingPrescriptionDetails({Key? key, required this.id}) : super(key: key);

  @override
  _ProcessingPrescriptionDetailsState createState() => _ProcessingPrescriptionDetailsState();
}

class _ProcessingPrescriptionDetailsState extends State<ProcessingPrescriptionDetails> {
  bool _isLoding = false;

  TextEditingController _notes = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    PrescriptionService _prescriptionService = PrescriptionService();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Processing Prescription Files"),
          backgroundColor: customColor.processingColor,
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
                          scrollDirection: Axis.vertical,
                            itemCount: snapshot.data['data'].length,
                            itemBuilder: (context, index){
                              print(snapshot.data['data'][index]["file"]);
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
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
                    flex: 1,
                    child: FlatButton(
                      onPressed: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Are You Sure? '),
                            content:   Text('Already added product. Is it complete?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: (){
                                  _complete(widget.id);
                                },
                                child: const Text("Yes.! Complete"),
                              )

                            ],
                          ),
                        );

                      },
                      color: customColor.confirmColor,
                      child: Text("Confirmed", style: TextStyle(color: Colors.white),),
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                    flex: 1,
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
                                child: const Text("Yes.! I do"),
                              )

                            ],
                          ),
                        );

                      },
                      color: customColor.processingColor,
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

void _complete (id) async{
  setState(() {
    _isLoding = true;
  });
  var Prescription = {
    "status": "Confirmed",
  };

  var response = await UpdatePerscription().UpdatePerscriptionData(Prescription, id);
  var body = jsonDecode(response.body.toString());
  if(response.statusCode == 200){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Prescription Confirmed.'),
        content:  Text('${body['message']}'),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
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

