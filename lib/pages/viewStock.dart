import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var firestore=Firestore.instance;

//=========MyList holds all information about products displayed in Card format============
class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products List"),
      ),
      body: List_of_Products()
    );
  }
}

//==========DISPLAYS LIST OF PRODUCTS==================================================
class List_of_Products extends StatefulWidget {
  @override
  _List_of_ProductsState createState() => _List_of_ProductsState();
}

class _List_of_ProductsState extends State<List_of_Products> {
  @override

//  =========getting products from database===============================

  Future getProducts() async{

    QuerySnapshot snap= await firestore.collection("Products").getDocuments();
    return snap.documents;

  }

  Widget build(BuildContext context) {

    return Container(
//      ==============taking the values from the database and displaying them============
      child: FutureBuilder(future:getProducts(),
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
//  =====================WE HAVE THE PRODUCTS NOW WE WILL DISPLAY THEM===============

                String ProductName=snapshot.data[index].data["name"];
////                int price=snapshot.data[index].data["price"];
                String image=snapshot.data[index].data["image"];
                var i=snapshot.data[index].documentID  ;
//                print(i);
//
////                String quantity=snapshot.data[index].data["quantity"];
                return ListTile(
                  leading: Image.network(image,
                    width: 120,
                  fit: BoxFit.fitWidth,),
                  title: Text(ProductName ),


                );

            } );
          }
      },),
    );
  }
}
