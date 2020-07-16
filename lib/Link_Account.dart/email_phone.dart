import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'email_google.dart';
import 'linkedsuccesspage.dart';
import 'page.dart';


class LinkEmailPhoneScreen extends StatefulWidget 
{
  @override
  _LinkEmailPhoneScreenState createState() => _LinkEmailPhoneScreenState();
}

class _LinkEmailPhoneScreenState extends State<LinkEmailPhoneScreen> 
{
  final formkey=GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  bool isLoading=false;

  TextEditingController phonecon=new TextEditingController();

  FirebaseUser existingUser;

  void linkEmailPhone(String phoneNo) async
  { 
    try
    {
      existingUser=await FirebaseAuth.instance.currentUser(); //get currently logged in user
      print(existingUser.email);
      for(int i=0;i<existingUser.providerData.length;i++)
      {
        print(existingUser.providerData[i].providerId);
      }
      //await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: existingUser.email);
      

    //get the credentials of the new linking account
    
      final PhoneVerificationCompleted verified = 
      (AuthCredential authResult) {
                                    signIn(authResult);
                                  };

      final PhoneVerificationFailed verificationfailed =
          (AuthException authException) {
                                          print('${authException.message}');
                                        };

      final PhoneCodeSent smsSent = 
      (String verId, [int forceResend]) {
                                          this.verificationId = verId;
                                          setState(() {
                                            this.codeSent = true;
                                          });
                                        };

      final PhoneCodeAutoRetrievalTimeout autoTimeout = 
      (String verId) {
                      this.verificationId = verId;
                     };

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);

        Timer(Duration(seconds: 10), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder:(BuildContext context){return LinkedSuccess();})
                );
            });
        
    }
    catch(e)
    {
      print(e);
    }
  }

   signInWithOTP(smsCode, verId) {
    AuthCredential pauthCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(pauthCreds);
  }

  signIn(AuthCredential pauthCreds) async
  {
    //now link these credentials with the existing user
    AuthResult linkauthresult=await existingUser.linkWithCredential(pauthCreds);
    print(linkauthresult.user.email);
    for(int i=0;i<existingUser.providerData.length;i++)
    {
      print(existingUser.providerData[i].providerId);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Link Phone Number")),
      body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:40,right: 20),
                  child: Center(child: Text("Do you want to link phone number with your existing account?\nThen Click Verify ",style: TextStyle(color: Colors.green,fontSize: 30),)),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: phonecon,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter phone number'),
                  )),
                  codeSent ? Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP'),
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                  )) : Container(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      child: Center(child: codeSent ? Text('Login'):Text('Verify')),
                      onPressed: () {
                        codeSent ? signInWithOTP(smsCode, verificationId):
                        linkEmailPhone(phonecon.text);
                      })),
                
              ],
            ),
    );
  }
}
