// Creates the order class for all the orders placed

class Order {

  dynamic userID;
  dynamic prodID;
  String location;
  int contact;
  String progress;
  dynamic products;

  Order({this.userID, this.prodID, this.location, this.contact, this.progress, this.products});
}