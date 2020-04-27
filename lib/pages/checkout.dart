import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/confirmation.dart';

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

      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
                 SizedBox(
                      height: 200.0,
                      child: Image.asset(
                        "images/icons8-checkout-100.png",
                        fit: BoxFit.cover,
                      ),
                    ),

                SizedBox(height: 40.0),

                TextFormField(
          decoration: new InputDecoration(
            hintText: "Delivery Address",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(20.0),
              borderSide: new BorderSide(),
            ),
          ),
          onChanged: (String str) {
            print(str);
          },
        ),

          SizedBox(height: 20.0),


        TextField(
          decoration: new InputDecoration(
            hintText: "Contact number",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(20.0),
              borderSide: new BorderSide(),
            ),
          ),
          keyboardType: TextInputType.number,

          
          onChanged: (String str) {
            print(str);
          },
        ),



             ],
           )

          ),
        )
      ),


      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(16.0),
                    side: BorderSide(color: Colors.transparent)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Confirmation(),
                      ));
                },
                color: Colors.green,
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
