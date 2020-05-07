import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_proj/util/order.dart';

// PURPOSE:
// This is the file that retrieves and sends mapped out of ALL ORDERS data to the calling function

class DatabaseService {

  final int uid;
  DatabaseService({this.uid});

  //Gets the instance of the collection
  final CollectionReference orderCollection = Firestore.instance.collection('Orders');
  
  // Sets initial data
  Future updateOrderData(dynamic prodID, dynamic products, String location, int contact, String orderProgress, String userID) async {
    return await orderCollection.document(uid.toString()).setData({
      'productID': prodID,
      'products': products,
      'location': location,
      'contact': contact,
      'orderProgress': orderProgress,
      'userID': userID,
    });
  }

  // Mapping function
  List<Order> orderFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Order(
        userID: doc.data['userID'] ?? '',
        prodID: doc.data['prodID'] ?? '',
        location: doc.data['location'] ?? '',
        contact: doc.data['contact'] ?? '',
        progress: doc.data['progress'] ?? '',
      );
    }).toList();
  }

  Stream<List<Order>> get order {
    return orderCollection.snapshots()
      .map(orderFromSnapshot);
  }

}