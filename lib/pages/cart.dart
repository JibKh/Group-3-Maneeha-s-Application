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
      )
    );
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
        title: Text(
          "My Cart",
          style: TextStyle(
            color: Colors.white,
          )
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      //AppBar ends

      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  alignment: Alignment(-1,0),
                  height: 150,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    //dict['pic'] returns the price of the product
                    child: dict['pic'],
                  ),
                ),
              ),

              Stack(
                children: <Widget>[
                  Container(
                    height: 150,
                    child: Align(
                      alignment: Alignment(0,-0.9),
                      child: Text('Generic Coat')
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Align(
                      alignment: Alignment(0,-0.6),
                      child: Text('PKR 600'),
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Align(
                      alignment: Alignment(0,-0.1),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(16.0),
                            side: BorderSide(color: Colors.black)
                        ),
                        color: Colors.white,
                        child: Text('Size'),
                        onPressed: (){},
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 200,
                    child: Align(
                      alignment: Alignment(0.8,-0.1),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(16.0),
                            side: BorderSide(color: Colors.black)
                        ),
                        color: Colors.white,
                        child: Text('Color'),
                        onPressed: (){},
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Align(
                      alignment: Alignment(0,1),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5),
                          side: BorderSide(color: Colors.black)
                        ),
                        color: Colors.white,
                        child: Text('Quantity'),
                        onPressed: (){},
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 200,
                    alignment: Alignment(1.5,-1.15),
                    child: IconButton(icon: Icon(Icons.delete,color: Colors.black,),onPressed: (){},),
                  )

                ],
              ),
            ],
          ),
        ],

        //ListView ends
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
