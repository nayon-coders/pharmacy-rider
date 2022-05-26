import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/order-details.drart.dart';

class orderDetails extends StatelessWidget {
  final String OrderId;
  const orderDetails({Key? key, required this.OrderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderService _orderService = OrderService();
    return FutureBuilder(
        future: _orderService.fromOrdersDetails("${OrderId}"),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            var orderId, date, name, email, number, address, shipping, total;

            //order number
            if(snapshot.data['data']['order_number '] != null){
              orderId = snapshot.data['data']['order_number '];
            }else{
              orderId = "N/A";
            }

            //check date
            if(snapshot.data['data']['date'] != null){
              date = snapshot.data['data']['date'];
            }else{
              date = "N/A";
            }
            //name
            if(snapshot.data['data']['name'] != null){
              name = snapshot.data['data']['name'];
            }else{
              name = "N/A";
            }

            //email
            if(snapshot.data['data']['email'] != null){
              email = snapshot.data['data']['email'];
            }else{
              email = "N/A";
            }
            //number
            if(snapshot.data['data']['phone'] != null){
              number = snapshot.data['data']['phone'];
            }else{
              number = "N/A";
            }
            //number
            if(snapshot.data['data']['address'] != null){
              address = snapshot.data['data']['address'];
            }else{
              address = "N/A";
            }

            //shipping
            if(snapshot.data['data']['shipping'] != null){
              shipping = snapshot.data['data']['shipping'];
            }else{
              shipping = "N/A";
            }

            //total
            if(snapshot.data['data']['amount'] != null){
              total = snapshot.data['data']['amount'];
            }else{
              total = "N/A";
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Id: $orderId",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text("Date: $date",
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),

                //user information
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text("Customer Info",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      userInfo("Customer Name: $name"),
                      userInfo("Customer Email: $email"),
                      userInfo("Phone Number: $number"),
                      userInfo("Customer Address: $address"),
                    ],
                  ),
                ),

                const SizedBox(height: 30,),
                //product information
                const Center(
                  child: Text("Product Info",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                ///show all order product list
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Text("Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          )
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: const Center(
                        child: Text("Price",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: const Center(
                        child: Text("Quantity",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: const Center(
                        child: Text("Total",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )
                        ),
                      ),
                    ),


                  ],
                ),
                ///show all order product list
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data['data']['order_products '].length,

                    itemBuilder: (context,index){
                      var productName;
                      var price;
                      var qty;
                      var total;

                      var productlist = snapshot.data['data']['order_products '][index];

                      if(productlist['product_name'] != null){
                        productName = productlist['product_name'];
                      }else{
                        productName = "N/A";
                      }

                      //price
                      if(productlist['price'] != null){
                        price = productlist['price'];
                      }else{
                        price = "N/A";
                      }
                      //qty
                      if(productlist['quantity'] != null){
                        qty = productlist['quantity'];
                      }else{
                        qty = "N/A";
                      }

                      //qty
                      if(productlist['total'] != null){
                        total = productlist['total'];
                      }else{
                        total = "N/A";
                      }

                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(productName.toString(),
                                style: const TextStyle(
                                  color: customColor.primaryColor,
                                  fontSize: 12,
                                )
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(
                              child: Text(price.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(
                              child: Text(qty.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(
                              child: Text(total.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  )
                              ),
                            ),
                          ),


                        ],
                      );
                    }),
                ///show all order product list

                Divider(color: Colors.grey, height: 2,),
                //total
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Shipping:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(shipping,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    const Text("Total Amount:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(total,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            );

          }else if(snapshot.connectionState == ConnectionState.waiting){
            return  const Padding(
              padding: EdgeInsets.only(top: 150),
              child: SpinKitCircle(
                color: customColor.primaryColor,
                duration: Duration(seconds: 1),
              ),
            );
          }else{
            return  const Padding(
              padding: EdgeInsets.only(top: 150),
              child: Center(child: Text("No Data Found")),
            );
          }
        }
    );
  }
  Widget userInfo(String? title){
    return Text('${title}',
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    );
  }
}
