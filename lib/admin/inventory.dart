import 'package:first_proj/admin/EditProducts.dart';
import 'package:first_proj/admin/addProducts.dart';
import 'package:first_proj/admin/viewStock.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/admin/removeProducts.dart';

class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//=========================shows the add product screen===========================
    return ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add product"),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
//            ======================REDIRECTS YOU TO ADDPRODUCTS.DART=================

                builder: (context) => AddProduct(),

              ));
            },
          ),

          Divider(),
//  =====================remove product page================================================
          ListTile(
            leading: Icon(Icons.remove),
            title: Text("Remove Product"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
// ============================Redirects you removeProducts.dart============================
                    builder: (context) => RemoveItems(),
                  ));
            },
          ),

          Divider(),
// ===========================shows you current stock======================================
          ListTile(
            leading: Icon(Icons.view_agenda),
            title: Text("View Stock"),
            onTap: () {
              Navigator.push( context, MaterialPageRoute(
//  ===========================takes you to view stock page======================
                builder: (context) => MyList(),
              ));
            },
          ),

          Divider(),
          // ===========================shows you edit products======================================
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Edit Products"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
//    ==========================TAKES U TO EDIT PRODUCTS.DART=============
                    builder: (context) => EditProducts(),
                  ));
            },
          ),
        ]
    );

  }
}

