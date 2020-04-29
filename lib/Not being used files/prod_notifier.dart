// // THIS FILE IS CURRENTLY NOT BEING USED ANYWHERE AT ALL

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'product.dart';

// class DatabaseService {

//   DatabaseService();
//   final CollectionReference productsCollection = Firestore.instance.collection('Products');

//   List<Product> prodlistFromSnapshot(QuerySnapshot snapshot){
//     return snapshot.documents.map((doc){
//       return Product(
//         name: doc.data['name'] ?? '',
//         image: doc.data['image'] ?? '',
//         price: doc.data['price'] ?? 0
//       );
//     }).toList();
//   }

//   Stream<List<Product>> get prods {
//     return productsCollection.snapshots()
//     .map(prodlistFromSnapshot);
//   }
// }