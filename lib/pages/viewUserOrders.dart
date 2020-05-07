import 'package:first_proj/util/databaseOrders.dart';
import 'package:first_proj/util/loading.dart';
import 'package:first_proj/util/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ListOfOrders extends StatefulWidget {

  var user;
  ListOfOrders({this.user});

  @override
  _ListOfOrdersState createState() => _ListOfOrdersState();
}

class _ListOfOrdersState extends State<ListOfOrders> {

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("UserOrders").getDocuments();
    return qn.documents;
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Order>>.value(
      value: DatabaseService().order,
      child: FutureBuilder(
        future: getPosts(),
        builder: (_, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            // Shows a loading screen while waiting
            return Loading();
          } else {
            int index1;
            for (int i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i].data['userID'] == widget.user.uid) {
                index1 = i;
                break;
              }
            }
            return Scaffold (
              appBar: AppBar(
                title: Text("View My Orders"),
              ),
              body: GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(snapshot.data[index1].data['products'].length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9, vertical: 0),
                    child: SingleOrder(
                      userID: snapshot.data[index1].data['userID'],
                      location: snapshot.data[index1].data['location'],
                      contact: snapshot.data[index1].data['contact'],
                      products: snapshot.data[index1].data['products'][index]['name'],
                      size: snapshot.data[index1].data['products'][index]['size'],
                    )
                  );
                })
              )
            );
          }
        }
      )
    );
  }
}

class SingleOrder extends StatelessWidget {

  String userID;
  String location;
  int contact;
  String products;
  String size;

  SingleOrder({this.userID, this.location, this.contact, this.products, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text('UserID: $userID', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text('Location: $location', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text('Contact: $contact', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text('Name: $products', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text('Size: $size', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    ),
    );
  }
}