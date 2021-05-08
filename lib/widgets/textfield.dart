import 'package:flutter/material.dart';

Widget textField(String fieldName,TextEditingController controller){
  return TextFormField(
    decoration: InputDecoration(
      enabled: true,
      filled: true,
      fillColor: Colors.white70,
      hintText: fieldName,
      hintStyle: TextStyle(fontSize: 18,color: Colors.black87,fontWeight: FontWeight.w600),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20)
      ),
    ),
    keyboardType: TextInputType.text,
    controller: controller,
  );
}