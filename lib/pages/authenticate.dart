import 'package:first_proj/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/login.dart';

// Purpose of this file is to display the Signin button and the Signup button

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[

          // SIGNIN and redirect to SIGNIN page
          RaisedButton(
            color: Colors.white,
            child: Text("SignIn"),
            onPressed: () {
              return Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return LoginPage();
              }));
            },
          ),

          // SIGNUP and redirect to SIGNUP page
          RaisedButton(
            color: Colors.white,
            child: Text("SignUp"),
            onPressed: () {
              return Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                return Signup();
              }));
            },
          )
        ],)
      
    );
  
  }
}