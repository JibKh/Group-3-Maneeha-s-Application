import 'package:first_proj/admin/inventory.dart';
import 'package:first_proj/admin/orders.dart';
import 'package:flutter/material.dart';

// Admin side homepage interface

class Admin extends StatefulWidget {

  var user;
  Admin({this.user});

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
           elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              'Admin', 
              style: TextStyle(color: Colors.white))),
          
          // Creates the Home-Categories bar
          bottom: TabBar(
            labelColor: Colors.white, labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.9),
            tabs: <Widget>[
              Tab(text: 'Inventory',),
              Tab(text: 'Orders')
            ]
          )
        ),

        body: TabBarView(
          children: <Widget>[
            Inventory(), //shows list of opens on inventory side
            Orders(user: widget.user), //shows list of opens on orders side
          ],
        ),


      ) 
    );
  }
}