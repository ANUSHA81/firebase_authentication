/*

PS C:\Users\anves\Desktop\Flutter Projects\firebase_authentication\android> .\gradlew SignInReport

> Task :app:signingReport
Variant: profileUnitTest 
Config: debug
Store: C:\Users\anves\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 02:16:83:E4:6F:3D:70:A2:2A:3E:EB:AE:D2:6A:31:D1
SHA1: BC:32:99:DC:17:C0:1E:43:2D:69:F3:23:94:5E:C9:78:82:74:7D:CF
SHA-256: F1:0C:8C:F1:36:40:A3:84:81:C7:64:FB:86:8F:6E:28:07:9B:C7:67:F2:DA:11:9A:C5:E9:25:9D:0F:7F:F6:72
Valid until: Friday, December 3, 2049

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Page extends StatefulWidget 
{
  final String email;
  Page(this.email);
  @override
  _PageState createState() => _PageState();
}

//page.dart
class _PageState extends State<Page> 
{ 
  printCurrentUser() async
  {
    List<String> methodsList=await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: "testing123@gmail.com");
    print(methodsList.length);
    print(methodsList[0]);
    //print(methodsList[1]);
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.providerData.length);
    print(user.providerData[0].providerId);
    print(user.providerData[1].providerId);
    print(user.providerData[2].providerId);

  }  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page"),
        centerTitle: true,
      ),

      body: Container(
        child: Center(
            child:RaisedButton(
              child: Text("Get Current User"),
              onPressed: (){printCurrentUser();}
              )
            
        ),
      ),
    );
  }
}

*/