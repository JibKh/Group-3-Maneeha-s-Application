import 'package:first_proj/pages/HomePageTabs.dart';
import 'package:first_proj/pages/authenticate.dart';
import 'package:first_proj/util/firebase_auth.dart';
import 'package:first_proj/util/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Wrapped in a Strea so it is constantly listening for changes in signin/signup
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

// void main()
// {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: MainScreen()
//   ));
// }

// // Splash page before login page
// // If already logged in then directly to homepage
// // Else show login page
// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.onAuthStateChanged,
//       builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {
//         if(snapshot.connectionState == ConnectionState.waiting)
//           return SplashPage();
//         if(!snapshot.hasData || snapshot.data == null)
//           return LoginPage();
//         return HomePageTabs();
//       },
//     );
//   }
// }