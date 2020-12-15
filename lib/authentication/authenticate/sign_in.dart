import 'package:flutter/material.dart';
import 'package:emotune/authentication/services/auth.dart';
import 'package:emotune/authentication/shared/constants.dart';
import 'package:emotune/authentication/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text feild state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign In'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              decoration: TextInputDecoration.copyWith(hintText: 'Email'),
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
              onChanged: (val){
                setState(() => email = val);
              }
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: TextInputDecoration.copyWith(hintText: 'Password'),
              obscureText: true,
              validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val){
                setState(() => password = val);
              }
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Colors.pink[400],
              child: Text('Sign In', 
              style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()){
                  setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                  if(result == null){
                    setState((){ error = 'COULD NOT SIGN IN WITH THOSE CREDS';
                    loading = false;
                    }
                    );
                  }
                }
              }),
              SizedBox(height: 12.0),
              Text(
                error, style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
          ]
        )),
      ),
    );
  }
}