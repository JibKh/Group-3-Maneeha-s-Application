import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/HomePageTabs.dart';

// The purpose of this page is to create the confirmation page after the checkout is complete

class Confirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
          child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Confirmation",
            style: TextStyle(
              color: Colors.black,
            )),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Align(
          alignment: Alignment(0,-0.2),
                  child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 200.0,
                    child: Image.asset(
                      "images/completed-icon-6.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  new Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Your order has been placed!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new RaisedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (BuildContext context) => HomePageTabs())
                        );
                      },
                      child: Text('Back to homepage'),
                    ),
                  )
                ],
              )
            )
          ),
        )
      ),
    );
  }
}
