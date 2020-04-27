import 'package:flutter/material.dart';
import 'package:first_proj/pages/productDetails.dart';

class GridProducts extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

// STATEFUL Widget. Sends information about product to SINGLE_PRODUCT function which is STATELESS widget.
class _ProductsState extends State<GridProducts> {
  var productList = [
    {
      "name": "edgfg Ripped Jeans",
      "picture": "images/cute-cheap-clothes-under-50.jpeg",
      "price": 95,
    },
    {
      "name": "Striped Shirt",
      "picture": "images/cute-cheap-clothes-under-50.jpeg",
      "price": 90,
    },
    {
      "name": "Sleeveles Shirt",
      "picture": "images/cute-cheap-clothes-under-50.jpeg",
      "price": 90,
    },
    {
      "name": "Mom Jeans",
      "picture": "images/cute-cheap-clothes-under-50.jpeg",
      "price": 910,
    },
    {
      "name": "Collared T-Shirt",
      "picture": "images/cute-cheap-clothes-under-50.jpeg",
      "price": 910,
    },
    {
      "name": "Ripped Jeans",
      "picture": "images/cute-cheap-clothes-under-50.jpeg",
      "price": 910,
    },
    {
      "name": "Jeans",
      "picture": "images/cute-cheap-clothes-under-50.jpeg",
      "price": 910,
    },
    {
      "name": "Jeans",
      "picture": "images/cute-cheap-clothes-under-50.jpeg",
      "price": 910,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        //mainAxisSpacing: 15,
        crossAxisCount: 2,
        //childAspectRatio: 0.90,
        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),

        // This is a function that traverses through all the items and makes a gridview out of all of them.
        // It Calls stateless widget Single_Product function after padding.
        children: List.generate(productList.length, (index) 
        {
          return Padding(
            //height:200,
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 0),

            //Calling of stateless function. This will create the card and the description.
            child: SingleProduct(
              productName: productList[index]['name'],
              productPic: productList[index]['picture'],
              productPrice: productList[index]['price'],
            ),
          );
        }
        )
      )
    );
  }
}

// ================== SINGLE PRODUCT ==================

// Single_Product function. It has a class and a constructor who's information is provided by the stateful widget above.
// It creates the card and description of a single product.
class SingleProduct extends StatelessWidget {
  final productName;
  final productPic;
  final productPrice;

  SingleProduct({
    this.productName,
    this.productPic,
    this.productPrice,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 50,
      child: Column(
      children: <Widget>[
        // ITEM PICTURE IS SET HERE ON A CARD
        AspectRatio(
          aspectRatio: 0.9,
          child: Card(
            elevation: 0,
            child: Material(
              child: InkWell(
              child: GridTile(
                child: Image.asset(
                  productPic,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                return Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return MyHomePage();
                }));
              },
              )
            ),
          ),
        ),

        // ITEM DESCRIPTION - NAME
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
            child: Text('$productName',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
          ),
        ),

        // ITEM DESCRIPTION - PRICE
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
            child: Text(
              '\$$productPrice',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ));
  }
}
