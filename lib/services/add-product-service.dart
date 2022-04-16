import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddProductService{

  AddProductData(data, pid)async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //Store Data
    var token = localStorage.getString('token');

    var fullUrl = ApiServise.baseUrl+"/admin/requisition/$pid/product/store";
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: {
        'Accept' : 'application/json',
        'Content-Type' : 'application/json',
        'X-Header-Token' : 'base64:KWyE5YqjEnsf0L+9R7unn5QimC8eTW21sm1WalIA2+Y=',
        'Authorization' : 'Bearer $token',
      },
    );
  }

}
