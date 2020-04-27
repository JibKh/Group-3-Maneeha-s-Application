import 'package:flutter/material.dart';
import 'package:first_proj/Services/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


class Prodlist extends StatefulWidget {
  @override
  _ProdlistState createState() => _ProdlistState();
}

class _ProdlistState extends State<Prodlist> {
  @override
  Widget build(BuildContext context) {
    final prods = Provider.of<List<Product>>(context);
    prods.forEach((element) { print(element.name); print(element.image); print(element.price);});
    return Container(
       
    );
  }
}