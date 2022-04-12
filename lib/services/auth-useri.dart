import 'dart:convert';
import 'package:http/http.dart' as http;
class CallApi{
  final String BaseUrl = "https://apps.piit.us/my-pharmacy/api/v1";

  postData(data, apiUrl)async{
    var fullUrl = BaseUrl+apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }


  _setHeaders()=>{
    'Accept' : 'application/json',
    'Content-Type' : 'application/json',
    'X-Header-Token' : 'base64:KWyE5YqjEnsf0L+9R7unn5QimC8eTW21sm1WalIA2+Y=',
  };
}
