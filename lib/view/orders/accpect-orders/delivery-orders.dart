import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
class GoForDelivery extends StatefulWidget {
  const GoForDelivery({Key? key}) : super(key: key);

  @override
  State<GoForDelivery> createState() => _GoForDeliveryState();
}

class _GoForDeliveryState extends State<GoForDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 30),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Customer Info",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                userInfo("Name: Nayon Talukder"),
                Divider(),
                userInfo("Email: nayon.coders@gmail.com"),
                Divider(),
                FlatButton(
                  onPressed: (){

                  },
                  color: Colors.blueAccent,
                  child: Text("Call", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
          ),
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GoForDelivery()));
                      },
                      color: customColor.confirmColor,
                      child: Text("Delivery Complete", style: TextStyle(color: Colors.white),),
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
  Widget userInfo(String? title){
    return Text('${title}',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    );
  }
}
