import 'package:first_proj/admin/EditProducts.dart';
import 'package:first_proj/util/EditProductsDisplayPage.dart';
import 'package:first_proj/util/loading.dart';
import 'package:first_proj/util/product.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/productDetails.dart';
import 'package:provider/provider.dart';
import 'package:first_proj/util/databaseProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'EditProductsDisplayPage.dart';

// PURPOSE:
// Creates the gridview of products for the HOMEPAGE
// OR
// Creates the gridview of a selected CATEGORY page

class GridProducts extends StatefulWidget {

  // Purpose:
  // adminView -> remove onTap to product description
  // category -> show only those category
  // homepage -> display all products
  String purpose;
  String category;


  // DEFAULT CONSTRUCTOR - This is for the homepage
  GridProducts() {
    this.purpose = 'homepage';
  }

  GridProducts.admin(String purpose) {
    this.purpose = purpose;
  }

  // NAMED CONSTRUCTOR - For when a category is selected
  GridProducts.categoryList(String category) {
    this.purpose = 'category';
    this.category = category;
  }

  @override
  _ProductsState createState() => _ProductsState();
}

// Sets up the gridview structure for all the products.
// It calls the SingleProduct function to create a single product
class _ProductsState extends State<GridProducts> {

  // Setup an instance of firestore and retrieve the Product data.
  Future getPosts() async {

    // If its called for a category, then return products of that category. Else return all.
    if (widget.purpose == 'category') {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore.collection('Products')
          .where('category', isEqualTo: widget.category).getDocuments();
      return qn.documents;
    } else {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore.collection("Products").getDocuments();
      return qn.documents;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
      value: DatabaseService().prods,
      child: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              // Shows a loading screen while waiting
              return Loading();
            }
            else {
              return Scaffold(
                  body: GridView.count(
                      physics: BouncingScrollPhysics(),
                      //mainAxisSpacing: 15,
                      crossAxisCount: 2,
                      //childAspectRatio: 0.90,
                      childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),

                      // This is a function that traverses through all the items and makes a gridview out of all of them.
                      // It calls the widget SingleProduct
                      children: List.generate(
                          snapshot.data.length, (index) {
                        return Padding(
                          //height:200,
                          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 0),

                          //This function will create the card and the description.
                          child: SingleProduct(
                            productName: snapshot.data[index].data['name'],
                            productPic: snapshot.data[index].data['image'][0],
                            productPrice: snapshot.data[index].data['price'],
                            desc: snapshot.data[index].data['desc'],
                            stock: snapshot.data[index].data['stock'],
                            allPictures: snapshot.data[index].data['image'],
                            prodID: snapshot.data[index].documentID,
                            purpose: widget.purpose,
                          ),
                        );
                      }
                      )
                  )
              );
            }
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
  final allPictures;
  final purpose;
  final prodID;

  SingleProduct({
    this.productName,
    this.productPic,
    this.productPrice,
    this.desc,
    this.stock,
    this.allPictures,
    this.purpose,
    this.prodID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 50,
        child: Column(
          children: <Widget>[
            // ============== START ITEM PICTURE ==============
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
                          return ProductDescription(productName, productPrice, allPictures, desc, stock, purpose);
                        }));
                      },
                    )
                ),
              ),
            ),
            // ============== END ITEM PICTURE ==============

            // ============== START DESCRIPTION WITH ADMIN BUTTONS ==============

            // Name
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                    child: Text('$productName',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  ),

                  // Remove product button for admin only
                  purpose == 'adminRemove' ? RaisedButton(
                    child: Text('Remove'),
                    onPressed: (){
                      showPopup(context, prodID);
                    },) : Container(),

                  // Edit product button for admin only
                  purpose == 'adminEdit' ? RaisedButton(
                    child: Text('Edit'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
//    ==========================TAKES U TO EDIT PRODUCTS.DART=============
                            builder: (context) => EditProductsDisplay(prodID:prodID,name:productName,price:productPrice,stock:stock,desc:desc,allPictures:allPictures),
                          ));
                    },
                  ) : Container(),

                ],
              ),
            ),

            // Price
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
            // ============== START DESCRIPTION WITH ADMIN BUTTONS ==============
          ],
        ));
  }
}