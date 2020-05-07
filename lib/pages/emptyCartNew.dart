
import 'package:flutter/material.dart';

class EmptyCart extends StatefulWidget {
  @override
  _EmptyCartState createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========== START APP BAR ===========
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "My Cart - Empty",
              style: TextStyle(
                color: Colors.black,
              )
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          // =========== END APP BAR ===========
    );
  }
}