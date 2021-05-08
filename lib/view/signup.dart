import 'package:flutter/material.dart';
import 'package:roll_the_dice/services/firestore_services.dart';
import 'package:roll_the_dice/view/home.dart';
import 'package:roll_the_dice/widgets/basic_button.dart';
import 'package:roll_the_dice/widgets/textfield.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.yellow[700],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 60,),
                Icon(Icons.casino,size: 100,color: Theme.of(context).scaffoldBackgroundColor,),
                SizedBox(height: 20,),
                Text("Roll The Dice",style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),),
                SizedBox(height: 20,),
                textField("Name",_nameController),
                SizedBox(height: 30,),
                textField("Email",_emailController),
                SizedBox(height: 30,),
                textField("Password",_passController),
                SizedBox(height: 30,),
                InkWell(
                  child: basicButton("SignUp"),
                  onTap: ()async{
                    if(_nameController.text.isNotEmpty && _emailController.text.isNotEmpty && _passController.text.length>6){
                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Logging in...")));
                      _auth.signUpUser(_emailController.text, _passController.text, _nameController.text).then((value) {
                        if(value=="success"){
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(
                              builder: (context)=>Home()
                          ));
                        }else{
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Something went wrong")));
                        }
                      });
                    }else{
                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Check your entry")));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
