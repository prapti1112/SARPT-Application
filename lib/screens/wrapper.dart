import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarpt_app/models/user.dart';
import 'package:sarpt_app/screens/authenticate/authenticate.dart';
import 'package:sarpt_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);
    print(user);

    // return Home();
    return (user == null) ? Authenticate() : Home();
  }
}
