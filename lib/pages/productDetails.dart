import 'package:first_proj/pages/cart.dart';
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

  // Constructor
  ProductDescription(String name, String price, dynamic image, String desc, int stock, String purpose){
    this.productName = name;
    this.productPrice = price;
    this.productImage = image;
    this.productDesc = desc;
    this.productStock = stock;
    this.purpose = purpose;
  }
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {

  // Retrieve data. Currently not being used anywhere.
  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Products").getDocuments();
    return qn.documents;
  }

  int photoIndex = 0;

  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }
  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < widget.productImage.length - 1 ? photoIndex + 1 : 0;
    });
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
            bottomNavigationBar: BottomNavigation(widget.purpose, widget.productName, widget.productPrice, widget.productImage[0]),

          ),
        );
      }
    );
  }
}

// Bottom Navigation for Shopping cart button and size dropdown
class BottomNavigation extends StatefulWidget {

  String purpose, name, price;
  String image;

  BottomNavigation(this.purpose, String iname, String iprice, String iimage){
    this.name = iname;
    this.price = iprice;
    this.image = iimage;
    this.purpose = purpose;
  }

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  //String addname = widget.name;
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
              onTap: () {
                if (widget.purpose != 'admin') { // The admin will not be able to press this button.
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingCart(widget.name, widget.price, widget.image),
                    ));
                }
              },
              child: Container(
                height: 45,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: Text(
                    widget.purpose == 'admin' ? 'Can\'t add to cart as admin' : 'Add to Cart', // This will inform the admin that they cannot press this button.
                    style: TextStyle(
                      fontSize: widget.purpose == 'admin' ? 13.0 : 18.0,
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

// SAAD'S SKELETON CODE COMMENTED OUT.

// void main() => runApp(ProductShopApp());

// class ProductShopApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//       debugShowCheckedModeBanner: true,
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final title = Center(
//     heightFactor: 2.5,
//     child: Text('STORE', style: titleStyle),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Container(
//           margin: const EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 15.0),
//           child: Column(
//             children: <Widget>[
//               title,
//               BigProductTile(),
//               Divider(height: 55.0),
//               SmallProductTiles(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: ProductShopBottomNavigationBar(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:carousel_pro/carousel_pro.dart';
// import 'package:first_proj/pages/cart.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//       //home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
  
//   @override
//   String productName;
//   String productPrice;
//   Image productImage;
//   String desc;
//   int stock;
//   MyHomePage(String name, String price, Image image, String desc, int stock){
//     this.productName = name;
//     this.productPrice = price;
//     this.productImage = image;
//     this.desc = desc;
//     this.stock = stock;
//   }
//   _MyHomePageState createState() => _MyHomePageState();
// }


// class SizeDD {
//   int id;
//   String size;

//   SizeDD(this.id, this.size);

//   static List<SizeDD> getSizes() {
//     return <SizeDD>[
//       SizeDD(1, "XS"),
//       SizeDD(2, "S"),
//       SizeDD(3, "M"),
//       SizeDD(4, "L"),
//       SizeDD(5, "XL"),
//     ];
//   }
// }

// class _MyHomePageState extends State<MyHomePage> {  
  
//   List<SizeDD> _sizes = SizeDD.getSizes();
//   List<DropdownMenuItem<SizeDD>> sizesArray;
//   SizeDD alrSelectedSize;

//   Future getPosts() async{
//     var firestore = Firestore.instance;
//     QuerySnapshot qn = await firestore.collection("Products").getDocuments();
//     return qn.documents;
//   }

//   @override
//   void initState() {
//     sizesArray=buildDropDownMenuItems(_sizes);
//     alrSelectedSize=sizesArray[0].value;
//     super.initState();
//   }
  

//   List<DropdownMenuItem<SizeDD>> buildDropDownMenuItems(List sizes) {
//     List<DropdownMenuItem<SizeDD>> items = List();
//     for(SizeDD size in sizes) {
//       items.add(
//         DropdownMenuItem(
//           value: size, 
//           child: Text(size.size),
//           ),
//         );
//     }
//     return items;
//   }

//   onChangeDropdownItem(SizeDD selectedSize){
//     setState(() {
//       alrSelectedSize=selectedSize;
//     });
//   }
  
  
//   //This is the dictionary that stores the price, name, size of the product
//   //It is assigned random default name, price and size in the beginning
//   var dictToSend = {
//     'name': 'Waleed',
//     "size": "default size",
//     // "pic": Image.asset('assets/20180421_112411.png'),
//     "price": 1200
//   };

//   //price and prodName are the price and product name of the product to be displayed on this page
//   var price = 'PKR 1160';
//   var prodName = 'Waleed';

//   //This function sends the relevant information to the shopping cart screen
//   //the default values that the dictionary was initialised to, are now changed to the details of the product to be displayed and sent to the shopping cart
//   void _sendDataToSecondScreen(
//       BuildContext context, sizeToSend, priceToSend, nameToSend) {
//     dictToSend['name'] = nameToSend;
//     dictToSend['size'] = sizeToSend;
//     // dictToSend['pic']=imageToSend;
//     dictToSend['price'] = priceToSend;
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ShoppingCart(
//             text: dictToSend,
//           ),
//         ));
//   }

//   //Drop down starts
//   String curSize = "";
//   //array that stores size values for drop down
//   var sizes = ["XS", "S", "M", "L", "XL"];
//   //Initially thr item selected is 'select size'
//   var currentItemSelected = "Select Size";
//   //function that updates the currently selected value to the newly chosen one
//   void updateS(newValueSelected) {
//     setState(() {
//       currentItemSelected = newValueSelected;
//     });
//   }
//   //Drop down ends

//   @override
//   Widget build(BuildContext context) {
//     //Image Carousel starts
//     Widget imageCarousel = new Container(
//       padding: EdgeInsets.only(top: 6.0),
//       height: 350.0,
//       child: new Carousel(
//         boxFit: BoxFit.cover,
//         //images array stores the images that will be displayed in the carousel
//         images: [
//           widget.productImage,
//           widget.productImage,
//           widget.productImage,
//           widget.productImage,
//           widget.productImage,
//           widget.productImage,
//         ],
//         //keeping autoplay off as we donot want the images to change on their own
//         autoplay: false,
//         //size of each dot in the indicator
//         dotSize: 6.0,
//         //the width of the padding of the indicator
//         indicatorBgPadding: 4.0,
//       ),
//     );
//     //Image Carousel ends


//     return FutureBuilder(
//       future: getPosts(),
//       builder: (_, snapshot){
//       return Scaffold(
//       //AppBar starts
//       appBar: AppBar(
//         leading: BackButton(
//           color: Colors.white,
//           //on pressing the back button, the user returns to the previous screen
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         // centre title is set to true as we want the title to be in the centre
//         centerTitle: true,
//         title: Text(
//           "Product Details",
//           style: TextStyle(color: Colors.white),
//         ),
//         // keeping background colour transparent so that the images can be seen from under the app bar
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: () {},
//                 child:
//                     Icon(Icons.shopping_cart, color: Colors.white, size: 22.0)
//               ))
//         ],
//       ),
//       //AppBar ends

//       // extending body behind app bar to make image visible from under app bar
//       extendBodyBehindAppBar: true,

//       //using SingleChildScrollView to enable scroll in case page contents do not fit the device screen
//       body: SingleChildScrollView(
//         //column starts
//         child: Column(
//           children: <Widget>[
//             //calling the image carousel widget class
//             imageCarousel,

//             //display product name
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   widget.productName,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
                
//                 ),
//               ],
//             ),
//             //display price
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   widget.productPrice,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),

//             //container starts
//             Container(
//                 padding: EdgeInsets.all(10),

//                 //inner column starts
//                 child: Column(
//                   children: <Widget>[
//                     new Align(
//                       alignment: Alignment(-0.9, 0.7),
//                       child: Text(
//                         "SIZE",
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal,
//                             fontStyle: FontStyle.normal),
//                       ),
//                     ),

//                     //     new Align(
//                     //       alignment: Alignment(-0.9, 1),

//                     //   //dropdown implementation starts
//                     //       child: DropdownButton<String>(

//                     //     // sizes was our list of sizes array, on that array, we are calling a map function which further executes a function which takes a string argument
//                     //     // map function will iterate over the entire sizes array and the argument 'dropDownStringItem' will represent a single size/element in each iteration
//                     //     // in each iteration, we return DropdownMenuItem widget, we use a string. Within this widget, the property of value assigns dropDownStringItem in each iteration
//                     //     // finally wrap value in text widget, convert everything to a list and assign to items property
//                     //         items: sizes.map((String dropDownStringItem) {
//                     //         return DropdownMenuItem<String>(
//                     //         value: dropDownStringItem,
//                     //         child: Text(dropDownStringItem),
//                     //     );
//                     //   }).toList(),

//                     //         // onChanged uses the updateS function to update size to the new value selected
//                     //         onChanged: (String newValueSelected) {
//                     //         updateS(newValueSelected);
//                     //       },
//                     //       value: "$currentItemSelected",
//                     //       hint: Text('Select Size'),
//                     //       ),
//                     //     //dropdown implementation ends
//                     //  ),


//                      new Align(
//                           alignment: Alignment(-0.9, 1),
//                           child: Column(
//                             children: <Widget>[
//                               //Text("Size"),
//                               DropdownButton(
//                                 value: alrSelectedSize,
//                                 items: sizesArray,
//                                 onChanged: onChangeDropdownItem,
//                               ),
//                               //Text('selected: ${alrSelectedSize.size}')
//                             ],
//                           ),
//                     ),

//                     new Align(
//                       alignment: Alignment(-0.9, 0.7),
//                       child: Text(
//                         "\nDETAILS",
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal,
//                             fontStyle: FontStyle.normal),
//                       ),
//                     ),

//                     new Align(
//                       alignment: Alignment(-0.9, 0.7),
//                       child: Text(
//                         '   '+widget.desc,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.normal,
//                             fontStyle: FontStyle.normal),
//                       ),
//                     ),
//                   ],
//                 )
//                 //inner column ends

//                 ),
//             //container ends

//             //button starts
//             ButtonTheme(
//               minWidth: 200,
//               height: 40.0,
//               child: RaisedButton(
//                 shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(16.0),
//                     side: BorderSide(color: Colors.transparent)),
//                 onPressed: () {
//                   // _sendDataToSecondScreen function is called which sends data to the shopping cart screen
//                   _sendDataToSecondScreen(
//                       context, currentItemSelected, price, prodName);
//                 },
//                 color: Colors.green,
//                 child: Text(
//                   'Add to cart',
//                   style: TextStyle(
//                     fontSize: 15.0,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               ),
//             )
//             //button en

//           ],
//         ),
//         //column ends

//       ),
//     );});
//   }
// }
