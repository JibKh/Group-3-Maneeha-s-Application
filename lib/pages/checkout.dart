import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  final String res = "";
  final text;
  Checkout({Key key, @required this.text}) : super(key: key);
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
        title: Text("Checkout",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: EdgeInsets.all(10),
           child: new TextFormField(
          decoration: new InputDecoration(
            hintText: "Delivery Address",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
          onChanged: (String str) {
            print(str);
          },
        ),

      )




      // body: Center(
      //   child: new TextFormField(
      //     decoration: new InputDecoration(
      //       hintText: "Delivery Address",
      //       border: new OutlineInputBorder(
      //         borderRadius: new BorderRadius.circular(25.0),
      //         borderSide: new BorderSide(),
      //       ),
      //     ),
      //     onChanged: (String str) {
      //       print(str);
      //     },
      //   ),
      // ),
    );
  }
}
