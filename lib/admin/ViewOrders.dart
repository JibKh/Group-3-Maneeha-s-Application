import 'package:first_proj/util/databaseOrders.dart';
import 'package:first_proj/util/loading.dart';
import 'package:first_proj/util/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

var firestore=Firestore.instance;

//=========MyList holds all information about orders displayed in Card format============
class ViewOrders extends StatefulWidget {
  @override
  _ViewOrdersState createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Orders - Backend working"),
        ),
        body: ListOfOrders()
    );
  }
}

class ListOfOrders extends StatefulWidget {
  @override
  _ListOfOrdersState createState() => _ListOfOrdersState();
}

class _ListOfOrdersState extends State<ListOfOrders> {

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Orders").getDocuments();
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
            return Scaffold (
              body: GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(snapshot.data.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9, vertical: 0),
                    child: SingleOrder(
                      userID: snapshot.data[index].data['userID'],
                      location: snapshot.data[index].data['location'],
                      contact: snapshot.data[index].data['contact'],
                      products: snapshot.data[index].data['products'],
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
  dynamic products;

  SingleOrder({this.userID, this.location, this.contact, this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
        height: 100.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text('UserID: /$userID', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text('Location: /$location', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text('Contact: /$contact', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    ),
    );
  }
}