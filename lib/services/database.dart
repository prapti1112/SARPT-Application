import 'package:firebase_database/firebase_database.dart';

import '';

class DatabaseService {
  final String uid;

  DatabaseService({ this.uid });

   // collection reference
  final userReference = FirebaseDatabase.instance.reference();

  //  adding  user information when they register
  Future setInitialUserData(String phoneNumber, String address) async {
    return await userReference.child("Users").child(uid).set(
        {'phoneNumber': phoneNumber, "address": address});
  }
}