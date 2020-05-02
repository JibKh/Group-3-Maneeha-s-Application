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
          Padding(
            padding: const EdgeInsets.all(12.0),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                //color: Colors.grey
              ),
              child: Text('Maneeha\'s',textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 24,
              ),


            ]
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
                      'images/auth_1.jpg',
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
          ),


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