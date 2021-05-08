import 'package:firebase_auth/firebase_auth.dart';
import 'package:roll_the_dice/model/user_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db_services.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<AuthModel> get user {
    return _auth.onAuthStateChanged.map(
          (FirebaseUser firebaseUser) => (firebaseUser != null)
          ? AuthModel.fromFirebaseUser(user: firebaseUser)
          : null,
    );
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(String email, String password, String name) async {
    String retVal = "error";
    try {
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      print(_authResult);
      User _user = User(
        uid: _authResult.user.uid,
        email: _authResult.user.email,
        name: name.trim(),
        score: 0,
      );
      String _returnString = await DBFuture().createUser(_user);
      if (_returnString == "success") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', _user.uid);
        await prefs.setString('name', _user.name);
        await prefs.setString('email', _user.email);
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
    }

    return retVal;
   }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      AuthResult _authResult =  await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

      if(_authResult.user.providerData[0].uid!=null){
        DBFuture().getUser(_authResult.user.providerData[0].uid).then((value) async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', value.uid);
          await prefs.setString('name',value.name);
          await prefs.setString('email', value.email);
        });
        retVal = 'success';
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
    }
    print(retVal);

    return retVal;
  }


}