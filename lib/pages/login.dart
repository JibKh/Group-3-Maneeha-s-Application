import 'package:first_proj/util/loading.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:first_proj/util/firebase_auth.dart';

// Purpose of this page is to allow user to input login data and verify it using firebase_auth.dart file.

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Create firebase authentication variable
  final AuthService _auth = AuthService();

  // For input validation
  final _formKey = GlobalKey<FormState>();

  // To load up the loading screen.
  bool loading;
  @override
  void initState() { 
    super.initState();
    loading = false;
  }

  String email = "";
  String password = ""; 
  String error = "";

  // START UI
  @override
  Widget build(BuildContext context){
    return loading ? Loading() : Scaffold(
    //return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: 1000,
            width: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/Maneeha.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(filter: new ImageFilter.blur(
                sigmaX: 3.0, sigmaY: 3.0
            ),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),

          ),
          Positioned(
            top: 120,
            child: Container(
              width: 250,
              height: 50,
              color: Colors.blueGrey,
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

                    // Login Input
                    Text("Login", style: TextStyle(
                        fontSize: 20.0
                    ),),
                    const SizedBox(height: 20.0),

                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      cursorColor: Colors.blue,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
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
                    
                    // Login Button
                    const SizedBox(height: 50.0),
                    RaisedButton(
                      color: Colors.white,
                      child: Text("Login"),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error = 'Could not sign in.';
                              loading = false;
                            });
                            
                          } else {
                            //Navigator.pop(context);
                            setState(() => loading = false);
                          }
                        }
                        // if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                        //   print("Email and password cannot be empty");
                        //   return;
                        // }
                        // bool res = await AuthProvider().signInWithEmail(_emailController.text, _passwordController.text);
                        // if(!res) {
                        //   print("Login failed");
                        // }
                      },
                    ),

                    // If there is an error, display it under the login button.
                    SizedBox(height:5.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    //  RaisedButton(
                    //   color: Colors.green,
                    //   child: Text("Login with Google"),
                    //   onPressed: () async {
                    //     bool res = await AuthProvider().loginWithGoogle();
                    //     if(!res)
                    //       print("error logging in with google");
                    //   },
                    // ),
                    RaisedButton(
                      color: Colors.blueGrey,
                      child: Text("SignIn Anonymously"),
                      onPressed: () async {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          print('Error signing in');
                          setState(() => loading = false);
                        } else {
                          print('Signed in');
                          print(result);
                          Navigator.pop(context);
                          setState(() => loading = false);
                        }
                      },
                    )

                  ],
                ),
              ),
              // =============== END FORM ===============
            ),
          ),


        ],

      ),
      backgroundColor: Colors.white,
    );
  }
}