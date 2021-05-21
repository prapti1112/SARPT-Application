import 'package:flutter/material.dart';
import 'package:sarpt_app/services/auth.dart';
import 'package:sarpt_app/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  String _password = '', error = '';
  List<bool> _isPasswordVisible = [false, false];
  bool loading = false;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return (loading) ? Loading() :Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          height: 650,
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
                    height: 32,
                  ),
                  Text(
                    "Sign Up",
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
                      validator: (value) => (value.isEmpty ||
                              !(value.contains("@") && value.contains(".")))
                          ? "Enter a valid email"
                          : null,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "name@example.com",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.green,
                        prefixIcon: Icon(
                          Icons.mail,
                        ),
                        suffixIcon: (_emailController.text.isEmpty)
                            ? Container(
                                width: 0,
                              )
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
                    height: 16.0,
                  ),
                  SizedBox(
                    width: 295,
                    child: TextFormField(
                      onChanged: (value) =>
                          setState(() => this._password = value),
                      validator: (value) => (value.length < 6)
                          ? "Enter a password 6+ chars long"
                          : null,
                      decoration: InputDecoration(
                        labelText: "Robot Code",
                        hintText: "Your password ....",
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: _isPasswordVisible[0]
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () => setState(() =>
                              _isPasswordVisible[0] = !_isPasswordVisible[0]),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      obscureText: !_isPasswordVisible[0],
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: 295,
                    child: TextFormField(
                      validator: (value) => (value != _password)
                          ? "Passwords do not match"
                          : null,
                      decoration: InputDecoration(
                        labelText: "Confirm Robot Code",
                        hintText: "Your password ....",
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: _isPasswordVisible[1]
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () => setState(() =>
                              _isPasswordVisible[1] = !_isPasswordVisible[1]),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      obscureText: !_isPasswordVisible[1],
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: 295,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        prefix: Text("+91 "),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.green,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: 295,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Address",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.green,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      minLines: 3,
                      maxLines: 5,
                    ),
                  ),
                  SizedBox(
                    height: 42.0,
                  ),
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: RaisedButton(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      shape: StadiumBorder(),
                      color: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          print("Email: ${_emailController.text}");
                          print("Password: ${_password}");
                          print("Phone Number: ${_phoneNumberController.text}");
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  _emailController.text, _password, _phoneNumberController.text, _addressController.text);
                          if (result == null && mounted) {
                            setState(() {
                              error = "Please supply a valid email";
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                    child: Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? Sign In "),
                      InkWell(
                        child: Text(
                          "here",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onTap: () {
                          print("Navigating to the sign in screen");
                          //  navigate to SignIn screen
                          widget.toggleView();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
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
