import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var firestore=Firestore.instance;

//=========MyList holds all information about products displayed in Card format============
class RemoveItems extends StatefulWidget {
  @override
  _RemoveItemsState createState() => _RemoveItemsState();
}

class _RemoveItemsState extends State<RemoveItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Remove Products"),
        ),
        body: List_of_Products()
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
                  var ProductPrice=snapshot.data[index].data["price"];
                  String image=snapshot.data[index].data["image"][0];
                  var i=snapshot.data[index].documentID  ;
                  String Quantity=snapshot.data[index].data["quantity"];


                  return ListView (

                    children: <Widget>[

                    Row (
                            children: <Widget>[
                              Padding(
                              padding: const EdgeInsets.all(12.0),
                              
                              
                              //product picture
                              child: Container(
                                alignment: Alignment(-1,0),
                                height: 150,
                                width: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),

                                child: Image.network(image,
                                    width: 120,
                                    fit: BoxFit.fitWidth,),
                              ),
                            ),
                        ),

                        

                        Stack (
                            children: <Widget>[

                            

                            //product name
                            Container(
                              height: 150,
                              child: Align(
                                alignment: Alignment(0,-0.9),
                                child: Text(ProductName)
                              ),
                            ),



                            //product price
                            Container(
                              height: 150,
                              child: Align(
                                alignment: Alignment(0,-0.6),
                                child: Text(ProductPrice),
                              ),
                            ),



                            //product quantity
                            Container(
                              height: 150,
                              child: Align(
                                alignment: Alignment(0,-0.3),
                                child: Text(Quantity),
                              ),
                            ),


                            Container(
                              height: 150,
                              width: 200,
                              child: Align(
                                alignment: Alignment(0.8,-0.1),
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(16.0),
                                      side: BorderSide(color: Colors.black)
                                  ),
                                  color: Colors.white,
                                  child: Text('Delete'),
                                  onPressed: (){
                                    showPopup(context, i);
                                  },
                                ),
                              ),
                            ),



                          ]
                        ),
                      ],
              )
           ] 
         );
        } 
        );
       }
      },
      ),
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