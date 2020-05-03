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
        height: 1000,
        width: 500,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/back_1.jpg"),
    fit: BoxFit.cover,
    ),
    ),
        child: ListView(
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
                      color: Colors.greenAccent.withOpacity(0.6),
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
                    padding: const EdgeInsets.all(12.0)
                ),
                Align(
                  alignment: Alignment(0,0),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/e_comm2.png"),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle
                    ),
                  ),
                ),



                Container(
                  width: 20,
                  height: 100,
                ),/*
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    //dict['pic'] returns the price of the product
                    child: Image.asset(
                      'images/auth_2.jpg',
                      width: 170,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

              ],
            ),
            Container(
              height: 20,
              width: 400,
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(12.0)
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    //dict['pic'] returns the price of the product
                    child: Image.asset(
                      'images/jeans.jpg',
                      width: 170,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 200,
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    //dict['pic'] returns the price of the product
                    child: Image.asset(
                      'images/cute-cheap-clothes-under-50.jpeg',
                      width: 170,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

              ],
            ),
            Container(
              height: 30,
            ),*/


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
                    color: Colors.greenAccent,
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