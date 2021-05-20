import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sarpt_app/screens/forum/forum.dart';
import 'package:sarpt_app/screens/home/TemperatureDisplay.dart';
import 'package:sarpt_app/screens/home/humidityDisplay.dart';
import 'package:sarpt_app/screens/home/phMeter.dart';
import 'package:sarpt_app/screens/home/waterLevelDisplay.dart';
import 'package:sarpt_app/services/auth.dart';
import 'package:sarpt_app/screens/liveTracker/liveTracker.dart';
import 'package:sarpt_app/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int tabIndex = 2;
  double ph, temperature, humidity, soilMoisture;

  @override
  void initState() {
    getParameterInfo();
    super.initState();
  }

  void getParameterInfo() async {
    final User user = await FirebaseAuth.instance.currentUser;
    print(user.uid + " " + user.email);

    List<double> farmParameters = await DatabaseService(user: user).getParameterData();
    print("Farm parameters: $farmParameters");
    setState(() {
      ph = farmParameters[0]??7.0;
      temperature = farmParameters[1]??38.0;
      humidity = farmParameters[2]??52.0;
      soilMoisture = farmParameters[3]??35.0;
    });
  }

  void moveToYoutube() async {
    const String url = "https://www.youtube.com/results?search_query=How+to+improve+Indian+farming+in+Hindi";
    if(await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(url, universalLinksOnly: true);

      if(!nativeAppLaunchSucceeded) {
        await launch(url, forceWebView: true);
      }
    }
  }

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
                    ph: ph??7.0,
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
                        WaterLevelDisplay(moisturePercentage: soilMoisture??35,),
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
                        ThermometerDisplay(temperatureValue: temperature??38.0,),
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
                  HumidityDisplay(humidity: humidity??52.0,),
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
          if(i == 0) {
            print("Learn more tab");
            moveToYoutube();
          } else if(i == 1) {
            print("Moving to forum screen");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForumScreen(youtubeNavigation: moveToYoutube)));
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
