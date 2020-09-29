import 'package:emotune/authentication/authenticate/sign_in.dart';
import 'package:emotune/music_player/music_home.dart';
import 'package:emotune/music_player/upload.dart';
import 'package:flutter/material.dart';
import 'package:emotune/authentication/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int currentindex = 0;

  List tabs = [
    musicHome(),
    musicUpload()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Emotune'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
             );
            },
          ),
        ],
      ),
      body: tabs[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),
        title: Text('Home'),),
        BottomNavigationBarItem(icon: Icon(Icons.cloud_upload),
        title: Text('Upload'),),
      ],
      onTap: (index){
        setState(() {
          currentindex = index;
        });
      },
      ),
    );
  }
}