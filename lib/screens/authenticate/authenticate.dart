import 'package:flutter/material.dart';
import 'package:sarpt_app/screens/authenticate/register.dart';
import 'package:sarpt_app/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  
  bool showSignIn= true;

  toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (showSignIn) ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView),
      // child: Center(child: Text("Authenticate")),
    );
  }
}
