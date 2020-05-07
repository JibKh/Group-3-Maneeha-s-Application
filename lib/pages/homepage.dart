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
    return Scaffold(

      // ======================== START BODY ========================
      body: Column(
        children: <Widget>[
          // ====== START GRIDVIEW OF PRODUCTS ======
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          new Flexible(
            child: GridProducts(widget.user),
          )
          // ====== END GRIDVIEW OF PRODUCTS ======
        ],
      )

      // body: ListView(
      //   children: <Widget>[
          
      //     // ====== START GRIDVIEW OF PRODUCTS ======
      //     new Container(
      //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      //       height: 700.0,
      //       child: GridProducts(),
      //     ),
      //     // ====== END GRIDVIEW OF PRODUCTS ======

      //   ],
      // )
    );
  }
}