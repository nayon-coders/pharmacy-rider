import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/orders.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/accpect-orders.dart';
import 'package:pharmacy_rider_apps/view/orders/cancle/cancel-order-list.dart';
import 'package:pharmacy_rider_apps/view/orders/delivery-order/delivery-orders-list.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-orders.dart';

import 'DashboardBox.dart';

class OrderLengthRows extends StatelessWidget {
  const OrderLengthRows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllOrders _allOrders = AllOrders();
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // pending orders count
            Expanded(
                flex: 2,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>PendingOrders()));
                  },
                  child: FutureBuilder(
                      future: _allOrders.fromOrders(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot){
                        if(snapshot.hasData){
                          double length = 0;
                          for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                            if(snapshot.data['data'][i]['status'] == 'Pending'){
                              length += 1;
                            }
                          }
                          return DashboardBox(length.toInt(), "Pending", customColor.pendingColor);
                        }else if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child:
                          SizedBox( width: 30, height: 30, child: CircularProgressIndicator()));
                        }else{
                          return DashboardBox(0, "Pending", customColor.pendingColor);
                        }

                      }
                  ),
                )
            ),


            SizedBox(width: 10,),
            //processing order count
            Expanded(
                flex: 2,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>acpectOrders()));
                  },
                  child: FutureBuilder(
                      future: _allOrders.fromOrders(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot){
                        if(snapshot.hasData){
                          double length = 0;
                          for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                            if(snapshot.data['data'][i]['status'] == 'Processing'){
                              length += 1;
                            }
                          }
                          return DashboardBox(length.toInt(), "Accept", Colors.green);
                        }else if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child:
                          SizedBox( width: 30, height: 30, child: CircularProgressIndicator()));
                        }else{
                          return DashboardBox(0, "Pending", customColor.pendingColor);
                        }

                      }
                  ),
                )
            ),

          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //confirmed order count
            Expanded(
                flex: 2,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryOrdersList()));
                  },
                  child: FutureBuilder(
                      future: _allOrders.fromOrders(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot){
                        if(snapshot.hasData){
                          double length = 0;
                          for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                            if(snapshot.data['data'][i]['status'] == 'Delivered'){
                              length += 1;
                            }
                          }
                          return DashboardBox(length.toInt(), "Delivered", customColor.confirmColor);
                        }else if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child:
                          SizedBox( width: 30, height: 30, child: CircularProgressIndicator()));
                        }else{
                          return DashboardBox(0, "Delivered", customColor.confirmColor);
                        }

                      }
                  ),
                )
            ),


            SizedBox(width: 10,),
            //cancel order count
            Expanded(
                flex: 2,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CancelOrdersList()));
                  },
                  child: FutureBuilder(
                      future: _allOrders.fromOrders(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot){
                        if(snapshot.hasData){
                          double length = 0;
                          for(var i = 0; i<snapshot.data['data'].length; i ++ ){
                            if(snapshot.data['data'][i]['status'] == 'Canceled'){
                              length += 1;
                            }
                          }
                          return DashboardBox(length.toInt(), "Canceled", customColor.cancelColor);
                        }else if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child:
                          SizedBox( width: 30, height: 30, child: CircularProgressIndicator()));
                        }else{
                          return DashboardBox(0, "Canceled", customColor.cancelColor);
                        }

                      }
                  ),
                )
            ),
          ],
        ),
      ],
    );
  }
}
