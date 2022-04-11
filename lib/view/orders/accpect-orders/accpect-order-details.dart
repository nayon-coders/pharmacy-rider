import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/accpect-orders.dart';
import 'package:pharmacy_rider_apps/view/orders/accpect-orders/delivery-orders.dart';

class AcpectOrderDetails extends StatefulWidget {
  const AcpectOrderDetails({Key? key}) : super(key: key);

  @override
  State<AcpectOrderDetails> createState() => _AcpectOrderDetailsState();
}

class _AcpectOrderDetailsState extends State<AcpectOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Order Details"),
          backgroundColor: customColor.confirmColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Order Id: MAR38 432838493",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const Text("Date: 22-22-2222 12:22:00 AM",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),


                //user information
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      userInfo("Customer Name: Nayon Talukder"),
                      userInfo("Customer Email: nayon.coders@gmail.com"),
                      userInfo("Phone Number: 01814569747"),
                      userInfo("Phone Number: 01814569747"),
                      userInfo("Customer Address: Nardula, Bhandaria, Pirojpur, Bharisal"),
                    ],
                  ),
                ),

                //product information
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(children: <Widget>[
                      Text("Product Info",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        child: Table(
                          children: [
                            TableRow( children: [
                              Column(children:[Text('Name', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))]),
                              Column(children:[Text('Price', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))]),
                              Column(children:[Text('Quantity', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))]),
                              Column(children:[Text('Total', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))]),
                            ]),
                            TableRow( children: [
                              Column(
                                  children:const [
                                    Text('Javatpoint',
                                      style: TextStyle(
                                          color: customColor.primaryColor
                                      ),),
                                  ]),

                              Column(
                                  children:const [
                                    Text('150.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ]),

                              Column(
                                  children:const [
                                    Text('15',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ]),

                              Column(
                                  children:const [
                                    Text('150.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ]),

                            ]),
                            TableRow( children: [
                              Column(
                                  children:const [
                                    Text('Javatpoint',
                                      style: TextStyle(
                                          color: customColor.primaryColor
                                      ),),
                                  ]),

                              Column(
                                  children:const [
                                    Text('150.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ]),

                              Column(
                                  children:const [
                                    Text('15',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ]),

                              Column(
                                  children:const [
                                    Text('150.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ]),

                            ]),
                            TableRow( children: [
                              Column(
                                  children:const [
                                    Text('Javatpoint',
                                      style: TextStyle(
                                          color: customColor.primaryColor
                                      ),),
                                  ]),

                              Column(
                                  children:const [
                                    Text('150.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ]),

                              Column(
                                  children:const [
                                    Text('15',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ]),

                              Column(
                                  children:const [
                                    Text('150.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ]),

                            ]),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black,),
                    ])
                ),

                //total
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Sub Total:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text("1500.00",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Shipping:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text("150.00",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Total Amount:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text("1500.00",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
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
                      child: Text("Go To Delivery", style: TextStyle(color: Colors.white),),
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
