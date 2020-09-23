import 'package:firebase_auth/firebase_auth.dart';
import 'package:emotune/authentication/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebased user
  CustomClassName _fromFirebaseUser(User user)
  {
    return user != null ? CustomClassName(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<CustomClassName> get user{
    return _auth.authStateChanges()
    // .map((User user) => _fromFirebaseUser(user));
    .map(_fromFirebaseUser);
  }

  //sign in anon
  // async = ek ke bad ek process hongee
  //await = wait for the process to finish
  // future = carry on the process in the background while running the further code i.e do not block the code
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _fromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _fromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _fromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;

    }
  }

}