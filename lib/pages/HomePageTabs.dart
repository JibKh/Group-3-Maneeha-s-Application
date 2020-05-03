import 'package:first_proj/pages/admin.dart';
import 'package:first_proj/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/homepage.dart';
import 'package:first_proj/pages/Categories.dart';
import 'package:first_proj/pages/cart.dart';
import 'package:first_proj/util/firebase_auth.dart';

// PURPOSE:
// App bar
// Tabbar (home-categories bar) - Redirects to the homepage or categories page
// Navigation bar 

class HomePageTabs extends StatefulWidget {
  @override
  _HomePageTabsState createState() => _HomePageTabsState();
}

class _HomePageTabsState extends State<HomePageTabs> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        // ======================== START of APP BAR and HOME - CATEGORIES BAR ========================

        appBar: AppBar(
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: 
          Center(child: Text('Maneeha\'s', style: TextStyle(color: Colors.black))),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), color: Colors.black, onPressed: () {
              showSearch(context: context, delegate: Search());
            },),
          ],


          // Creates the Home-Categories bar
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(text: 'Home',),
              Tab(text: 'Categories')
            ]
          )
        ),

        // Redirects to Homepage or Categories page
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            Categories(),
          ],
        ),



        
                      //TEMPORARILY ADDED
                          floatingActionButton: new FloatingActionButton(
                            elevation: 0.0,
                            child: new Icon(Icons.person),
                            backgroundColor: new Color(0xFFE57373),
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Admin(),
                                  ));
                            }
                          ),

        // ======================== END APP BAR and HOME - CATEGORIES BAR ========================

      // ======================== START NAVIGATION BAR ========================
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Jibran Khalil'), accountEmail: Text('jibrankhalilur@outlook.com'), 
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
                title: Text('Home'),
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
                    'name': '-1',
                    "size": "-1",
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

            Divider(),

            InkWell(
              onTap: () async {
                Navigator.pop(context);
                await _auth.signOut();
              },
              child: ListTile(
                title: Text('Log Out'),
                leading: Icon(Icons.help),
              )
            ),
          ],
        )
      ),

      // ======================== END NAVIGATION BAR ========================

      ),
    );
  }
}