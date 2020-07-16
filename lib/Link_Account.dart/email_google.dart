import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Link_Account.dart/email_phone.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'page.dart';


class LinkEmailGoogleScreen extends StatefulWidget 
{
  @override
  _LinkEmailGoogleScreenState createState() => _LinkEmailGoogleScreenState();
}

class _LinkEmailGoogleScreenState extends State<LinkEmailGoogleScreen> 
{
  final formkey=GlobalKey<FormState>();

  bool isLoading=false;

  TextEditingController emailcon=new TextEditingController();
  TextEditingController passwordcon=new TextEditingController();

  linkEmailGoogle() async
  { 
    try
    {
      FirebaseUser existingUser=await FirebaseAuth.instance.currentUser(); //get currently logged in user
      print(existingUser.email);
      for(int i=0;i<existingUser.providerData.length;i++)
      {
        print(existingUser.providerData[i].providerId);
      }
      

    //get the credentials of the new linking account
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential gcredential = GoogleAuthProvider.getCredential(
                                                                accessToken: googleAuth.accessToken,
                                                                idToken: googleAuth.idToken,
                                                                );

    //now link these credentials with the existing user
    AuthResult linkauthresult=await existingUser.linkWithCredential(gcredential);
    print(linkauthresult.user.email);
    for(int i=0;i<existingUser.providerData.length;i++)
    {
      print(existingUser.providerData[i].providerId);
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(BuildContext context){return LinkEmailPhoneScreen();}));
    }
    catch(e)
    {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Link Google Account")),
      body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:50),
                  child: Center(child: Text("Do you want to link your google account with existing account? ",style: TextStyle(color: Colors.green,fontSize: 30),)),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text("Yes"),
                  onPressed: (){linkEmailGoogle();},
                  )
              ],
            ),
    );
  }
}
