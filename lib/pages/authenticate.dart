import 'package:first_proj/pages/register.dart';
import 'package:flutter/cupertino.dart';
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
      body: Container(
        //background image
        height: 1000,
        width: 550,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/Maneeha.jpg"),
    fit: BoxFit.cover,
    ),
    ),
        child: ListView(
          //UI starts here
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(0.0),
            ),

            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                    height: 120,
                    width: 240,
                    margin: EdgeInsets.only(top: 40, left: 40, right: 40),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                        borderRadius: new BorderRadius.all(Radius.elliptical(120, 60)),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Welcome to\n Maneeha\'s',style: TextStyle(fontSize: 30),)),
                  ),
                ),
              ],
            ),
                Container(
                  height: 50,
                ),


                Padding(
                    padding: const EdgeInsets.all(110.0)
                ),


            // SIGNIN and redirect to SIGNIN page
            Column(
              children: <Widget>[
                Container(
                  height: 40,
                  width: 250,
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text("Login"),
                    onPressed: () {
                      return Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                        return LoginPage();
                      }));
                    },
                  ),
                ),
                Container(
                  height: 10,
                )
              ],
            ),


            // SIGNUP and redirect to SIGNUP page
            Column(
              children: <Widget>[
                Container(
                  height: 40,
                  width: 250,
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    child: Text("SignUp"),
                    onPressed: () {
                      return Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                        return Signup();
                      }));
                    },
                  ),
                ),
              ],
            )
          ],

        ),
        )
      
    );
  
  }
}