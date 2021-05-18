import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sarpt_app/screens/home/TemperatureDisplay.dart';
import 'package:sarpt_app/screens/home/humidityDisplay.dart';
import 'package:sarpt_app/screens/home/phMeter.dart';
import 'package:sarpt_app/screens/home/waterLevelDisplay.dart';
import 'package:sarpt_app/services/auth.dart';
import 'package:sarpt_app/screens/liveTracker/liveTracker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        // color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 130.0,
              margin: const EdgeInsets.only(top: 8.0, bottom: 0.0),
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ph Meter",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  //  ph meter widget
                  PhMeter(
                    ph: 8.0,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              // color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 200.0,
                    width: 150.0,
                    // color: Colors.green,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Soil Moisture",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        WaterLevelDisplay(),
                      ],
                    ),
                  ),
                  Container(
                    height: 200.0,
                    width: 150.0,
                    // color: Colors.blueAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Temperature",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ThermometerDisplay(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180.0,
              // color: Colors.greenAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Humidity",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  HumidityDisplay(),
                  // Image.asset("assets/images/humidity.png", scale: 3,),
                ],
              ),
            ),
            Container(
              height: 100.0,
              // color: Colors.grey,
              child: Center(
                child: InkWell(
                  onTap: () {
                    print("Navigating to the google tracking screen.....");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LiveTracker()));
                  },
                  child: Card(
                    elevation: 5.0,
                    color: Colors.grey[100],
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/maps.png",
                          scale: 0.5,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              "Live Location",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                height: 40.0,
                                width: 240,
                                child: Text(
                                  "Track your SARPF robot from home",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  softWrap: true,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // margin: const EdgeInsets.only(bottom: 8.0),
            ),
          ],
        ),
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
        },
      ),
    );
  }
}
