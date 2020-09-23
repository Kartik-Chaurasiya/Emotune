import 'package:firebase_core/firebase_core.dart';
import 'authentication/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/models/user.dart';
import 'authentication/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomClassName>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}