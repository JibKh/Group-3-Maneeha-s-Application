// THIS FILE IS CURRENTLY NOT BEING USED ANYWHERE

import 'package:flutter/material.dart';
import 'package:first_proj/util/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
    //return StreamProvider<List<Product>>.value(
      value: DatabaseService().products,
      child: Scaffold(
        body: CartList(),        
      ),
    );
  }
}

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    
    //final product = Provider.of<List<Product>>(context);
    final userCart = Provider.of<QuerySnapshot>(context);
    
    for (var doc in userCart.documents) {
      print(doc.data['name']);
    }
    
    // product.forEach((product) {
    //   print(product.name);
    //   print(product.price);
    //   print(product.shortDesc);
    // });

    return Container(
      
    );
  }
}