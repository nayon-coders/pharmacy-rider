import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/UpdatePrescription.dart';
import 'package:pharmacy_rider_apps/services/add-product-service.dart';
import 'package:pharmacy_rider_apps/services/all-product-service.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/auth-useri.dart';
import 'package:pharmacy_rider_apps/view/pescription/add-product/searchproduct.dart';
import 'package:transparent_image/transparent_image.dart';

class Addproduct extends StatefulWidget {
  final String PID;
  const Addproduct( {Key? key, required this.PID}) : super(key: key);

  @override
  _AddproductState createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  bool _isLoding = false;
   late String productId;
  //controller
  TextEditingController _search = TextEditingController();
  List<TextEditingController> _qty = [];
  @override
  Widget build(BuildContext context) {
    AllProduct _allProduct = AllProduct();
    return Scaffold(
      appBar: AppBar(
        title: Text("App Product"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProduct(PresID: widget.PID,)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.green)
                    ),
                    child: const Text("Search Product......")
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15,),


            //show product....
            Expanded(
                child: FutureBuilder(
                  future: _allProduct.fromAllProductList(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot){
                      if(snapshot.hasData){
                          return ListView.builder(
                              itemCount: snapshot.data['data'].length,
                              itemBuilder: (context, index){
                                _qty.add(new TextEditingController());
                                var images = snapshot.data['data'][index]['product_images'][0]["file_path"];
                                String name = snapshot.data['data'].length.toString();
                                String gName = snapshot.data['data'][index]['generic_name'];
                                String brand = snapshot.data['data'][index]['brand']['name'];
                                return ListTile(
                                    leading: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: "${ApiServise.siteUrl+"/"+images}",
                                    ),
                                    title: Text("${name}"),
                                    subtitle: Column(
                                      children: [
                                        Text("Generic name: ${gName}"),
                                        Text("Brand: ${brand}"),
                                        TextFormField(
                                          controller: _qty[index],
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 10),
                                            hintText: "Qty",
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing:  GestureDetector(
                                      onTap: (){
                                        _addProduct(snapshot.data['data'][index]['id'],index);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        color: Colors.green,
                                        child: Icon(Icons.add, color: Colors.white,),
                                      ),
                                    )
                                );
                                return Container();
                              }
                          );

                      }else if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(
                          child: SpinKitCircle(
                            color: customColor.primaryColor,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }else{

                        return const Center(
                          child: Text("No Data Found"),
                        );
                      }
                    }
                )
            ),
          ],
        ),
      ),
    );
  }
   Future<void> _addProduct(ProductId, qty) async {

    print(ProductId);
    print(_qty[qty].text,);

     setState(() {
       _isLoding = true;
     });


     var AddedPro = {
       "product_id":ProductId,
       "quantity":_qty[qty].text,
     };

     try {
       var response = await AddProductService().AddProductData(AddedPro, widget.PID);
       var body = jsonDecode(response.body.toString());
       if(response.statusCode == 200){
         setState(() {
           _isLoding = false;
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             content: Text("Product added Success"),
             backgroundColor: Colors.green,));
         });
       }else{
         print(body['massage']);
       }


     } catch (e, s) {
       print(s);
     }
   }
}


