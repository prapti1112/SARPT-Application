import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sarpt_app/models/user.dart';
import 'package:sarpt_app/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

//  Create a custom user object from Firebase user
  CustomUser _userFromFirebaseUser(User user) {
    return user != null ? CustomUser(uid: user.uid, phoneNumber: user.phoneNumber) : null;
  }

  //  Auth change user stream
  Stream<CustomUser> get user {
      return _auth.authStateChanges()
      .map(_userFromFirebaseUser);
  }

  //  Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return _userFromFirebaseUser(result.user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password, String phoneNumber,String address) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      //creating a record of the user in the database
      await DatabaseService(user: result.user).setInitialUserData(phoneNumber, address);

      return _userFromFirebaseUser(result.user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Sign Out
  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch(err) {
      print(err.toString());
      return null;
    }
  }
}