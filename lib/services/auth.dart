import 'package:shared_preferences/shared_preferences.dart';
class Auth{
   getToken()async{
    //create instance
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //Store Data
    var token = localStorage.getString('token');
    return token;
  }
}