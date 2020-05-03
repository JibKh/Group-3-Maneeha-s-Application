import 'package:flutter/material.dart';
import 'package:first_proj/util/categoriesGridProducts.dart';

// PURPOSE:
// Set up the list of products when a category is selected

class ProductListCategories extends StatefulWidget {

  String category;
  ProductListCategories(String category) {
    this.category = category;
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
          new Padding(
            padding: EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text('N'),
              )
            )
          ),
          // ====== START GRIDVIEW OF PRODUCTS ======
          new Flexible(
            child: CategoryGridProducts(category),
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