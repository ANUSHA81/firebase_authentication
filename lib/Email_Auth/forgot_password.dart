import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final formkey=GlobalKey<FormState>();

  TextEditingController emailcon=new TextEditingController();

  forgotPassword() async
  {
    if(formkey.currentState.validate())
    {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcon.text);
      Navigator.pop(context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Container(
                 height: MediaQuery.of(context).size.height-50,
                 alignment: Alignment.bottomCenter,
                 child: Container(
                          padding: EdgeInsets.symmetric(horizontal:25,),
                          child:Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Form(
                                    key:formkey,
                                    child:Column(
                                      children:[
                                        Text("Enter your email to send a password reset link"),
                                        SizedBox(height:30),
                                        TextFormField(
                                    validator: (val){
                                                      if((RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)))
                                                      {
                                                        return null;
                                                      }
                                                      else
                                                      {
                                                        return "Please provide a valid email";  
                                                      }
                                                },
                                    controller: emailcon,
                                    decoration: InputDecoration(hintText:"email"),
                                  ),
                                  SizedBox(height:18),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                      child: RaisedButton(
                                      onPressed: (){forgotPassword();},
                                      child: Text("Send Reset Email",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),),
                                      color: Colors.green,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                                                                    side: BorderSide(color:Colors.black)),
                                      padding: EdgeInsets.only(top: 18,bottom: 18,),
                                      ),
                                  ),
                                  
                                  SizedBox(height:200),
                                      ]
                                    )
                                  )
                                ],
                                )
                         ),
        ),
      ),
    );
  }
}