import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/accpect-order-details.dart';


class AcpectOrders extends StatefulWidget {
  const AcpectOrders({Key? key}) : super(key: key);

  @override
  State<AcpectOrders> createState() => _AcpectOrdersState();
}

class _AcpectOrdersState extends State<AcpectOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Pending Orders List"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10,),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
            OrderList(),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

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
              children: const [
                Text("Order Id: MAR38 432838493",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text("Date: 22-22-2222 12:22:00 AM",
                  style: TextStyle(
                    fontSize: 13,

                  ),
                ),
                Text("Order Status: Accpect",
                  style: TextStyle(
                    fontSize: 15,
                    color: customColor.confirmColor,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>AcpectOrderDetails()));
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



