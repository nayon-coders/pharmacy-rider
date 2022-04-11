import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/services/auth_services.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import '../../Utility/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //controller
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  //global form key
  final GlobalKey<FormState> _loginuser = GlobalKey<FormState>();

  //is login
  bool _isLogin = false;
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
                ),

                const SizedBox(height: 10,),

                GestureDetector(
                  onTap: (){
                    _login();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color:  _isLogin != true? customColor.primaryColor:Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        _isLogin != true ? "Login" : "Loading...",
                        style: TextStyle(
                            color: customColor.whiteText,
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                        ),
                      ),
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

    http.Response response = await Auth.login(_email.text, _pass.text);
    Map responseMap = jsonDecode(response.body);
    if(response.statusCode == 200){
      print('login success');
    }else{
      print("login faild");
    }

  }
}
