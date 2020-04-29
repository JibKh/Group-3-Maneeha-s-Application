//import 'package:first_proj/pages/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_proj/util/database.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/util/gridProducts.dart';
import 'package:provider/provider.dart';

// The purpose of this page is to setup the homescreen body.

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().products,
        child: Scaffold(

        // ======================== START BODY ========================
        body: Column(
          children: <Widget>[
            // ====== START GRIDVIEW OF PRODUCTS ======
            new Flexible(
              child: GridProducts(),
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
      ),
    );
  }
}