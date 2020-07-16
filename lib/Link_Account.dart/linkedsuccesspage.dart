import 'package:flutter/material.dart';

class LinkedSuccess extends StatefulWidget {
  @override
  _LinkedSuccessState createState() => _LinkedSuccessState();
}

class _LinkedSuccessState extends State<LinkedSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Linked Accounts")
      ),
      body: Container(
        child:Center(child: Text("Successfully Linked Accounts", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)
      ),
    );
  }
}