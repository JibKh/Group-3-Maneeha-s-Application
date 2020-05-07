import 'package:flutter/material.dart';
import 'package:first_proj/util/gridProducts.dart';
import 'package:first_proj/util/gridProducts_small.dart';

// PURPOSE: 
// Setup the homescreen body which is a gridview of products

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double shortestSize=MediaQuery.of(context).size.width;
    final bool UseSmall=shortestSize<415.0;
    return Scaffold(

      // ======================== START BODY ========================
      body: Column(
        children: <Widget>[
          // ====== START GRIDVIEW OF PRODUCTS ======
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          new Flexible(
            child: /*Text('${shortestSize}')*/UseSmall ? GridProducts_small():GridProducts(),
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