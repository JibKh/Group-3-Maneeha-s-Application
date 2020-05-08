import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {

  int contact;
  String address;
  dynamic products;

  OrderDetails({this.contact, this.address, this.products});

  @override
  _OrderDetailsState createState() => _OrderDetailsState(contact: contact, address: address, products: products);
}

class _OrderDetailsState extends State<OrderDetails> {

  int contact;
  String address;
  dynamic products;

  _OrderDetailsState({this.contact, this.address, this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Order Details",
          style: TextStyle(
            color: Colors.black,
          )
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.9),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text('Contact: \n$contact',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
                ),
              ),

              SizedBox(height: 40,),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text('Address: \n$address',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
                ),
              ),
              SizedBox(height: 40,),

              for (var i in products) Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text('Name: ' + i['name'] + '\nSize:    ' + i['size'], style: TextStyle(fontSize: 28)
                    ),
                  ),
                ),
              )
            ],
          )
        )
      )
    );
  }
}