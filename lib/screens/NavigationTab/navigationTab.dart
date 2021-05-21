import 'package:flutter/material.dart';
import 'package:sarpt_app/screens/home/home.dart';
import 'package:sarpt_app/screens/liveTracker/liveTracker.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationTab extends StatelessWidget {

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
    return Container(
      color: Colors.green[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: SizedBox(
              width: 240,
              height: 50,
              child: RaisedButton(
                color: Colors.green,
                child: Text("Home", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
                  onPressed: () {
                    print("Navigating to home");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: SizedBox(
              width: 240,
              height: 50,
              child: RaisedButton(
                  color: Colors.green,
                  child: Text("Robot Location", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
                  onPressed: () {
                    print("Navigating to live location");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LiveTracker()));
                    }
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
              child: SizedBox(
                width: 240,
                height: 50,
                child: RaisedButton(
                    color: Colors.green,
                    child: Text("Learn", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
                    onPressed: () {
                      print("Navigating to youtube");
                      moveToYoutube();
                    }
                ),
              ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: SizedBox(
              width: 240,
              height: 50,
              child: RaisedButton(
                  color: Colors.green,
                  child: Text("Shop", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
                  onPressed: () async {
                    print("Navigating to shopping");

                    const String url = "http://enroot.3hundredsolutions.tech/index.html";

                    if(await canLaunch(url)) {
                      await launch(url, forceWebView: false);
                    } else {
                      throw "Couldn't launch the $url";
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
