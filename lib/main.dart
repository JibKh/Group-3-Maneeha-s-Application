import 'package:first_proj/pages/HomePageTabs.dart';
import 'package:first_proj/pages/authenticate.dart';
import 'package:first_proj/util/firebase_auth.dart';
import 'package:first_proj/util/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// PURPOSE:
// Main file is the first file to be called.
// We call the MyApp function which is wrapped in a stream so it is constantly listening for changes in signin/signup
// The Wrapper function choose which screen to send it to, Homepage or the Authentication page (signin/signup)

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return HomePageTabs();
    }
  }
}