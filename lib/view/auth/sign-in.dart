import 'package:flutter/material.dart';
import 'package:pharmacy_rider_apps/view/home-screen/home-screen.dart';
import '../../Utility/colors.dart';
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
                      enabledBorder: OutlineInputBorder(
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
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                ),

                SizedBox(height: 10,),

                GestureDetector(
                  onTap: (){
                    Loginuser(_email.text, _pass.text);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: customColor.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
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
  void Loginuser(String email, String pass){
    Map crads = {
      "email" : _email.text,
      "password": _pass.text,
    };
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }
}
