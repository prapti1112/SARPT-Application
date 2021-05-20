import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sarpt_app/screens/home/home.dart';
import 'package:sarpt_app/screens/liveTracker/liveTracker.dart';
import 'package:sarpt_app/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

class ForumScreen extends StatefulWidget {
  Function youtubeNavigation;

  ForumScreen({this.youtubeNavigation});

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {

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
            icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.green[100],),
            label: Text("Shop", style: TextStyle(color: Colors.green[100]),),
            onPressed: () async {
              //  launch the website in browser
              const String url = "http://enroot.3hundredsolutions.tech/index.html";

              if(await canLaunch(url)) {
                await launch(url, forceWebView: false);
              } else {
                throw "Couldn't launch the $url";
              }
            },
          ),

          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.green[100],),
            label: Text("Logout", style: TextStyle(color: Colors.green[100]),),
            onPressed: () async {
              //  Sign Out
              await _auth.SignOut();
            },
          ),

        ],
      ),
      body: Center(
        child: Text("Forum Screen", style: TextStyle(fontSize: 24),),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(
            icon: ImageIcon(
              new AssetImage("assets/images/learn.png"),
              color: (tabIndex == 0) ? Colors.green : Colors.white,
            ),
          ),
          TabItem(icon: Icons.message_rounded),
          TabItem(icon: Icons.location_on),
        ],
        curve: Curves.decelerate,
        backgroundColor: Colors.green,
        initialActiveIndex: 1,
        onTap: (int i) {
          print('click index=$i');
          setState(() => tabIndex = i);
          if(i == 0) {
            print("Learn more tab");
            widget.youtubeNavigation();
          } else if(i == 1) {
            print("Moving to forum screen");
          } else {
            print("Finding the robot location");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LiveTracker()));
          }
        },
      ),
    );
  }
}
