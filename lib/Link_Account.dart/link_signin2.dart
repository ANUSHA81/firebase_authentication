import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LinkScreen2 extends StatefulWidget {
  @override
  _LinkScreen2State createState() => _LinkScreen2State();
}

class _LinkScreen2State extends State<LinkScreen2> {

  final formkey=GlobalKey<FormState>();

  bool isLoading=false;

  TextEditingController emailcon=new TextEditingController();
  TextEditingController passwordcon=new TextEditingController();

  void linkIn() async
  { 
    try
    {
      //AuthCredential ecredential=EmailAuthProvider.getCredential(email:emailcon.text,password:passwordcon.text);
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential gcredential = GoogleAuthProvider.getCredential(
                                                                accessToken: googleAuth.accessToken,
                                                                idToken: googleAuth.idToken,
                                                                );
      print(gcredential.providerId);
      //AuthResult gAuthresult=await FirebaseAuth.instance.signInWithCredential(gcredential);
      //print(gAuthresult.user.email);
      AuthResult eAuthresult=await FirebaseAuth.instance.signInWithEmailAndPassword(email:"anusha.btech.2018@gmail.com", password: "anushaaa");
      
      await eAuthresult.user.linkWithCredential(gcredential);
      print("linked");
      await eAuthresult.user.unlinkFromProvider("password");
  }
    catch(e)
    {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Link")),
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
                                  TextFormField(
                                    validator: (val)
                                                {
                                                  if(val.length>6)
                                                  {
                                                    return null;
                                                  }
                                                  else
                                                  {
                                                    return "Passord must be more than 6 characters"; 
                                                  }     
                                                },
                                    controller: passwordcon,
                                    decoration: InputDecoration(hintText:"password"),
                                  ),
                                  SizedBox(height:10),
                                  GestureDetector(
                                      onTap: (){},
                                      child: Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.centerRight,
                                      child:Text("Forgot Password?")
                                    ),
                                  ),
                                  SizedBox(height:18),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                      child: RaisedButton(
                                      onPressed: linkIn,
                                      child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),),
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
                                      Text("Don't have an Account? ",style: TextStyle(fontSize: 15),),
                                      GestureDetector(
                                        //onTap: toggleView,
                                        child: Text("Register Now",
                                                style: TextStyle(fontSize: 15,decoration: TextDecoration.underline),)
                                                )
                                    ],
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