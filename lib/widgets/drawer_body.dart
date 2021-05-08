import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roll_the_dice/services/firestore_services.dart';
import 'package:roll_the_dice/view/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DrawerBody extends StatefulWidget {
  @override
  _DrawerBodyState createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  String name = '';
  String email = '';
  String uid = '';

  getPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = await prefs.get("name");
    email = await prefs.get("email");
    uid = await prefs.get("userId");
    setState(() {
      name = name;
      email = email;
      uid = uid;
    });
  }
  Auth _auth = Auth();
  @override
  void initState() {
    // TODO: implement initState
    getPrefs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          CircleAvatar(
            radius: 40,
            child: Text(name.isNotEmpty?name[0].toUpperCase():'A',style: Theme.of(context).textTheme.headline5,),
          ),
          SizedBox(height: 20,),
          Text(name,style: Theme.of(context).textTheme.headline5,),
          SizedBox(height: 20,),
          Text(email,style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black87),),
          Spacer(),
          ListTile(
            onTap: (){
              _auth.signOut().then((value) async {
                if(value== "success"){
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=>Welcome()
                  ));
                }
              });
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Sign Out",style: Theme.of(context).textTheme.headline6,),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
