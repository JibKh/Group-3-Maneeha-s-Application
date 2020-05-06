import 'package:cloud_firestore/cloud_firestore.dart';

// PURPOSE:
// This is the file that retrieves and sends mapped out updated USER data to the calling function

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference cartCollection = Firestore.instance.collection('Products');

  // Future updateUserData(String uid, String size, int amount) async {
  //   return await cartCollection.document(this.uid).setData({
  //     'uid' : uid,
  //     'size' : size,
  //     'amount' : amount,
  //   });
  // }

  // product list from snapshot
  // List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return Product(
  //       name: doc.data['name'] ?? 'HELP',
  //       price: doc.data['price'] ?? 0,
  //       desc: doc.data['Desc'] ?? 'HELP',
  //       shortDesc: doc.data['shortDesc'] ?? 'HELP',
  //       image: doc.data['image'] ?? 'HELP',
  //       sizeStock: doc.data['SizeStock'] ?? 0,
  //       totalStock: doc.data['TotalStock'] ?? 0,
  //     );
  //   }).toList();
  // }

  //Get UserCart stream
  // Stream<List<Product>> get products {
  //   return cartCollection.snapshots()
  //     .map(_productListFromSnapshot);
  // }

  // SEND UPDATED DATA
  Stream<QuerySnapshot> get products {
    return cartCollection.snapshots();
  }

}