import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:first_proj/pages/splash.dart';
import 'package:first_proj/pages/login.dart';
import 'package:first_proj/pages/HomePageTabs.dart';

//import 'package:first_proj/pages/login.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen()
  ));
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return SplashPage();
        if(!snapshot.hasData || snapshot.data == null)
          return LoginPage();
        return HomePageTabs();
      },
    );
  }
}