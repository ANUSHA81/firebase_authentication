import 'package:firebase_authentication/Email_Auth/signup.dart';
import 'package:flutter/material.dart';
import 'Email_Auth/auth_toggle.dart';
import 'Google_Auth.dart';
import 'Link_Account.dart/signup_part.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SignUpPart(),
    );
  }
}

