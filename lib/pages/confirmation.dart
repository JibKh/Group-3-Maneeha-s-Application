import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// The purpose of this page is to create the confirmation page after the checkout is complete

class Confirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            //on pressing the back button, the user returns to the previous screen
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Confirmation",
              style: TextStyle(
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
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
                      alignment: Alignment(0, 0),
                      child: Text(
                        "Congratulations! Your order has been placed.",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ],
                ))));
  }
}
