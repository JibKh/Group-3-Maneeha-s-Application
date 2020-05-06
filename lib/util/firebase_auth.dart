import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_proj/util/user.dart';

// Purpose of this file is to carry out firebase authentication for signup and sign in

class AuthService {

  // Create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(user.uid, user.email) : null;
  }

  // Stream for changed user
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with email and password
  Future signInWithEmailAndPassword (String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  
  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password 
  Future registerWithEmailAndPassword (String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Create a new document for the user with the uid
      //await DatabaseService(uid: user.uid).updateUserData("-1", "-1", -1);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      print('Signed out');
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}

// class AuthProvider {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   GoogleSignIn googleSignIn;

//   Future<bool> signInWithEmail(String email, String password) async{
//     try {
//       AuthResult result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
//       FirebaseUser user = result.user;
//       if(user != null)
//       return true;
//       else
//       return false;
//     } catch (e) {
//       print(e.message);
//       return false;
//     }
//   }

//   Future<void> logOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       print("error logging out");
//     }
//   }

//   Future<bool> loginWithGoogle() async {
//     try {
//       googleSignIn = GoogleSignIn();
//       GoogleSignInAccount account = await googleSignIn.signIn();
//       if(account == null )
//         return false;
//       AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
//         idToken: (await account.authentication).idToken,
//         accessToken: (await account.authentication).accessToken,
//       ));
//       if(res.user == null)
//         return false;
//       return true;
//     } catch (e) {
//       print(e.message);
//       print("Error logging with google");
//       return false;
//     }
//   }
// }

// This page was made in help with:
// https://pub.dev/packages/firebase_auth
// https://www.youtube.com/watch?v=f6PrF22rqnI&t=1389s