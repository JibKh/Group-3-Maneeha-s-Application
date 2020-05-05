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
          color: Colors.black,
          //on pressing the back button, the user returns to the previous screen
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black,
          )
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                            borderRadius: new BorderRadius.circular(5),
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
      bottomNavigationBar: BottomNavigation(),//Container(
      //   child: Row(
      //     children: <Widget>[
      //       Expanded(
      //         child: ListTile(
      //           title: Text("Total :"),
      //           //text[price] returns the price received from the previous screen
      //           subtitle: Text(text['price'].toString()),
      //         ),
      //       ),
      //       Expanded(
      //         //button starts
      //         child: RaisedButton(
      //           shape: new RoundedRectangleBorder(
      //               borderRadius: new BorderRadius.circular(16.0),
      //               side: BorderSide(color: Colors.transparent)),

      //           //pressing this button takes the user to the checkout screen and sends the product data along
      //           onPressed: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => Checkout(text: text),
      //                 ));
      //           },

      //           color: Colors.green,
      //           child: Text(
      //             'Checkout',
      //             style: TextStyle(
      //               fontSize: 15.0,
      //               color: Colors.white,
      //               fontWeight: FontWeight.bold,
      //               fontStyle: FontStyle.italic,
      //             ),
      //           ),
      //         ),
      //         //button ends
      //       ),
      //     ],
      //   ),
      // ),
      //Bottom bar ends
    );
  }
}

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  // For the dropdown list
  static const sizeList = ['Small', 'Medium', 'Large'];
  var currentSelected = "Small";

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                'Total: 600pkr',
                style: TextStyle(fontSize: 18,)
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(text: 'text'),
                  ));
              },
              child: Container(
                height: 45,
                width: 190,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      wordSpacing: 2.0,
                      letterSpacing: 0.9,
                    ),
                  ),
                )
              ),
            ),
          ],
        )
      ),
    );
  }
}