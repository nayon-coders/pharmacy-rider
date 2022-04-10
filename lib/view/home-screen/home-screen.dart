import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-orders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Home top bar
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:  Image.asset("assets/images/user.jpg", height: 40, width: 40,),
                              ),
                              const SizedBox(width: 10,),
                              const Text("Nayon Talukder",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  fontSize: 22,
                                ),),
                            ],
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.logout, size: 30,)
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),
                  //Dashboard text
                  const Text("Orders",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>const PendingOrders()));
                            },
                            child: DashboardBox("20", "Pending", customColor.pendingColor),
                          )
                      ),


                      SizedBox(width: 10,),
                      Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: (){},
                            child: DashboardBox("1", "Processing", customColor.processingColor),
                          )
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: (){},
                            child: DashboardBox("1", "Confirm", customColor.confirmColor),
                          )
                      ),


                      SizedBox(width: 10,),
                      Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: (){},
                            child: DashboardBox("1", "Cancle", customColor.cancelColor),
                          )
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),
                  //Order reports....
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Order Reports",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Icon(Icons.report, color: Colors.deepOrangeAccent,)
                        ],
                      ),
                    ),
                  ),



                  //Recreation
                  const SizedBox(height: 10,),
                  //Recreation text
                  const Text("Recreations",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){},
                            child: DashboardBox("1", "Pending", customColor.pendingColor),
                          )
                      ),


                      SizedBox(width: 10,),
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){},
                            child: DashboardBox("1", "Processing", customColor.processingColor),
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: (){},
                            child: DashboardBox("1", "Confirm", customColor.confirmColor),
                          )
                      ),


                      SizedBox(width: 10,),
                      Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: (){},
                            child: DashboardBox("1", "Cancle", customColor.cancelColor),
                          )
                      ),
                    ],
                  ),

                ],
              ),
            ),
      ),
    );
  }
}


class DashboardBox extends StatelessWidget {
  String Number;
  String Value;
  dynamic color;
  DashboardBox(this.Number, this.Value, this.color);
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(Number,
                style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(Value,
                style:const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 10,),
              const Align(
                alignment: Alignment.bottomRight,
                child:Text("View",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
