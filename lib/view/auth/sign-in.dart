import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Utility/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth-useri.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>  with TickerProviderStateMixin {
  //controller
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  //global form key
  final GlobalKey<FormState> _loginuser = GlobalKey<FormState>();

  //is login
  bool isLogin = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this)..repeat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _loginuser,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo.png", height: 100, width: 100,),
                const Text("Pharmacy Rider",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: customColor.primaryColor,
                  ),
                ),

                const SizedBox(height: 20,),
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return "Email field is required";
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _pass,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.vpn_key),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return "Password field is required";
                    }else{
                      return null;
                    }
                  },
                ),

                const SizedBox(height: 10,),

                GestureDetector(
                  onTap: () {
                    if(_loginuser.currentState!.validate()){
                      _login();
                    }

                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    decoration: BoxDecoration(
                      color:customColor.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: isLogin != true
                          ?  Text(
                            "Login",
                            style: TextStyle(
                                color: customColor.whiteText,
                                fontWeight: FontWeight.w600,
                                fontSize: 20
                            ),
                          )
                          :  Center(
                          child:  SpinKitCircle(
                          color: Colors.white,
                          duration: Duration(seconds: 1),
                        ),
                      )
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  void _login() async{
    setState(() {
      isLogin = true;
    });

    var data = {
      'email' : _email.text,
      'password' : _pass.text,
    };

    var response = await CallApi().postData(data, '/login');
    var body = jsonDecode(response.body);
    if(response.statusCode == 200){
      //create instance
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      //Store Data
       localStorage.setString('token', body['access_token']);
       localStorage.setString('user', jsonEncode(body['user']));
       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(body['message']), backgroundColor: Colors.redAccent,),
      );
    }

    setState(() {
      isLogin =false;
    });


  }
}
