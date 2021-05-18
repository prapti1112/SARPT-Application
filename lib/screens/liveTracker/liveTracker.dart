import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sarpt_app/services/auth.dart';

class LiveTracker extends StatefulWidget {
  @override
  _LiveTrackerState createState() => _LiveTrackerState();
}

class _LiveTrackerState extends State<LiveTracker> {

  final AuthService _auth = AuthService();
  int tabIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        child: Center(
          child: Text("Tracker"),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: ImageIcon(new AssetImage("assets/images/learn.png"),
            color: (tabIndex == 0) ? Colors.green : Colors.white,
          ),
          ),
          TabItem(icon: Icons.message_rounded),
          TabItem(icon: Icons.location_on),
        ],
        curve: Curves.decelerate,
        backgroundColor: Colors.green,
        initialActiveIndex: 1,
        onTap: (int i)  {
          print('click index=$i');
          setState(() => tabIndex = i);
        },
      ),
    );
  }
}
