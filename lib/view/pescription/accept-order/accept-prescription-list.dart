import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/prescription-service.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-order-details.dart';
import 'package:pharmacy_rider_apps/view/pescription/accept-order/accept-prescription-details.dart';
import 'package:pharmacy_rider_apps/view/pescription/pending-pescription/pending-prescription-details.dart';
import 'package:sizer/sizer.dart';

class AcceptPrescriptionList extends StatefulWidget {
  const AcceptPrescriptionList({Key? key}) : super(key: key);

  @override
  _AcceptPrescriptionListState createState() => _AcceptPrescriptionListState();
}

class _AcceptPrescriptionListState extends State<AcceptPrescriptionList> {
  @override
  Widget build(BuildContext context) {
    PrescriptionService _rescriptionService = PrescriptionService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accept Prescription"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: _rescriptionService.formPrescriptionServiceList(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          itemBuilder: (context, index){
                            if(snapshot.data['data'][index]['status'] == 'Confirmed'){
                              return PrescrptionList(
                                PerscriptionID: "${snapshot.data['data'][index]['rq_code ']}",
                                id: "${snapshot.data['data'][index]['id']}",
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
  final String PerscriptionID, id, status;
  PrescrptionList({required this.PerscriptionID, required this.id, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Id#: ${PerscriptionID}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),

                  Text("Status: $status",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: customColor.confirmColor

                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>AcceptPrescriptionDetails( id: id,)));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: customColor.confirmColor,
                ),
                child: Text("Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
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
