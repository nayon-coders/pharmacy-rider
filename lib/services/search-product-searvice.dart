import 'dart:convert';
import 'package:pharmacy_rider_apps/services/api-service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SearchProductByname{
  var SearchAllData;
  Future<void>fromSearchProductAPIs(String productName)async {
    print(productName);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //Store Data
    var token = localStorage.getString('token');

    var url = Uri.parse(ApiServise.SarchProduct+"?product="+productName);
    final response = await http.get(url,
      headers: {
        'Accept' : 'application/json',
        'Content-Type' : 'application/json',
        'X-Header-Token' : 'base64:KWyE5YqjEnsf0L+9R7unn5QimC8eTW21sm1WalIA2+Y=',
        'Authorization' : 'Bearer $token',
      },
    );

    if(response.statusCode == 200){
      SearchAllData = jsonDecode(response.body.toString());


      return SearchAllData;

    }else{
      print("some error");
    }


  }


}