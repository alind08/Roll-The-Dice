import 'dart:math';
import 'package:flutter/material.dart';
import 'package:roll_the_dice/services/db_services.dart';
import 'package:roll_the_dice/widgets/drawer_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  int totalScore = 0;
  static int counter = 0;
  int diceNumber = counter==0 ?0:randomize();
  DBFuture _dbFuture  = DBFuture();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: InkWell(
            child: Icon(Icons.menu,color: Colors.black87,),
          onTap: (){
            _scaffoldKey.currentState.openDrawer();
          }
        ),
        title: Text("Game Zone"),
      ),
      drawer: Drawer(
        child: DrawerBody()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body:  Align(
        alignment:  FractionalOffset(0.5,0.30),
        child:  SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80.0),
          child:  Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('You rolled a', style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).textTheme.headline4.color,)),
                SizedBox(height:8.0),
                Text(diceNumber.toString(), style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).primaryColor,)),
                SizedBox(height:8.0),
                Text('Total Score = $totalScore', style: Theme.of(context).textTheme.headline4.copyWith(color: Theme.of(context).primaryColor,)),
                SizedBox(height:8.0),
                Text('*in ${counter!=11?counter:10} attempts', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),
                SizedBox(height:30.0),
                counter==11?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Text('Cancel', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.red,)),
                      onTap: (){
                        setState(() {
                          counter=0;
                          diceNumber=0;
                          totalScore=0;
                        });
                      },
                    ),
                    InkWell(
                      child: Text('Submit', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.red,)),
                      onTap: ()async{
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Updating Score")));
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        String uid = await prefs.get("userId");
                        await _dbFuture.updateUserScore(uid, totalScore).then((value) {
                          String result = value=="success"?"Score updated!":"Something went wrong!";
                          _scaffoldKey.currentState.hideCurrentSnackBar();
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(result,),backgroundColor: value=="success"?Colors.greenAccent:Colors.redAccent,));
                          setState(() {
                            counter=0;
                            diceNumber=0;
                            totalScore=0;
                          });
                        });
                      },
                    )
                  ],
                )
                    :SizedBox.shrink()
              ]
          ),
        ),
      ),
      // Stack(
      //   children: [
      //
      //     Positioned(
      //       left: 30,
      //         top: 50,
      //         child: InkWell(
      //           onTap: (){
      //             _scaffoldKey.currentState.openDrawer();
      //           },
      //           child: Container(
      //                     height: 40,
      //                 width: 40,
      //                 decoration: BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 color: Colors.grey,
      //                 ),
      //             child: Icon(Icons.menu,color: Colors.black87,),
      //             ),
      //         )
      //     )
      //   ],
      // ),
      floatingActionButton:  counter!=11?FloatingActionButton.extended(
        onPressed: onPressed,
        icon: const Icon(Icons.casino,),
        label: const Text('Roll'),
        elevation: 4.0,
        highlightElevation: 8.0,
      ):SizedBox.shrink(),

    );
  }
  static int randomize(){
    final random =  Random();
    return 1 + random.nextInt(6);
  }

  void onPressed(){
    setState((){
      counter = counter+1;
      diceNumber = counter!=11?randomize():0;
      totalScore = totalScore+diceNumber;
    });
  }


}

