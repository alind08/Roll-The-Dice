import 'package:flutter/material.dart';
import 'package:roll_the_dice/view/login.dart';
import 'package:roll_the_dice/view/signup.dart';
import 'package:roll_the_dice/widgets/basic_button.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.casino,size: 200,color: Theme.of(context).scaffoldBackgroundColor,),
            SizedBox(height: 50,),
            Text("Welcome to Roll The Dice!",style: Theme.of(context).textTheme.headline5,),
            SizedBox(height: 50,),
            InkWell(
              child: basicButton("Login"),
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>Login()
                ));
              },
            ),
            SizedBox(height: 30,),
            InkWell(
              child: basicButton("SignUp"),
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>SignUp()
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
