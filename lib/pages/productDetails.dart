import 'package:first_proj/util/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:carousel_pro/carousel_pro.dart';

// PURPOSE:
// Display the product details: Pictures, description, price and reviews (yet to be done)
// Add product to the cart

class ProductDescription extends StatefulWidget {
  
  // VARIABLES TO DISPLAY 
  // Stock is not displayed
  @override
  String productName;
  String productPrice;
  dynamic productImage;
  String productDesc;
  int productStock;
  String purpose;
  dynamic prodID;
  var user;

  // Constructor
  ProductDescription(String name, String price, dynamic image, String desc, int stock, String purpose, dynamic prodID, var user){
    this.productName = name;
    this.productPrice = price;
    this.productImage = image;
    this.productDesc = desc;
    this.productStock = stock;
    this.purpose = purpose;
    this.prodID = prodID;
    this.user = user;
  }
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Products").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    return FutureBuilder(
      future: getPosts(),
      builder: (_, snapshot) {
        print(widget.productImage[0]);
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  // =================== START IMAGE ===================
                  Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),

                      // Image Carousel
                      Container(
                        height: MediaQuery.of(context).size.height / 2 + 65,
                        width: MediaQuery.of(context).size.width,
                        child: Carousel(
                          boxFit: BoxFit.cover,
                          images: [
                            Image.network(widget.productImage[0], fit: BoxFit.cover), //height: MediaQuery.of(context).size.height / 2 + 65, width: MediaQuery.of(context).size.width, 
                            Image.network(widget.productImage[1], fit: BoxFit.cover),
                            Image.network(widget.productImage[2], fit: BoxFit.cover),
                          ],
                          autoplay: false,
                          animationCurve: Curves.easeInOutQuad,
                          animationDuration: Duration(milliseconds: 900),
                          dotSize: 8.0,
                          dotBgColor: Colors.grey.withOpacity(0),
                          dotIncreaseSize: 1.5,
                          dotIncreasedColor: Colors.white,
                          dotColor: Colors.grey,
                        ),
                      ),

                      // Back arrow
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25.0, 55.0, 25.0, 15.0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          elevation: 0,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  // =================== END IMAGE ===================

                  // =================== START BODY ===================
                  Container(
                    padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 15.0),
                    child: Column(
                      children: <Widget>[
                        // ==== START Name and Price ====
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.productName,
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.9,
                                ),
                              ),
                              Text(
                                '\$' + widget.productPrice,
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ==== END Name and Price ====

                        // ==== START Description ====
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              widget.productDesc,
                              style: TextStyle(
                                fontSize: 16.5,
                                color: Colors.black54,
                                height: 1.35,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        // ==== END Description ====
                      ],
                    ),
                  ),
                  // ================ END BODY ================
                ],
              ),
            ),

            // ====== BOTTOM NAVIGATION BAR FOR CART AND SIZE ======
            bottomNavigationBar: BottomNavigation(widget.productName, widget.productPrice, widget.productImage, widget.purpose, widget.prodID, widget.user),
          ),
        );
      }
    );
  }
}

// Bottom Navigation for Shopping cart button and size dropdown
class BottomNavigation extends StatefulWidget {

  String productName;
  String productPrice;
  dynamic productImage;
  String purpose;
  dynamic prodID;
  var user;

  // Constructor
  BottomNavigation(String name, String price, dynamic image, String purpose, dynamic prodID, var user){
    this.productName = name;
    this.productPrice = price;
    this.productImage = image;
    this.purpose = purpose;
    this.prodID = prodID;
    this.user = user;
  }

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('UserCart').getDocuments();
    return qn.documents;
  }

  final CollectionReference userCart = Firestore.instance.collection('UserCart');

  Future updateCart(dynamic snapshot) async {
    print('Product desc: ');
    print(widget.user.uid);
    var dict = {
      'prodID': widget.prodID,
      'name': widget.productName,
      'price': widget.productPrice,
      'image': widget.productImage,
      'size': this.currentSelected,
    };
    return await userCart.document(widget.user.uid).updateData({
        'productID': FieldValue.arrayUnion([widget.prodID]),
        'products': FieldValue.arrayUnion([dict]),
      });
  }

  // For the dropdown list
  static const sizeList = ['Small', 'Medium', 'Large'];
  var currentSelected = "Small";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPosts(),
      builder: (_, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Loading();
        } else {
            return BottomAppBar(
              shape: CircularNotchedRectangle(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    
                    // ========= START DROPDOWN =========
                    DropdownButton<String>(
                      hint: Text('Size'),
                      onChanged: (String select) {
                        setState(() {
                          this.currentSelected = select;
                        });
                      },
                      items: sizeList.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: currentSelected,
                    ),
                    // ========= END DROPDOWN =========

                    // ========= START ADD TO CART BUTTON =========
                    InkWell(
                      onTap: () async {
                        if (widget.purpose == 'homepage' || widget.purpose == 'category' || widget.purpose == 'small') {
                          showDialog(
                            context: context,
                            builder: (_) => CupertinoAlertDialog(title: Text('Added!')),
                            barrierDismissible: true,
                          );
                          // WE WANT TO UPDATE THE USER CART WITH THIS PRODUCT AND GIVE A CONFIRMATION.
                          await updateCart(snapshot);
                        }
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
                            widget.purpose != 'homepage' && widget.purpose != 'category' && widget.purpose == 'small'? 'Can\'t add to cart as admin' : 'Add to Cart', // This will inform the admin that they cannot press this button.
                            style: TextStyle(
                              fontSize: widget.purpose != 'homepage' && widget.purpose != 'category' ? 13.0 : 18.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              wordSpacing: 2.0,
                              letterSpacing: 0.9,
                            ),
                          ),
                        )
                      ),
                    )
                    // ========= END ADD TO CART BUTTON =========

                  ],
                )
              ),
            );
        }
      }
      
    );
  }
}