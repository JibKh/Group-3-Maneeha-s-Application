import 'package:first_proj/util/loading.dart';
import 'package:first_proj/util/product.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/productDetails.dart';
import 'package:provider/provider.dart';
import 'package:first_proj/util/databaseProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryGridProducts extends StatefulWidget {

  String category;
  CategoryGridProducts(String category) {
    this.category = category;
  }

  @override
  _CategoryGridProducts createState() => _CategoryGridProducts(category);
}

// STATEFUL Widget. Sends information about product to SINGLE_PRODUCT function which is STATELESS widget.
class _CategoryGridProducts extends State<CategoryGridProducts> {

  String category;
  _CategoryGridProducts(String category) {
    this.category = category;
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Products')
      .where('category', isEqualTo: category).getDocuments();
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
            return Loading();
          }
          else {
            return Scaffold(
              body: GridView.count(
                //mainAxisSpacing: 15,
                crossAxisCount: 2,
                //childAspectRatio: 0.90,
                childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),

                // This is a function that traverses through all the items and makes a gridview out of all of them.
                // It Calls stateless widget Single_Product function after padding.
                children: List.generate(
                  snapshot.data.length, (index) {
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
            );
          };
        }
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