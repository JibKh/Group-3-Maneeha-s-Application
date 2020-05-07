// Creates the user class for the map structure of the user

class User {
  String uid;
  String email;
  dynamic cart;

  User(String uid, String email){
    this.uid = uid;
    this.email = email;
  }
}