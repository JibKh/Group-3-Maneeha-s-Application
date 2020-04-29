import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/checkout.dart';

// The purpose of this page is to create the cart page

class ShoppingCart extends StatelessWidget {
  //final text is the data received from the previous screen
  final text;
  ShoppingCart({Key key, @required this.text}) : super(key: key);

  //sendStuff function sends product details to the nexr screen
  void sendStuff(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Checkout(text: text),
        ));
  }

  //final dict stores the name, size, picture and price of the product
  final dict = {
    'name': 'retro shirt',
    "size": "M",
    "pic": Image.asset('images/cute-cheap-clothes-under-50.jpeg'),
    "price": 1200
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar starts
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          //on pressing the back button, the user returns to the previous screen
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("My Cart",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      //AppBar ends

      body: SingleChildScrollView(
        //Column starts
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Expanded(
                //dict['pic'] returns the price of the product
                child: dict['pic'],
              ),
              Expanded(
                child: ListTile(
                  //dict['name'] returns the name of the product
                  title: Text(text['name']),
                  //dict['size'] returns the size of the product
                  subtitle: Text(text['size']),
                ),
              ),
            ])
          ],
        ),
        //Column ends
      ),

      //Bottom bar starts
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text("Total :"),
                //text[price] returns the price received from the previous screen
                subtitle: Text(text['price'].toString()),
              ),
            ),
            Expanded(
              //button starts
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(16.0),
                    side: BorderSide(color: Colors.transparent)),

                //pressing this button takes the user to the checkout screen and sends the product data along
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Checkout(text: text),
                      ));
                },

                color: Colors.green,
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              //button ends
            ),
          ],
        ),
      ),
      //Bottom bar ends
    );
  }
}
