import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/checkout.dart';

// PURPOSE:
// Create the cart page
var no_of_products = 0;
List<BuildCard> basket = new List<BuildCard>();
var total_cost = 0;

// This Function creates a ListView of the items in the user's shopping cart
class ShoppingCart extends StatefulWidget {
  @override
  String name, price;
  String image;
  ShoppingCart(String iname, String iprice, String iimage){
    this.name = iname;
    this.price = iprice;
    this.image = iimage;
    no_of_products = no_of_products + 1;
    /*if (basket.length>0){    
      for (var i=basket.length-1; i<basket.length; i++){
        if (name != ''){total_cost = total_cost + int.parse(basket[i].prodPrice);}
    }}*/
  }
  _ShoppingCartState createState() => _ShoppingCartState();
}


class _ShoppingCartState extends State<ShoppingCart> {
  @override

  Widget build(BuildContext context) {
    if (widget.name != ''){
      
        var card = BuildCard(
            prodName: widget.name,
            prodPrice: widget.price,
            prodSize: 'Small',
            prodQuantity: '2',
            image: widget.image,
          );
          basket.add(card);
              if (basket.length>0){    
      for (var i=basket.length-1; i<basket.length; i++){
        if (widget.name != ''){total_cost = total_cost + int.parse(basket[i].prodPrice);}
    }}
          no_of_products = no_of_products + 1;}
    //else{return Container();}
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
        itemCount: basket.length,
        // Calls the same function to make the details of one product
        itemBuilder: (BuildContext context, int index) {
           return basket[index];
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
  String image;
  int basketId = no_of_products;

  BuildCard({this.prodName, this.prodPrice, this.prodQuantity, this.prodSize, this.image});
  //print(image);
  static const sizeList = ['Small', 'Medium', 'Large'];
  var currentSelected = "Small";
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
            decoration: BoxDecoration(
              image: DecorationImage(
                 image: NetworkImage(this.image),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(12.0)
            ),

              //child: FittedBox(child: Image.network(this.image,),
                //fit: BoxFit.fill,
              //),

          ),
        ),
        //cart product image

        // INFORMATION
        Stack(
          children: <Widget>[

            // NAME
            Container(
              height: 150,
              child: Align(
                alignment: Alignment(0,-0.9),
                child: Text(prodName)
              ),
            ),

            // PRICE
            Container(
              height: 150,
              child: Align(
                alignment: Alignment(0,-0.6),
                child: Text(prodPrice),
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
                  child:  Text('Size: '),
                  onPressed: (){},
                ),
              ),
            ),
            Positioned(
              top: 62,
              left: 59 ,
              child: Container(
                height: 23,
                width: 25,
                color: Colors.white,
                child: Text('XL', style: TextStyle(fontWeight: FontWeight.bold), ),
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
                  child: Text('Remove Item'),
                  onPressed: (){
                    basket.remove(this);
                    var price = int.parse(this.prodPrice);
                    total_cost = total_cost - price;
                    //basket.length = basket.length - 1;
                    /*for (var i=0; i<20; i++) {
                      if (i == basketId){
                        basket.removeAt(i);
                      }
                    }*/
                    //basket.clear();
                    //basket.length = basket.length - 1;
                    if (basket.length == 0){total_cost = 0;}
                  },
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
                    total_cost.toString(),
                    style: TextStyle(fontSize: 24,)
                  ),
                ]
              )
            ),

            // CHECKOUT BUTTON
            InkWell(
              onTap: () {
                List temp = basket;
                basket.clear();
                total_cost = 0;
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(temp),
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