import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sarpt_app/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _emailController = TextEditingController();
  String _password = '';
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() {}) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          height: 450,
          width: 350,
          // color: Colors.greenAccent,
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 55,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      color: Colors.black,
                      fontSize: 34,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 295,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "name@example.com",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.green,
                      prefixIcon : Icon(Icons.mail,),
                      suffixIcon: (_emailController.text.isEmpty)
                          ? Container(width: 0,)
                          : IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => _emailController.clear(),
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      // enabledBorder:
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: 295,
                  child: TextFormField(
                    onChanged: (value) => setState(() => this._password = value),
                    // validator: (value) => (value.toString().isEmpty) ?  "Enter a password" : "",
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Your password ....",
                      // errorText: (_password.isEmpty) ?  "Enter a password" : "",
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      suffixIcon: IconButton(
                        icon: _isPasswordVisible
                            ? Icon(Icons.visibility_off, color: Colors.green,)
                            : Icon(Icons.visibility , color: Colors.green,),
                        onPressed: () =>
                            setState(() => _isPasswordVisible = !_isPasswordVisible),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    obscureText: _isPasswordVisible,
                  ),
                ),
                SizedBox(
                  height: 42.0,
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: RaisedButton(
                    child: Text("Sign In", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    shape: StadiumBorder(),
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textColor: Colors.white,
                    onPressed: () {
                      print("Email: ${_emailController.text}");
                      print("Password: ${_password}");
                    //  Call the function to sign in
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? Sign Up "),
                    InkWell(
                        child: Text("here", style: TextStyle(color: Colors.blueAccent),),
                        onTap: () {
                          //  navigate to Register screen
                          widget.toggleView();
                        },
                    ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
