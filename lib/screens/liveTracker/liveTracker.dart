import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sarpt_app/services/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTracker extends StatefulWidget {
  @override
  _LiveTrackerState createState() => _LiveTrackerState();
}

class _LiveTrackerState extends State<LiveTracker> {
  final AuthService _auth = AuthService();
  GoogleMapController _mapController;
  LatLng _currentLocation;
  Marker _marker;
  Circle _circle;
  var byteData;

  List<LatLng> routes = [
    LatLng(18.4642079, 73.8673244),
    LatLng(18.464613, 73.8687562),
    LatLng(18.4686023, 73.8682365),
    LatLng(18.4689191, 73.8702412),
    LatLng(18.4694269, 73.8702666),
    LatLng(18.4693008, 73.8720674),
    LatLng(18.4712826, 73.8751246),
    LatLng(18.4764863, 73.8739564),
    LatLng(18.4813094, 73.8754862),
    LatLng(18.485879, 73.8889808),
    LatLng(18.4911055, 73.8946903),
    LatLng(18.4989351, 73.8958631),
    LatLng(18.506562, 73.8984728),
    LatLng(18.5066876, 73.897301),
    LatLng(18.5072235, 73.8980782),
    LatLng(18.5231781, 73.8879866),
    LatLng(18.5283075, 73.8853598),
    LatLng(18.5412344, 73.8844315),
    LatLng(18.5448321, 73.8832798),
    LatLng(18.5451566, 73.8836406),
    LatLng(18.5451136, 73.8847774),
    LatLng(18.5587388, 73.9114787),
    LatLng(18.5546899, 73.9151637),
    LatLng(18.5545767, 73.9182618),
    LatLng(18.5551798, 73.9183293),
    LatLng(18.5546826, 73.919872),
    // LatLng(18.557404, 73.928299),
  ];

  // List<Marker> _markers = [];
  // List<Circle> _circles = [];

  // }

  // void updateMarkerAndCircle(LatLng latLong) async {
  //   // LatLng latLong = LatLng(newLocalData.latitude, newLocalData.longitude);
  //   var byteData = await DefaultAssetBundle.of(context).load("assets/images/robot_position_marker.png");
  //   this.setState(() {
  //     _marker = Marker(
  //       markerId: MarkerId("home"),
  //       position: latLong,
  //       // rotation: newLocalData.heading,
  //       draggable: false,
  //       zIndex: 2,
  //       flat: true,
  //       anchor: Offset(0.5, 0.5),
  //       icon: BitmapDescriptor.fromBytes(byteData.buffer.asUint8List()));
  //
  //       _circle = Circle(
  //         circleId: CircleId("homeRadius"),
  //         radius: 2.0,
  //         zIndex: 2,
  //         strokeColor: Colors.green,
  //         center: latLong,
  //         fillColor: Colors.blue.withAlpha(70),
  //     );
  //   });
  // }

  @override
  void initState() {
    _currentLocation = LatLng(18.4642079, 73.8673244);

    _marker = Marker(
      markerId: MarkerId('home'),
      position: _currentLocation,
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: Offset(0.5, 0.5),
    );
    _circle = Circle(
      circleId: CircleId("homeRadius"),
      radius: 10.0,
      zIndex: 2,
      strokeColor: Colors.green,
      strokeWidth: 2,
      center: _currentLocation,
      fillColor: Colors.blue.withAlpha(70),
    );
    super.initState();
  }

  // void setMarkers() async {
  //   int counter = -1;
  //   var byteData = await DefaultAssetBundle.of(context).load("assets/images/robot_position_marker.png");
  //   List<Marker> marker = routes.map((location) {
  //             counter++;
  //             return Marker(
  //                 markerId: MarkerId("marker $counter"),
  //                 position: location,
  //               draggable: false,
  //               zIndex: 2,
  //               flat: true,
  //               anchor: Offset(0.5, 0.5),
  //                 icon: BitmapDescriptor.fromBytes(byteData.buffer.asUint8List())
  //             );
  //           }).toList();
  // }

  // void setCircles() {
  //   int counter = -1;
  //   List<Circle> circles = routes.map((location) {
  //     counter++;
  //     return Circle(
  //                 circleId: CircleId("homeRadius $counter"),
  //                 radius: 2.0,
  //                 zIndex: 2,
  //                 strokeColor: Colors.green,
  //                 center: location,
  //                 fillColor: Colors.blue.withAlpha(70),
  //             );
  //   }).toList();
  // }

  // final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    var byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/robot_position_marker.png");
    setState(() {
      _currentLocation = LatLng(18.4642079, 73.8673244);

      _marker = Marker(
          markerId: MarkerId('home'),
          position: _currentLocation,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(byteData?.buffer?.asUint8List())) ??
          Icon(Icons.home_filled);

      _circle = Circle(
        circleId: CircleId("homeRadius"),
        radius: 10.0,
        zIndex: 2,
        strokeColor: Colors.green,
        strokeWidth: 2,
        center: _currentLocation,
        fillColor: Colors.blue.withAlpha(70),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Inside build current location is: " + _currentLocation.toString());
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
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentLocation,
                  zoom: 15,
                ),
                mapType: MapType.normal,
                // markers: _markers.values.toSet(),
                markers: Set.of((_marker != null) ? [_marker] : []),
                circles: Set.of((_circle != null) ? [_circle] : []),
                // onMapCreated: (GoogleMapController controller) {
                //   _mapController = controller;
                // },
                onMapCreated: _onMapCreated
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () async {
          byteData = await DefaultAssetBundle.of(context)
              .load("assets/images/robot_position_marker.png");
          print("Location searching button pressed");
          for (int i = 0; i < routes.length; i++) {
            print(i.toString() + " Latlong: " + routes[i].toString());

            setState(() {
              _currentLocation = routes[i];
              _marker = Marker(
                  markerId: MarkerId("location $i"),
                  position: _currentLocation,
                  draggable: false,
                  zIndex: 2,
                  flat: true,
                  anchor: Offset(0.5, 0.5),
                  icon: (byteData != null) ? BitmapDescriptor.fromBytes(
                      byteData.buffer.asUint8List()) : Icon(Icons.home)
              );

              _circle = Circle(
                circleId: CircleId("homeRadius $i"),
                radius: 10.0,
                zIndex: 2,
                strokeColor: Colors.green,
                strokeWidth: 5,
                center: _currentLocation,
                fillColor: Colors.green.withAlpha(70),
              );
            });
            sleep(Duration(seconds: 1));
          }
        },
      ),
    );
  }
}
