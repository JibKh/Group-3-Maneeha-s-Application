import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          title: Text("View Orders"),
        ),
        body: List_of_Orders()
    );
  }
}

//==================DISPLAYING ORDERS IN A LIST FORMAT======================
class List_of_Orders extends StatefulWidget {
  @override
  _List_of_OrdersState createState() => _List_of_OrdersState();
}

class _List_of_OrdersState extends State<List_of_Orders> {
  @override

//  =========getting orders from database===============================

  Future getOrders() async{

    QuerySnapshot snap= await firestore.collection("Orders").getDocuments();
    return snap.documents;

  }

  Widget build(BuildContext context) {

    return Container(
//      ==============taking the values from the database and displaying them============
      child: FutureBuilder(future:getOrders(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child:Text("Loading"));
          }
          else {
            print("heloo");
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder:(context,index){

// =========================we got the order info now we will display it==================

                  String Ostatus=snapshot.data[index].data["status"];
                  String Oaddress=snapshot.data[index].data["address"];
                  String Ocontact=snapshot.data[index].data["contact"];
                  String Opn=snapshot.data[index].data["product name"];

                  print(Ostatus);
                  print(Oaddress);
                  print(Ocontact);
                  print(Opn);
//                print(i);
//
////                String quantity=snapshot.data[index].data["quantity"];
                  return ListView(

                    children: <Widget>[

                    Row (
                            children: <Widget>[
                        

                        Stack (
                            children: <Widget>[

                            

                            //status
                            Container(
                              height: 150,
                              child: Align(
                                alignment: Alignment(0,-0.9),
                                child: Text(Ostatus)
                              ),
                            ),



                            //address
                            Container(
                              height: 150,
                              child: Align(
                                alignment: Alignment(0,-0.6),
                                child: Text(Oaddress),
                              ),
                            ),



                            //contact
                            Container(
                              height: 150,
                              child: Align(
                                alignment: Alignment(0,-0.3),
                                child: Text(Ocontact),
                              ),
                            ),



                            //product name
                            Container(
                              height: 150,
                              child: Align(
                                alignment: Alignment(0,-0.1),
                                child: Text(Opn),
                              ),
                            ),


                          ]
                        ),
                      ],
              )
           ]

                  );

                } );
          }
        },),
    );
  }
}
