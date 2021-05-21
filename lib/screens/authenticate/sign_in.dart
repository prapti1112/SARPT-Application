import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sarpt_app/services/auth.dart';
import 'package:sarpt_app/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  String _password = '', error = '';
  bool _isPasswordVisible = false, loading = false;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() {}) );
  }

  @override
  Widget build(BuildContext context) {
    return (loading) ? Loading() : Scaffold(
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
            key: _formKey,
            child: SingleChildScrollView(
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
                    child: TextFormField(
                      validator: (value) => (value.isNotEmpty && (!value.contains("@") || !value.contains("."))) ?  "Enter a valid email" : null,
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
                      validator: (value) => (value.length < 6) ?  "Enter a password 6+ chars long" : null,
                      decoration: InputDecoration(
                        labelText: "Robot Code",
                        hintText: "Your password ....",
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        suffixIcon: IconButton(
                          icon: _isPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () =>
                              setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      obscureText: !_isPasswordVisible,
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
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          setState(() => loading = true );
                          print("Email: ${_emailController.text}");
                          print("Password: ${_password}");
                          dynamic result = await _auth.signInWithEmailAndPassword(_emailController.text, _password);
                          if(result == null) {
                            setState(() {
                              error = "Couldn't sign in with these credentials";
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                    child: Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),
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
      ),
    );
  }
}
