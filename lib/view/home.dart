import 'package:flutter/material.dart';
import 'package:roll_the_dice/view/leaderboard.dart';
import 'package:roll_the_dice/view/play.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Play(),
    LeaderBoard()
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon:  Icon(Icons.casino),
            label: "Play",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "LeaderBoard"
          )
        ],
      ),
    );
  }
}

