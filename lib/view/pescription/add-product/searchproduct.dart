import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_rider_apps/Utility/colors.dart';
import 'package:pharmacy_rider_apps/services/add-product-service.dart';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/services/search-product-searvice.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchProduct extends StatefulWidget {
  final String PresID;
  const SearchProduct({Key? key, required this.PresID}) : super(key: key);

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  late String productId;
  //controller
  TextEditingController _searchByName = TextEditingController();
  TextEditingController _searchByCategory = TextEditingController();
  final List<TextEditingController> _qty = [];
  @override
  Widget build(BuildContext context) {
    SearchProductByname _searchProductByname = SearchProductByname();
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Product"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(

                    onChanged: (value){
                      setState(() {

                      });
                    },
                    controller: _searchByName,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: "Search Product....",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1,),
                        ),
                        prefixIcon: Icon(Icons.shopping_cart),

                    ),
                  ),
                ),
                 const SizedBox(width: 5,),
                 Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 15,),


            //show product....
            Expanded(
                child: FutureBuilder(
                    future: _searchProductByname.fromSearchProductAPIs(_searchByName.text.toString()),
                    builder: (context, AsyncSnapshot<dynamic> snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index){
                              String gName;
                              var images;
                              String name;
                              String brand;
                              _qty.add(TextEditingController());
                              if(snapshot.data['data'][index]['product_images'][0]["file_path"] != null){
                                images = snapshot.data['data'][index]['product_images'][0]["file_path"];
                              }else{
                                images = "N/A";
                              }
                              if(snapshot.data['data'][index]['name'] != null){
                                name = snapshot.data['data'][index]['name'];
                              }else{
                                name = "N/A";
                              }
                              if(snapshot.data['data'][index]['generic_name'] != null){
                                gName =snapshot.data['data'][index]['generic_name'];
                              }else{
                                 gName = "N/A";
                              }
                              if(snapshot.data['data'][index]['brand']['name'] != null){
                                brand =snapshot.data['data'][index]['brand']['name'];
                              }else{
                                brand = "N/A";
                              }


                              if(_searchByName.text.isNotEmpty){
                                return ListTile(
                                    leading: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: ApiServise.siteUrl+"/"+images,
                                    ),
                                    title: Text("$name"),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Generic name: $gName" ),
                                        Text("Brand: $brand"),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _qty[index],
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(left: 10),
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
                                        child: const Icon(Icons.add, color: Colors.white,),
                                      ),
                                    )
                                );
                              }else{
                                return Center();
                              }


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
    });

    var AddedPro = {
      "product_id":ProductId,
      "quantity":_qty[qty].text,
    };
    try {
      var response = await AddProductService().AddProductData(AddedPro, widget.PresID);
      var body = jsonDecode(response.body.toString());
      if(response.statusCode == 200){
        setState(() {
          _qty[qty].clear();
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


