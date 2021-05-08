import 'package:flutter/material.dart';

Widget basicButton(String buttonName){
  return Container(
    height: 50,
    width: 120,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Text(buttonName,style: TextStyle(color: Colors.black87  ,fontSize: 20,fontWeight: FontWeight.w800),),
  );
}