import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'email_google.dart';
import 'email_phone.dart';


class SignUpPart extends StatefulWidget 
{
  @override
  _SignUpPartState createState() => _SignUpPartState();
}

class _SignUpPartState extends State<SignUpPart> 
{
  final formkey=GlobalKey<FormState>();

  TextEditingController usernamecon=new TextEditingController();
  TextEditingController emailcon=new TextEditingController();
  TextEditingController passwordcon=new TextEditingController();

  bool emailExists=false;

  @override
  void initState() {
    emailcon = TextEditingController();
    emailcon.addListener(() {
      setState(() {});
    });
    passwordcon = TextEditingController();
    passwordcon.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    emailcon.dispose();
    passwordcon.dispose();
    super.dispose();
  }

  signMeUp() async
  {
    if(formkey.currentState.validate())
    {
      await firebaseSignUp(emailcon.text,passwordcon.text);
      if(emailExists==false)
      {
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(BuildContext context){return LinkEmailGoogleScreen();}));
      }
      emailExists=false;
    }
  }

  Future firebaseSignUp(String email,String password) async
  {
    try
    {
      AuthResult result=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: password);
      FirebaseUser user=result.user;
      return user;
    }
    catch(e)
    {
      print(e);
      if(e.code=='ERROR_EMAIL_ALREADY_IN_USE')
      {
        setState(() {
          emailExists=true;
        });
      }
    }
      signMeUp();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUp"),centerTitle: true,),
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
                                      key: formkey,
                                      child: Column(
                                                children:[
                                                  TextFormField(
                                                    validator: (val){
                                                      return val.isEmpty||val.length<3? "Please provide a valid username":null;
                                                    },
                                                    controller: usernamecon,
                                                    decoration: InputDecoration(hintText:"username"),
                                              ),
                                              TextFormField(
                                                validator: (val){
                                                                  if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) && !emailExists)
                                                                  {
                                                                    return null;
                                                                  }
                                                                  else
                                                                  {
                                                                    if(emailExists==true)
                                                                    { 
                                                                      return "Email already exists, please sign in";
                                                                    }
                                                                    else
                                                                    {
                                                                      return "Please provide a valid email";
                                                                    }
                                                                  }
                                                                },
                                                controller: emailcon,
                                                decoration: InputDecoration(hintText:"email"),
                                              ),
                                              TextFormField(
                                                validator: (val)
                                                {
                                                  return val.length>6?null:"Passord must be more than 6 characters"
                                                  ;
                                                },
                                                controller: passwordcon,
                                                decoration: InputDecoration(hintText:"password"),
                                              ),
                                                ],
                                                 ),
                                  ),
                                  SizedBox(height:10),
                                  SizedBox(height:18),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                      child: RaisedButton(
                                      onPressed: signMeUp,
                                      child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),),
                                      color: Colors.green,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                                                                    side: BorderSide(color:Colors.black)),
                                      padding: EdgeInsets.only(top: 18,bottom: 18,),
                                      ),
                                  ),
                                  SizedBox(height:18),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Already have an Account? ",style: TextStyle(fontSize: 15),),
                                      GestureDetector(
                                        //onTap: widget.toggleView,
                                        child: Text("Sign In",
                                                style: TextStyle(fontSize: 15,decoration: TextDecoration.underline),)
                                                )
                                    ],
                                    ),
                                  SizedBox(height:200),
                                ],
                                )
                         ),
        ),
      ),
    );
  }
}