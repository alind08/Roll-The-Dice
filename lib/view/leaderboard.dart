import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roll_the_dice/services/db_services.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Leaders"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("users").orderBy("score",descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return  Center(child: CircularProgressIndicator(),);
            return  ListView(children: getLeaders(snapshot));
          }),
    );
  }
  getLeaders(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) =>  Card(
          child: ListTile(
      leading: CircleAvatar(
          radius: 40,
          child: Text(doc["name"][0].toUpperCase(),style: Theme.of(context).textTheme.headline5,),
      ),
          title:  Text(doc["name"]), subtitle:  Text(doc["score"].toString())),
        ))
        .toList();
  }
}

