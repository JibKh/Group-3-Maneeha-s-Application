import 'package:first_proj/admin/inventory.dart';
//import 'package:first_proj/pages/orders.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          elevation: 4,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Center(child: Text('Admin Side', style: TextStyle(color: Colors.black))),


          // Creates the Home-Categories bar
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(text: 'Inventory',),
              Tab(text: 'Inventory')
            ]
          )
        ),

        body: TabBarView(
          children: <Widget>[
            Inventory(),
            Inventory(),
          ],
        ),


      ) 
    );
  }
}