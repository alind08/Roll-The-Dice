import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class User{
  String uid;
  String name;
  String email;
  int score;
  User({this.name,this.email,this.uid,this.score});

  User.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.documentID;
    email = doc.data['email'];
    name = doc.data['name'];
    score = doc.data['score'];
  }
}



class AuthModel {
  String uid;
  String email;
  String name;

  AuthModel({
    this.uid,
    this.email,
    this.name
  });

  AuthModel.fromFirebaseUser({FirebaseUser user}) {
    uid = user.uid;
    email = user.email;
    name = user.displayName;
  }
}