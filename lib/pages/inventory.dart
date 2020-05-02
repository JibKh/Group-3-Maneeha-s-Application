//import 'package:first_proj/pages/addProducts.dart';
import 'package:first_proj/pages/addProducts.dart';
import 'package:flutter/material.dart';

class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add product"),
              onTap: () {
                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddProduct(),
                                  ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.remove),
              title: Text("Remove Product"),
              onTap: () {},
            )
          ]
    );

  }
}