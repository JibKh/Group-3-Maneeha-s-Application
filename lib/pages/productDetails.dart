import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:first_proj/pages/cart.dart';

void main() {
  //runApp(MyApp());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //This is the dictionary that stores the price, name, size of the product
  //It is assigned random default name, price and size in the beginning
  var dictToSend = {
    'name': 'default name',
    "size": "default size",
    // "pic": Image.asset('assets/20180421_112411.png'),
    "price": 1200
  };

  //price and prodName are the price and product name of the product to be displayed on this page
  var price = 'PKR 1150';
  var prodName = 'Summer T';

  //This function sends the relevant information to the shopping cart screen
  //the default values that the dictionary was initialised to, are now changed to the details of the product to be displayed and sent to the shopping cart
  void _sendDataToSecondScreen(
      BuildContext context, sizeToSend, priceToSend, nameToSend) {
    dictToSend['name'] = nameToSend;
    dictToSend['size'] = sizeToSend;
    // dictToSend['pic']=imageToSend;
    dictToSend['price'] = priceToSend;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShoppingCart(
            text: dictToSend,
          ),
        ));
  }

  //Drop down starts
  String curSize = "";
  //array that stores size values for drop down
  var sizes = ["XS", "S", "M", "L", "XL"];
  //Initially thr item selected is 'select size'
  var currentItemSelected = "Select Size";
  //function that updates the currently selected value to the newly chosen one
  void updateS(newValueSelected) {
    setState(() {
      currentItemSelected = newValueSelected;
    });
  }
  //Drop down ends

  @override
  Widget build(BuildContext context) {
    //Image Carousel starts
    Widget imageCarousel = new Container(
      padding: EdgeInsets.only(top: 6.0),
      height: 350.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        //images array stores the images that will be displayed in the carousel
        images: [
          AssetImage('images/cute-cheap-clothes-under-50.jpeg'),
          AssetImage('images/cute-cheap-clothes-under-50.jpeg'),
          AssetImage('images/cute-cheap-clothes-under-50.jpeg'),
          AssetImage('images/cute-cheap-clothes-under-50.jpeg'),
          AssetImage('images/cute-cheap-clothes-under-50.jpeg'),
          AssetImage('images/cute-cheap-clothes-under-50.jpeg'),
        ],
        //keeping autoplay off as we donot want the images to change on their own
        autoplay: false,
        //size of each dot in the indicator
        dotSize: 6.0,
        //the width of the padding of the indicator
        indicatorBgPadding: 4.0,
      ),
    );
    //Image Carousel ends

    return Scaffold(
      //AppBar starts
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          //on pressing the back button, the user returns to the previous screen
          onPressed: () {},
        ),
        // centre title is set to true as we want the title to be in the centre
        centerTitle: true,
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.white),
        ),
        // keeping background colour transparent so that the images can be seen from under the app bar
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child:
                    Icon(Icons.shopping_cart, color: Colors.white, size: 22.0),
              ))
        ],
      ),
      //AppBar ends

      // extending body behind app bar to make image visible from under app bar
      extendBodyBehindAppBar: true,

      //using SingleChildScrollView to enable scroll in case page contents do not fit the device screen
      body: SingleChildScrollView(
        //column starts
        child: Column(
          children: <Widget>[
            //calling the image carousel widget class
            imageCarousel,

            //display product name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  prodName,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            //display price
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            //container starts
            Container(
                padding: EdgeInsets.all(10),

                //inner column starts
                child: Column(
                  children: <Widget>[
                    new Align(
                      alignment: Alignment(-0.9, 0.7),
                      child: Text(
                        "SIZE",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal),
                      ),
                    ),

                    //     new Align(
                    //       alignment: Alignment(-0.9, 1),

                    //   //dropdown implementation starts
                    //       child: DropdownButton<String>(

                    //     // sizes was our list of sizes array, on that array, we are calling a map function which further executes a function which takes a string argument
                    //     // map function will iterate over the entire sizes array and the argument 'dropDownStringItem' will represent a single size/element in each iteration
                    //     // in each iteration, we return DropdownMenuItem widget, we use a string. Within this widget, the property of value assigns dropDownStringItem in each iteration
                    //     // finally wrap value in text widget, convert everything to a list and assign to items property
                    //         items: sizes.map((String dropDownStringItem) {
                    //         return DropdownMenuItem<String>(
                    //         value: dropDownStringItem,
                    //         child: Text(dropDownStringItem),
                    //     );
                    //   }).toList(),

                    //         // onChanged uses the updateS function to update size to the new value selected
                    //         onChanged: (String newValueSelected) {
                    //         updateS(newValueSelected);
                    //       },
                    //       value: "$currentItemSelected",
                    //       hint: Text('Select Size'),
                    //       ),
                    //     //dropdown implementation ends
                    //  ),

                    new Align(
                      alignment: Alignment(-0.9, 0.7),
                      child: Text(
                        "DETAILS",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal),
                      ),
                    ),

                    new Align(
                      alignment: Alignment(-0.9, 0.7),
                      child: Text(
                        " - Upgrade your basics \n - High neck \n - Zip placket \n - Embroidered Nike Swoosh logo \n - Contrast piping \n - Drawstring hem \n - Regular fit \n - True to size",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ],
                )
                //inner column ends

                ),
            //container ends

            //button starts
            ButtonTheme(
              minWidth: 200,
              height: 40.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(16.0),
                    side: BorderSide(color: Colors.transparent)),
                onPressed: () {
                  // _sendDataToSecondScreen function is called which sends data to the shopping cart screen
                  _sendDataToSecondScreen(
                      context, currentItemSelected, price, prodName);
                },
                color: Colors.green,
                child: Text(
                  'Add to cart',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            )
            //button ends
          ],
        ),
        //column ends
      ),
    );
  }
}
