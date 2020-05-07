//Creates the UserOrder class for the map structure of the User OrderS

class UserOrder {

  dynamic userID;
  dynamic prodID;
  String location;
  int contact;
  String progress;
  dynamic products;

  UserOrder({this.userID, this.prodID, this.location, this.contact, this.progress, this.products});
}