import 'dart:convert';

import 'package:http/http.dart' as http;
class CallApi{
  final String _url = "https://apps.piit.us/my-pharmacy/api/v1";

  postData(data, apiUrl)async{
    var fullUrl = _url+apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }


  _setHeaders()=>{
    'Content-type' : 'Application/json',
    'Accept' : 'Application/json',
  };
}
