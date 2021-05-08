import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roll_the_dice/view/home.dart';
import 'package:roll_the_dice/view/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  String uid;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  uid = prefs.get("userId");

  runApp( MyApp(uid: uid,));
}

class MyApp extends StatefulWidget {
  final String uid;
  MyApp({this.uid});
  @override
  MyAppState createState() =>  MyAppState();
}

class MyAppState extends State<MyApp>{
  ThemeData _appTheme = ThemeData(
      primarySwatch: Colors.amber,
      primaryColor: Colors.amber.shade700,
      accentColor: Colors.amberAccent.shade400,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xffFAFAFA),
      dialogBackgroundColor: Color(0xffFFFFFF),
      bottomAppBarColor: Color(0xffFAFAFA),
      dividerColor: Color(0xff00000F)
  );




  @override
  void initState() {
    super.initState();
  //  getPrefs();
    //initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roll The Dice',
      theme: _appTheme,
      home: widget.uid!=null?Home():Welcome(),
    );
  }
}