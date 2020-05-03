import 'package:flutter/material.dart';
import 'package:first_proj/util/firebase_auth.dart';

// The purpose of this document is to create the registration page where users can signup

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  // Create firebase authentication variable
  final AuthService _auth = AuthService();

  // For input validation
  final _formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = ""; 
  String error = "";

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
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 80,
              left: 100,
              child: Align(
                child: Text('Welcome to Maneeha\'s',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Positioned(
              top:190,
              child: Align(
                child: Container(
                  width: 600,
                  //color: Colors.greenAccent.withOpacity(0.6),
                  child: Align(
                    alignment: Alignment(-0.94,0),
                  child: Text("Signup", style: TextStyle(
                      fontSize: 20.0
                  ),),
                  ),
                ),

                  ),
            ),

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),

                // =============== START FORM ===============
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 180.0),

                      // Signup

                      const SizedBox(height: 30.0),

                      TextFormField(
                        validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                        cursorColor: Colors.blue,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.greenAccent,
                            hintText: "Enter email"
                        ),
                      ),

                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                        cursorColor: Colors.red,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        decoration: InputDecoration(
                            hintText: "Enter password"
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                        cursorColor: Colors.red,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        decoration: InputDecoration(
                            hintText: "Confirm password"
                        ),
                      ),

                      // Signup button
                      const SizedBox(height: 50.0),
                      RaisedButton(
                        color: Colors.greenAccent,
                        child: Text("Signup"),
                        onPressed: () async {
                          if(_formKey.currentState.validate()) {
                            Navigator.pop(context);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() => error = 'Please apply valid email');
                            }
                          }
                        },
                      ),

                      // If there is an error, display it under the signup button.
                      SizedBox(height:12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
                // =============== END FORM ===============
              ),
            ),


          ],

        ),
      ),
      backgroundColor: Colors.white,
    );
  
  }
}