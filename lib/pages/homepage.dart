import 'package:flutter/material.dart';
import 'package:first_proj/util/gridProducts.dart';

// PURPOSE: 
// Setup the homescreen body which is a gridview of products

class HomePage extends StatefulWidget {

  var user;
  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    //creating bool variable that check if the screen size is less than or greater than a certain threshold
    final double shortestSize = MediaQuery.of(context).size.width;

    final bool useSmall = shortestSize<415.0;

    return Scaffold(

      // ======================== START BODY ========================
      body: Column(
        children: <Widget>[
          // ====== START GRIDVIEW OF PRODUCTS ======
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          new Flexible(
            //depending on the threshold we choose the appropriate gridview
            child: useSmall ? GridProducts.small('small', widget.user) : GridProducts(widget.user),
          )
          // ====== END GRIDVIEW OF PRODUCTS ======
        ],
      )
    );
  }
}