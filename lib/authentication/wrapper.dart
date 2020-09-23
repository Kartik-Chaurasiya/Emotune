import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emotune/authentication/authenticate/authenticate.dart';
import '../home.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomClassName>(context);

    //Return either home or Authenticate widget
    if (user == null){
      return Authenticate();
    }else {
      return Home();
    }
  }
}