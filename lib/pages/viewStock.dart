import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Firestore"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("newDoc1").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              if (!snapshot.hasData) return Text('No data found!');
              return Card(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                      snapshot.data.documents.map((DocumentSnapshot document){
                        return new Text(document['name']);

                        return new Text(document['price']);
                      }).toList()
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}