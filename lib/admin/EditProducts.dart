import 'package:first_proj/util/gridProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var firestore=Firestore.instance;

//=========MyList holds all information about products displayed in Card format============
class EditProducts extends StatefulWidget {
  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Products"),
      ),
      body: GridProducts.admin('adminEdit'), // This takes you to util/gridProducts.dart. Line 198 is the Edit Button. Add your function there.
    );
  }
}

//================DISPLAYS LIST OF PRODUCTS==========================

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

// =========================we have the data. store it in values and display it===========

                  String ProductName=snapshot.data[index].data["name"];
                  String ProductPrice=snapshot.data[index].data["price"];
                  String image=snapshot.data[index].data["image"][0];
                  var i=snapshot.data[index].documentID  ;
                  String Quantity=snapshot.data[index].data["stock"];
                  String Category=snapshot.data[index].data["category"];
                  return ListTile(
                    leading: Image.network(image,
                      width: 120,
                      fit: BoxFit.fitWidth,),
                    title: Text(ProductName),
// ======================OVER HERE YOU WILL ACCES EDIT PRODUCTS PAGE AND EDIT THE PRODCUT INFO====
                    onTap: ()=>{},



                  );

                } );
          }
        },),
    );
  }
}

//==============FUNCTION TO SHOW POP UP=================================================
void showPopup(context,i)
{
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Removing Product"),
        content: new Text("Are you sure you want to remove Product"),
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
              Firestore.instance.collection("Products").document(i).delete();
            },
          )
        ],
      );
    },
  );
}