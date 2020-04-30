import 'package:first_proj/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/productDetails.dart';
import 'package:provider/provider.dart';
import 'package:first_proj/pages/prod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GridProducts extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

// STATEFUL Widget. Sends information about product to SINGLE_PRODUCT function which is STATELESS widget.
class _ProductsState extends State<GridProducts> {
  var productList = [
    {
      "name": "Summer Ripped Jeans",
      "picture": Image.network('https://firebasestorage.googleapis.com/v0/b/maneeha-s-app-database.appspot.com/o/pic3.jpg?alt=media&token=84c266da-98fa-425b-8dc6-f6db5dfb877a'),
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

  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Products").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
        value: DatabaseService().prods,
        child: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
            return Scaffold();              
            }
            else{
            return Scaffold(
            body: GridView.count(
            //mainAxisSpacing: 15,
            crossAxisCount: 2,
            //childAspectRatio: 0.90,
            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),

            // This is a function that traverses through all the items and makes a gridview out of all of them.
            // It Calls stateless widget Single_Product function after padding.
            children: List.generate(4, (index) 
            {
              return Padding(
                //height:200,
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 0),

                //Calling of stateless function. This will create the card and the description.
                child: SingleProduct(
                  productName: snapshot.data[index].data['name'],
                  productPic: snapshot.data[index].data['image'],
                  productPrice: snapshot.data[index].data['price'],
                  desc: snapshot.data[index].data['Desc'],
                  stock: snapshot.data[index].data['Stock']
                ),
              );
            }
            )
          )
      );};}
        ),
    );
  }
}

// ================== SINGLE PRODUCT ==================

// Single_Product function. It has a class and a constructor who's information is provided by the stateful widget above.
// It creates the card and description of a single product.
class SingleProduct extends StatelessWidget {
  //Uint8List imageFile;
  final productName;
  final productPic;
  final productPrice;
  final desc;
  final stock;

  SingleProduct({
    this.productName,
    this.productPic,
    this.productPrice,
    this.desc,
    this.stock
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
                child: Image.network(
                  productPic,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                return Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return MyHomePage(productName, productPrice, Image.network(productPic), desc, stock);
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
