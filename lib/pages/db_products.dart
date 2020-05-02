import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class ProductService{
  Firestore _firestore = Firestore.instance;
//  name of our collection
  String ref = 'Products';

  void uploadProducts(String productName, List images, String productCat, String productPrice, String productDesc) {
//    giving each new product an id
    var id = Uuid();
    String ProductId = id.v1();
//    details holds details of our product that we'll upload. we're gonna get details from addProduct page
    _firestore.collection(ref).document(ProductId).setData({
//      where you will upload the data
      'name': productName,
      'image':images,
      'category':productCat,
      'price':productPrice,
      'Desc':productDesc,
      'shortDesc': productName,
      'searchKey': productName,
      'TotalStock': int.parse(productPrice)
    });
  }
}

