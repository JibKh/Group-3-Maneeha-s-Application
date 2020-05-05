import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/checkout.dart';

// PURPOSE:
// Create the cart page

// This Function creates a ListView of the items in the user's shopping cart
class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // =========== START APP BAR ===========
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
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
      // =========== END APP BAR ===========

      // ================= START LIST VIEW =================
      body: ListView.builder(
        itemCount: 2,
        // Calls the same function to make the details of one product
        itemBuilder: (BuildContext context, int index) {
          return BuildCard(
            prodName: 'Generic Coat',
            prodPrice: '600',
            prodSize: 'Small',
            prodQuantity: '2',
          );
        },
        scrollDirection: Axis.vertical,
      ),
      // ================= END LIST VIEW =================

      // Calls function at the bottom of this file to create the bottom navigation bar.
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

// Builds one product information
class BuildCard extends StatelessWidget {

  String prodName;
  String prodPrice;
  String prodSize;
  String prodQuantity;

  BuildCard({this.prodName, this.prodPrice, this.prodQuantity, this.prodSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        // IMAGE
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            alignment: Alignment(-1,0),
            height: 150,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset('images/cute-cheap-clothes-under-50.jpeg'),
            ),
          ),
        ),

        // INFORMATION
        Stack(
          children: <Widget>[

            // NAME
            Container(
              height: 150,
              child: Align(
                alignment: Alignment(0,-0.9),
                child: Text('Generic Coat')
              ),
            ),

            // PRICE
            Container(
              height: 150,
              child: Align(
                alignment: Alignment(0,-0.6),
                child: Text('PKR 600'),
              ),
            ),

            // SIZE
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

            // QUANTITY
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

            // DELETE
            Container(
              height: 150,
              width: 200,
              alignment: Alignment(1.5,-1.15),
              child: IconButton(icon: Icon(Icons.delete,color: Colors.black,),onPressed: (){},),
            )
          ],
        ),
      ],
    );
  }
}

// Bottom navigation bar for total price and Checkout button
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

            // PRICE
            FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(
                    'Total: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Rs. 600',
                    style: TextStyle(fontSize: 24,)
                  ),
                ]
              )
            ),

            // CHECKOUT BUTTON
            InkWell(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(),
                  ));
              },
              child: Container(
                height: 45,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: Text(
                    'Checkout',
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