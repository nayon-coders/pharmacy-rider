import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pie_chart/pie_chart.dart';

class PeiChartWidget extends StatelessWidget {
  const PeiChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllOrders _allOrders = AllOrders();
    return  FutureBuilder(
        future: _allOrders.fromOrders(),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            double Plength = 0;
            double Alength = 0;
            double Dlength = 0;
            double Clength = 0;
            for(var i = 0; i<snapshot.data['data'].length; i ++ ){
              if(snapshot.data['data'][i]['status'] == 'Pending'){
                Plength += 1;
              }if(snapshot.data['data'][i]['status'] == 'Processing'){
                Alength += 1;
              }if(snapshot.data['data'][i]['status'] == 'Delivered'){
                Dlength += 1;
              }if(snapshot.data['data'][i]['status'] == 'Canceled'){
                Clength += 1;
              }
            }
            return PieChart(
              dataMap:  {
                "Pending" : Plength,
                "Accept" : Alength,
                "Canceled" : Dlength,
                "Delivered" : Clength,
              },
              colorList: const [
                customColor.pendingColor,
                Colors.green,
                customColor.confirmColor,
                customColor.cancelColor,
              ],
              animationDuration: const Duration(seconds: 1),
              chartType: ChartType.ring,
              chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
              ),
            );
          }else if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitCircle(
                color: customColor.primaryColor,
                duration: Duration(seconds: 1),
              ),
            );
          }else{
            return Center(child: const Text("No Data"),);
          }
        }
    );
  }
}
