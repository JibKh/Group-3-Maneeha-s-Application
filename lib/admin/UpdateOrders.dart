import 'package:first_proj/admin/ViewOrders.dart';
import 'package:first_proj/admin/editOrders.dart';
import 'package:first_proj/util/databaseOrders.dart';
import 'package:first_proj/pages/orderDetails.dart';
import 'package:first_proj/util/loading.dart';
import 'package:first_proj/util/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

var firestore=Firestore.instance;

//=========MyList holds all information about orders displayed in Card format============
class UpdateOrders extends StatefulWidget {
  @override
  _UpdateOrdersState createState() => _UpdateOrdersState();
}

class _UpdateOrdersState extends State<UpdateOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose an Order"),
          centerTitle: true,
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
                    padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                    child: SingleOrder(
                      location: snapshot.data[index].data['location'],
                      contact: snapshot.data[index].data['contact'],
                      products: snapshot.data[index].data['products'],
                      userID: snapshot.data[index].data['userID'],
                      status: snapshot.data[index].data['orderProgress'],
                      orderID: snapshot.data[index].data['orderID'],
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

  String location;
  int contact;
  String userID;
  dynamic products;
  String status;
  int orderID;

  SingleOrder({this.location, this.contact, this.products, this.userID, this.status, this.orderID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 5,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text('User: $userID', style: TextStyle(fontSize: 16,)),
              ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text('Progress: $status', style: TextStyle(fontSize: 16,)),
              ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text('Location: $location', style: TextStyle(fontSize: 16,)),
              ),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text('Contact: $contact', style: TextStyle(fontSize: 16,)),
              ),
              for (var i in products) Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Name: ' + i['name'] + '\nSize: ' + i['size'], style: TextStyle(fontSize: 16)
                  ),),
              )
              // Container(
              //   padding: EdgeInsets.all(5),
              //   alignment: Alignment.centerLeft,
              //   child: Text('Name: $products', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              // ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return Container();//EditOrders(userID: userID, orderID: orderID);
        }));
      },
    );
  }
}