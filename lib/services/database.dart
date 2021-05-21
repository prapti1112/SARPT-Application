import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sarpt_app/models/user.dart';

import '';

class DatabaseService {
  final  User user;

  DatabaseService({ this.user });

   // collection reference
  final userReference = FirebaseDatabase.instance.reference();

  //  adding  user information when they register
  Future setInitialUserData(String phoneNumber, String address) async {
    return await userReference.child("Users").child(user.uid).set(
        {'phoneNumber': phoneNumber, "address": address, 'email': user.email});
  }

  Future<List<double>> getParameterData() async {
    List<double> params = [];
    DataSnapshot snapshot = await userReference.child("Users").child(user.uid).once();
    print("Data recieved: ${snapshot.value}");
    params = [(snapshot.value['ph']??7.0).toDouble(), (snapshot.value['temperature']??38.0).toDouble(), (snapshot.value['Humidity']??52.0).toDouble(), (snapshot.value['soil_moisture']??35.0).toDouble()];
    return params;
  }
}