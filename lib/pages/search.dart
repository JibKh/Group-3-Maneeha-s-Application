import 'package:first_proj/util/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:first_proj/util/product.dart';
import 'package:first_proj/pages/productDetails.dart';
import 'package:first_proj/util/databaseProduct.dart';

class Search extends SearchDelegate<String> {

  Future getPosts(String val) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Products')
      .getDocuments();
      return qn.documents;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = "";
      },),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty ? 
      ListView.builder(itemBuilder: (context, index) => ListTile(
        title: Text('Search for some shoes?'),),
      itemCount: 1,
      ) 
      :
      StreamProvider<List<Product>>.value(
        value: DatabaseService().prods,
        child: FutureBuilder(
          future: getPosts(query),
          builder: (_, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            } else {
              List output = [];
              for (var x in snapshot.data) {
                if(x.data['searchKey'].contains(query)){
                  output.add(x.data['shortDesc']);
                }
              }
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.shop),
                  title: Text(output[index]),
                ),
                itemCount: output.length,
              );
            }
          }
        )
      );
  }

}


// Future getPosts() async {
//     var firestore = Firestore.instance;
//     QuerySnapshot qn = await firestore.collection('Products')
//       .where('searchKey', arrayContains: 'jeans').getDocuments();
//       return qn.documents;
//   }