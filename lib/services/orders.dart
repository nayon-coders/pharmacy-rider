import 'dart:convert';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:pharmacy_rider_apps/view/orders/pending-orders/pending-order-details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AllOrders{
  var AllData;
  Future<void>fromOrders()async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //Store Data
    var token = localStorage.getString('token');

    var url = Uri.parse(ApiServise.orders);
    final response = await http.get(url,
      headers: {
        'Accept' : 'application/json',
        'Content-Type' : 'application/json',
        'X-Header-Token' : 'base64:KWyE5YqjEnsf0L+9R7unn5QimC8eTW21sm1WalIA2+Y=',
        'Authorization' : 'Bearer $token',
      },
    );

    if(response.statusCode == 200){
      AllData = jsonDecode(response.body.toString());
      print(AllData);
     return AllData;

    }else{
      throw Exception("Error");
    }
  }


}