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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
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
