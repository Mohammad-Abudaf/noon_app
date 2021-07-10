import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}