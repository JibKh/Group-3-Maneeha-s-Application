import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          title: Text("Products List"),
        ),
        body: List_of_Orders()
    );
  }
}

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
// ====================WE GOT THE DATA FROM DATABASE NOW WE WILL DISPLAY IT===============
                  String status=snapshot.data[index].data["status"];
////                int price=snapshot.data[index].data["price"];
//                  String image=snapshot.data[index].data["image"];
                  var i=snapshot.data[index].documentID  ;
//                print(i);
//
////                String quantity=snapshot.data[index].data["quantity"];
                  return ListTile(

                    title: Text(status),
                    onTap: ()=> showPopup(context,i),

                  );

                } );
          }
        },),
    );
  }
}
void showPopup(context,i)
{
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Order Delivered"),
        content: new Text("Are you sure you want to change status to completed"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("Accept"),
            onPressed: () {
//              we have document id as i
              Firestore.instance.collection("Orders").document(i).updateData({"status":"Completed"});
            },
          )
        ],
      );
    },
  );
}