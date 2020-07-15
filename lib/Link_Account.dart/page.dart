import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Page extends StatefulWidget 
{
  final String email;
  Page(this.email);
  @override
  _PageState createState() => _PageState();
}

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