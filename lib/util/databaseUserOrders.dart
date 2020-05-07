import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_proj/util/userOrder.dart';

// PURPOSE:
// This is the file that retrieves and sends mapped out data of the USER ORDERS PLACED to the calling function

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Gets the instance of the collection
  final CollectionReference userOrderCollection = Firestore.instance.collection('UserOrders');

  // Sets initial data
  Future updateUserOrderData(dynamic prodID, dynamic products, String location, int contact, String orderProgress, String userID) async {
    return await userOrderCollection.document(uid).setData({
      'productID': prodID,
      'products': products,
      'location': location,
      'contact': contact,
      'orderProgress': orderProgress,
      'userID': userID,
    });
  }

    // Mapping function
  List<UserOrder> userOrderFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserOrder(
        userID: doc.data['userID'] ?? '',
        prodID: doc.data['prodID'] ?? '',
        location: doc.data['location'] ?? '',
        contact: doc.data['contact'] ?? '',
        progress: doc.data['progress'] ?? '',
      );
    }).toList();
  }

  Stream<List<UserOrder>> get order {
    return userOrderCollection.snapshots()
      .map(userOrderFromSnapshot);
  }

}