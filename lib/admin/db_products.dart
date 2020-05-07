import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class ProductService{
  final CollectionReference orders = Firestore.instance.collection('Products');
//  name of our collection
  String ref = 'Products';

  void uploadProducts(String productName, String productCat, List url, String productPrice, String ProdQuantity ,String productDesc) {
//    giving each new product an id
    var id = Uuid();
    String ProductId = id.v1();
//    details holds details of our product that we'll upload. we're gonna get details from addProduct page
    /*_firestore.collection(ref).document(ProductId).setData({
//      where you will upload the data
      'name': productName,
      //'image':images,
      'category':productCat,
      'price':productPrice,
      'Desc':productDesc,
      'shortDesc': productName,
      'searchKey': productName,
      'TotalStock': int.parse(productPrice)
    });*/
    Future updateOrders() async {
      return await orders.document(ProductId).setData({
        'name' : productName,
        'price' : productPrice,
        'desc' : productDesc,
        'category':productCat,
        'stock' : ProdQuantity,
        'image' : url
      });
    }
    updateOrders();
  }

  void editProducts(String productName, var id, List url, String productPrice, int ProdQuantity ,String productDesc) {
//    giving each new product an id
//    details holds details of our product that we'll upload. we're gonna get details from addProduct page
    /*_firestore.collection(ref).document(ProductId).setData({
//      where you will upload the data
      'name': productName,
      //'image':images,
      'category':productCat,
      'price':productPrice,
      'Desc':productDesc,
      'shortDesc': productName,
      'searchKey': productName,
      'TotalStock': int.parse(productPrice)
    });*/
    Future updateOrders() async {
      return await orders.document(id).updateData({
        'name' : productName,
        'price' : productPrice,
        'desc' : productDesc,
        'stock' : ProdQuantity,
        'image' : url
      });
    }
    updateOrders();
  }
}

