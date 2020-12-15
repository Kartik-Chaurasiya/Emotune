import 'dart:ffi';
import 'dart:io';
import 'package:emotune/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:convert';
import 'package:percent_indicator/percent_indicator.dart';

class MyImagePicker extends StatefulWidget {
  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File imageURI;
  String result;
  String path;
  final picker = ImagePicker();
  double conf1, conf2;
  String label1, label2;

  Future getImageFromCamera() async {
  // ignore: deprecated_member_use
  var image = await ImagePicker.pickImage(source: ImageSource.camera);
  setState(() {
    imageURI = image;
    path = image.path;
  });
}

Future getImageFromGallery() async {
  // ignore: deprecated_member_use
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
    imageURI = image;
    path = image.path;
  });
}

  Future classifyImage() async {
  await Tflite.loadModel(model: "assets/model/model.tflite",labels: "assets/model/labels.txt");
  var output = await Tflite.runModelOnImage(path: path);
  var valueMap = json.encode(output);
  var valueMap1 = json.decode(valueMap);
  var l = valueMap1.length;
  setState(() {
    result = output.toString();
    conf1 = valueMap1[l-2]['confidence'];
    conf2 = valueMap1[l-1]['confidence'];
    label1 = valueMap1[l-2]['label'];
    label2 = valueMap1[l-1]['label'];
  });
}

  @override
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
      child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
        Container(
          width: 400,
          height: 200,
                child: 
                Center(
                  child: imageURI == null
            ? Text('No image selected.', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),)
            : Image.file(imageURI, width: 400, height: 200, fit: BoxFit.cover),
                ),
        ),
        Spacer(),
        Row(
          children: [
            Spacer(),
              ClipOval(
  child: Material(
      color: Colors.blue[300], // button color
      child: InkWell(
            splashColor: Colors.white, // inkwell color
            child: SizedBox(width: 100, height: 100, child: Icon(Icons.camera, size: 35,)),
            onTap: () => getImageFromCamera(),
      ),
  ),
),
Spacer(),
              
          
        ClipOval(
  child: Material(
      color: Colors.blue[300], // button color
      child: InkWell(
        splashColor: Colors.red, // inkwell color
        child: SizedBox(width: 100, height: 100, child: Icon(Icons.image, size: 35,)),
        onTap: () => getImageFromGallery(),
      ),
  ),
),
Spacer()
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
          child: RaisedButton(
            onPressed: () => classifyImage(),
            child: Text('Classify Image'),
            textColor: Colors.white,
            color: Colors.blue[300],
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          )),
        result == null
          ? Text('Result', style: TextStyle(
              fontWeight: FontWeight.bold,))
          : 
          // Text(result),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: new CircularPercentIndicator(
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: 1-conf1,
                center: new Text(
                  label1,
                  // label1.toString(),
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.blue,
                progressColor: Colors.pink,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: new CircularPercentIndicator(
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: 1-conf2,
                center: new Text(
                  label2,
                  // label1.toString(),
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.blue,
                progressColor: Colors.pink,
              ),
            ),
            Spacer(),],
          ),
              Spacer(),
  ])),
    ),
  floatingActionButton: FloatingActionButton(
    backgroundColor: Colors.blue[300],
        onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(mood : label1)),
             );
            },
        tooltip: 'Home',
        child: Icon(Icons.skip_next),
      ),
  );
}
}