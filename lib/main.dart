import 'package:first_proj/pages/cart.dart';
import 'package:flutter/material.dart';
import 'gridProducts.dart';
//import 'homepage.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage()
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    // ======================== START AppBar and Home-Categories BAR ========================
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Center(child: Text('Maneeha\'s', style: TextStyle(color: Colors.black))),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), color: Colors.black, onPressed: () {},),
          ],

          // To create the Home-Categories bar
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Categories'
              )
            ]
          )
        ),
    // ======================== END AppBar and Home-Categories BAR ========================


        // ======================== START NAVIGATION BAR ========================
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(accountName: Text('Jibran Khalil'), accountEmail: Text('jibrankhalilur@outlook.com'), 
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    child: Icon(
                      Icons.person, color: Colors.white,
                    ), 
                    backgroundColor: Colors.grey,
                  ),
                ),
                    decoration: BoxDecoration(
                      color: Colors.pink
                    ),
              ),

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Home Page'),
                  leading: Icon(Icons.home),
                )
              ),

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('My Account'),
                  leading: Icon(Icons.person),
                )
              ),

              InkWell(
                onTap: () {
                  return Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                    var dictToSend = {
                      'name': 'Empty',
                      "size": "Empty",
                      "price": -1,
                    };
                    return ShoppingCart(text: dictToSend,);
                  }));
                },
                child: ListTile(
                  title: Text('Shopping Cart'),
                  leading: Icon(Icons.shopping_cart),
                )
              ),

              Divider(),

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                )
              ),

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.help),
                )
              ),
            ],
          )
        ),

        // ======================== END NAVIGATION BAR ========================


        // ======================== START BODY ========================
        body: ListView(
          children: <Widget>[
            
            // ====== START GRIDVIEW OF PRODUCTS ======
            new Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: 700.0,
              child: GridProducts(),
            ),
            // ====== END GRIDVIEW OF PRODUCTS ======

          ],
        )
      ),
    );
  }
}