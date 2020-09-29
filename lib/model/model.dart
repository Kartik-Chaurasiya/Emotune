import 'dart:io';
import 'package:emotune/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MyImagePicker extends StatefulWidget {
  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File imageURI;
  String result;
  String path;
  final picker = ImagePicker();

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
  setState(() {
    result = output.toString();
  });
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
      child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
          width: 400,
          height: 200,
                child: 
                Center(
                  child: imageURI == null
            ? Text('No image selected.')
            : Image.file(imageURI, width: 400, height: 200, fit: BoxFit.cover),
                ),
        ),
        Row(
          children: [
            Spacer(),
              ClipOval(
  child: Material(
      color: Colors.blue, // button color
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
      color: Colors.blue, // button color
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
            color: Colors.blue,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          )),
        result == null
          ? Text('Result')
          : Text(result),
  ])),
    ),
  floatingActionButton: FloatingActionButton(
        onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
             );
            },
        tooltip: 'Home',
        child: Icon(Icons.skip_next),
      ),
  );
}
}