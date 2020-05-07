import 'dart:math';

import 'package:first_proj/util/gridProducts.dart';
import 'package:flutter/material.dart';

// PURPOSE:
// Set up the list of products when a category is selected

class ProductListCategories extends StatefulWidget {

  String category;
  var user;

  ProductListCategories(String category, var user) {
    this.category = category;
    this.user = user;
  }

  @override
  _ProductListCategories createState() => _ProductListCategories(category);
}

class _ProductListCategories extends State<ProductListCategories> {

  String category;
  _ProductListCategories(String category) {
    this.category = category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Center(child: Text('Maneeha\'s', style: TextStyle(color: Colors.black))),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), color: Colors.black, onPressed: () {},),
        ],
      ),

      // ======================== START BODY ========================
      body: Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            height: 47,
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                category[0].toUpperCase() + category.substring(1), // Make first letter capital, rest small.
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                )),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.9),
                  blurRadius: 0.6,
                )
              ]
            )
          ),
          // ====== START GRIDVIEW OF PRODUCTS ======
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          new Flexible(
            child: GridProducts.categoryList(category, widget.user),
          )
          // ====== END GRIDVIEW OF PRODUCTS ======
        ],
      ),

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