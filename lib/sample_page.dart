import 'package:flutter/material.dart';

class SamplePage extends StatelessWidget{

  String name = "placeholder";
  int id =1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Sample Text"
          ),
        ),
      ),
    );
  }
}