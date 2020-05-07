import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_proj/util/userCart.dart';

// PURPOSE:
// This is the file that retrieves and sends mapped out data oF the USER CART to the calling function

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Gets the instance of the collection
  final CollectionReference userCartCollection = Firestore.instance.collection('UserCart');

  // Sets initial data
  Future updateUserCartData(dynamic prodID, dynamic products, String location, int contact, String orderProgress, String userID) async {
    return await userCartCollection.document(uid).setData({
      'productID': prodID,
      'products': products,
      'userID': userID,
    });
  }

  // Mapping function
  List<UserCart> userCartFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserCart(
        prodID: doc.data['productID'] ?? '',
        products: doc.data['products'] ?? '',

      );
    }).toList();
  }

  Stream<List<UserCart>> get cart {
    return userCartCollection.snapshots()
      .map(userCartFromSnapshot);
  }

}