import 'package:flutter/material.dart';
import 'package:sarpt_app/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("SPARF App"),
          backgroundColor: Colors.green,
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () async {
                //  Sign Out
                  await _auth.SignOut();
                },
            ),
          ],
        ),
        body: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
