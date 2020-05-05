import 'package:flutter/material.dart';
import 'UpdateOrders.dart';
import 'ViewOrders.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
          children: <Widget>[
//  ===========================shows you orders===================
            ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text("View Orders"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
//  ===========================takes u to ViewOrders Page========================
                      builder: (context) => ViewOrders(),
                    ));
              },
            ),
            Divider(),


//  =========================shows update orders===============================
            ListTile(
              leading: Icon(Icons.update),
              title: Text("Update Orders"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
//  ==========================takes u to UpdateOrders PAGE=========================
                      builder: (context) => UpdateOrders(),
                    ));
              },
            ), 
          ]
    );

  }
}

