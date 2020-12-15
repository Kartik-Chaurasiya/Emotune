import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Songspage.dart';

// ignore: camel_case_types
class mainHome extends StatefulWidget {
  String mood;
  mainHome({this.mood});
  @override
  _mainHomeState createState() => _mainHomeState(mood);
}

// ignore: camel_case_types
class _mainHomeState extends State<mainHome> {
  String mood;
  String show;
  _mainHomeState(this.mood);
  List<DocumentSnapshot> _list;
  @override
  Widget build(BuildContext context) {
    if (mood == 'Happy'){
      setState(() {
        show = 'happy-songs';
      });
    }
    else if (mood == 'Fear'){
      setState(() {
        show = 'sad-songs';
      });
    }
    else if (mood == 'Angry'){
      setState(() {
        show = 'rage-songs';
      });
    }
    else{
      setState(() {
        show = 'neutral-songs';
      });
    }
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(show)
          .orderBy('song_name')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          _list = snapshot.data.docs;

          return ListView.custom(
              childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return buildList(context, _list[index]);
            },
            childCount: _list.length,
          ));
        }
      },
    );
  }

  Widget buildList(BuildContext context, DocumentSnapshot documentSnapshot) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Songspage(
                    song_name: documentSnapshot.data()["song_name"],
                    artist_name: documentSnapshot.data()["artist_name"],
                    song_url: documentSnapshot.data()["song_url"],
                    image_url: documentSnapshot.data()["image_url"],
                  ))),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            documentSnapshot.data()["song_name"],
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        elevation: 10.0,
      ),
    );
  }
}