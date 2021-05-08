import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roll_the_dice/model/user_model.dart';


class DBFuture{

  Firestore _firestore = Firestore.instance;

  Future<String> createUser(User user) async {
    String retVal = "error";
    try {
      await _firestore.collection("users").document(user.uid).setData({
        'name': user.name.trim(),
        'email': user.email.trim(),
        'score':user.score
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<User> getUser(String uid) async {
    User retVal;

    try {
      DocumentSnapshot _docSnapshot =
      await _firestore.collection("users").document(uid).get();
      retVal = User.fromDocumentSnapshot(doc: _docSnapshot);
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> updateUserScore(String uid,int newScore) async {
    String returnString = "error";
    User retVal;

    try {
      DocumentSnapshot _docSnapshot =
      await _firestore.collection("users").document(uid).get();
      retVal = User.fromDocumentSnapshot(doc: _docSnapshot);
      print(retVal.score);
      await _firestore.collection("users").document(uid).updateData({
        'score': newScore
      });
      await _firestore.collection("users").document(uid).get();
      retVal = User.fromDocumentSnapshot(doc: _docSnapshot);
      print(retVal.score);
      returnString = "success";

    } catch (e) {

      print(e);
    }

    return returnString;
  }

  Future<List<User>> getUserList() async {
    User retVal;

    try {
      var res = await _firestore.collection("users").orderBy('score',descending: false);
      print(res);
  //    retVal = User.fromDocumentSnapshot(doc: _docSnapshot);
    } catch (e) {
      print(e);
    }

  //  return retVal;
  }
}