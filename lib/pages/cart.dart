import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/checkout.dart';

class ShoppingCart extends StatelessWidget {
  final text;
  ShoppingCart({Key key, @required this.text}) : super(key: key);

  void sendStuff(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Checkout(text: text),
        ));
  }

  final dict = {
    'name': 'retro shirt',
    "size": "M",
    "pic": Image.asset('images/cute-cheap-clothes-under-50.jpeg'),
    "price": 1200
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Expanded(
                child: dict['pic'],
              ),
              Expanded(
                child: ListTile(
                  title: Text(text['name']),
                  subtitle: Text(text['size']),
                ),
              ),
            ])
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text("Total :"),
                subtitle: Text(text['price'].toString()),
              ),
            ),
            Expanded(
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(16.0),
                    side: BorderSide(color: Colors.transparent)),
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
            ),
          ],
        ),
      ),
    );
  }
}
