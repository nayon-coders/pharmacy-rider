import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/prescription-service.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-order-details.dart';
import 'package:pharmacy_rider_apps/view/pescription/cancel/cancel-details.dart';
import 'package:pharmacy_rider_apps/view/pescription/pending-pescription/pending-prescription-details.dart';

class CancelPrescriotionList extends StatefulWidget {
  const CancelPrescriotionList({Key? key}) : super(key: key);

  @override
  _CancelPrescriptionListState createState() => _CancelPrescriptionListState();
}

class _CancelPrescriptionListState extends State<CancelPrescriotionList> {
  @override
  Widget build(BuildContext context) {
    PrescriptionService _prescriptionService = PrescriptionService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Canceled Prescription"),
        backgroundColor: Colors.redAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: _prescriptionService.formPrescriptionServiceList(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          itemBuilder: (context, index){
                            if(snapshot.data['data'][index]['status'] == 'Canceled'){
                              return PrescrptionList(
                                PerscriptionID: "${snapshot.data['data'][index]['rq_code ']}",
                                id: "${snapshot.data['data'][index]['id']}",
                                note: '${snapshot.data['data'][index]['note']}',
                                status: '${snapshot.data['data'][index]['status']}',);
                            }else{
                              return Center();
                            }
                          }

                      );

                    }else if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: SpinKitCircle(
                          color: customColor.primaryColor,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }else{

                      return Center(
                        child: Text("No Data Found"),
                      );
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

class PrescrptionList extends StatelessWidget {
  final String PerscriptionID, id, status, note;
  PrescrptionList({required this.PerscriptionID, required this.id, required this.status, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Id#: ${PerscriptionID}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),


                Text("Notes: $note",
                  style: TextStyle(
                    fontSize: 15,

                  ),
                ),
                Text("Status: $status",
                  style: TextStyle(
                    fontSize: 15,

                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>CanceledPescriptionDetails(id: id)));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: customColor.cancelColor,
                ),
                child: Text("Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
