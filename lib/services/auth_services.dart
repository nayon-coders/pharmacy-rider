import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';
class Auth{
  static Future<http.Response> login(String email, String pass) async{

   Map data = {
     'email' : email,
     'passwotrd' : pass,
   };
  var body = json.encode(data);
  var url = Uri.parse(BaseUrl+'/login');
  http.Response response = await http.post(
    url,
    body: body,
    headers: headers,
  );
  print(response.body);
return response;
  }
}