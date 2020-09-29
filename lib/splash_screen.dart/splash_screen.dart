import 'package:emotune/authentication/wrapper.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState(){
    super.initState();
    _mockcheckForSession().then(
      (status) {
        if(status){
          _navigateToHome();
        }
      }
    );
  }

  Future<bool> _mockcheckForSession()async{
    await Future.delayed(Duration(milliseconds: 3000), () {});

    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
    
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: 0.3,
              child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover)),
              Shimmer.fromColors(baseColor: Color(0xff7f00ff), highlightColor: Color(0xffe100ff),
              child: Container(
                child: Text('Emotune',
                style: TextStyle(
                  fontSize: 90.0,
                  fontFamily: 'DancingScript',
                )
                ),
              ),
              )
          ],
        ),
      ),
    );
  }
}
