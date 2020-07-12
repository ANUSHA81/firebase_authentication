import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Email_Auth/homepage.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);
  @override
  _SignInState createState() => _SignInState(toggleView);
}

class _SignInState extends State<SignIn> 
{
  final formkey=GlobalKey<FormState>();

  final Function toggleView;
  _SignInState(this.toggleView);

  TextEditingController emailcon=new TextEditingController();
  TextEditingController passwordcon=new TextEditingController();

  bool wrongEmail=false;
  bool wrongPassword=false;
  bool emailDisabled=false;
/*
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
  }*/

  @override
  void dispose() {
    emailcon.dispose();
    passwordcon.dispose();
    super.dispose();
  }
  
  void _showDialog() 
  {
    showDialog(
                context: context,
                builder: (BuildContext context) 
                        {
                          return AlertDialog(
                                  title: new Text("Account Disabled"),
                                  content: new Text("Your account has been disabled by the administrator"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                          );
                        },
            );
  }

  signMeIn() async
  {
    if(emailDisabled)
    {
      print("emaildisabled");
      _showDialog();
      print("emaildisabled2");
    }
    else if(!emailDisabled)
    {
      if(formkey.currentState.validate())
      {
        await firebaseSignIn(emailcon.text,passwordcon.text);
        if(((wrongEmail||wrongPassword)||emailDisabled)==false)
        {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(BuildContext context){return HomePage();}));
        }
      }
    }
    
  }

  Future firebaseSignIn(String email, String password) async
  {
    try
    {
      AuthResult result=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return user;
    }
    catch(e)
    {
      print(e);
      if(e.code=='ERROR_WRONG_PASSWORD')
      {
        setState(() {
          wrongPassword=true;
        });
      }else if(e.code=='ERROR_USER_NOT_FOUND')
      {
        setState(() {
          wrongEmail=true;
          wrongPassword=true;
        });
      }
      else if(e.code=='ERROR_USER_DISABLED')
      {
        setState(() {
          emailDisabled=true;
        });
      }
    }
    signMeIn();
  }
  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In"),centerTitle: true,),
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
                                                      if((RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) && !wrongEmail))
                                                      {
                                                        return null;
                                                      }
                                                      else
                                                      {
                                                        if(wrongEmail==true)
                                                        {
                                                          return "No Email Found";
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
                                                  if(val.length>6 && !wrongPassword)
                                                  {
                                                    return null;
                                                  }
                                                  else
                                                 {
                                                   if(wrongPassword==true)
                                                   {
                                                    return "Incorrect Password";
                                                   }
                                                   else
                                                   {
                                                    return "Passord must be more than 6 characters";
                                                   } 
                                                  }     
                                                },
                                    controller: passwordcon,
                                    decoration: InputDecoration(hintText:"password"),
                                  ),
                                  SizedBox(height:10),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.centerRight,
                                    child:Text("Forgot Password?")
                                  ),
                                  SizedBox(height:18),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                      child: RaisedButton(
                                      onPressed: signMeIn,
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
                                        onTap: toggleView,
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