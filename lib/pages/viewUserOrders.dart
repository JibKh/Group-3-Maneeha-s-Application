import 'package:first_proj/pages/orderDetails.dart';
import 'package:first_proj/util/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfOrders extends StatefulWidget {

  var user;
  ListOfOrders({this.user});

  @override
  _ListOfOrdersState createState() => _ListOfOrdersState();
}

class _ListOfOrdersState extends State<ListOfOrders> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('UserOrders').document(widget.user.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else {
          return Scaffold(
            // =========== START APP BAR ===========
            appBar: AppBar(
              leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                "My Cart",
                style: TextStyle(
                  color: Colors.black,
                )
              ),
              centerTitle: true,
              backgroundColor: Colors.white.withOpacity(0.90),
            ),
            // =========== END APP BAR ===========

            // ================= START LIST VIEW =================
            body: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(snapshot.data['orders'].length, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  child: SingleOrder(
                    //userID: snapshot.data['orders'][index]['userID'],
                    location: snapshot.data['orders'][index]['location'],
                    contact: snapshot.data['orders'][index]['contact'],
                    products: snapshot.data['orders'][index]['products'],
                    //size: snapshot.data['orders'][index]['products'][0]['size'],
                  )
                );
              }
              )
            ),
          );
        }
      }
    );
  }
}

class SingleOrder extends StatelessWidget {

  String location;
  int contact;
  dynamic products;

  SingleOrder({this.location, this.contact, this.products});

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
          return OrderDetails(contact: contact, address: location, products: products,);
        }));
      },
    );
  }
}