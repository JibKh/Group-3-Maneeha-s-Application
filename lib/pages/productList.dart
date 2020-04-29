// THIS PAGE IS CURRENTLY NOT BEING USED ANYWHERE

import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Center(child: Text('Maneeha\'s - Shirts', style: TextStyle(color: Colors.black))),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), color: Colors.black, onPressed: () {},),
          ],

          // To create the Home-Categories bar
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Categories'
              )
            ]
          )
        ),
      ),
    );
  }
}