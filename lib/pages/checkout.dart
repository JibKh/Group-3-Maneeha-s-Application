import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/confirmation.dart';

// The purpose of this page is to create the checkout page

class Checkout extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // AppBar starts
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          //on pressing the back button, the user returns to the previous screen
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
          )
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      // AppBar ends

      body: SingleChildScrollView(
        //container starts
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),

            //column starts
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                Padding(padding: EdgeInsets.all(10)),

                // ================== START DELIVERY INFORMATION ==================
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Delivery Information: ',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 1,),
                  ),
                ),

                SizedBox(height: 30,),

                // House and street textfield
                TextFormField(
                  decoration: new InputDecoration(
                    hintText: "House and Street",
                  ),
                  onChanged: (String str) {
                    print(str);
                  },
                ),

                SizedBox(height: 20,),

                // City and Province Textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: new InputDecoration(
                          hintText: "City",
                        ),
                        onChanged: (String str) {
                          print(str);
                        },
                      ),
                    ),
                    SizedBox(width: 25,),
                    Expanded(
                      child: TextFormField(
                        decoration: new InputDecoration(
                          hintText: "Province",
                        ),
                        onChanged: (String str) {
                          print(str);
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.0),
                
                // Contact Number textfield
                TextField(
                  decoration: new InputDecoration(
                    hintText: "Contact number",
                  ),
                  keyboardType: TextInputType.number,
                    onChanged: (String str) {
                    print(str);
                  },
                ),
                // ================== END DELIVERY INFORMATION ==================

                // ================== START SUMMARY ==================
                
                SizedBox(height: 50,),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Cart Summary: ',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 1,),
                  ),
                ),
                
              ],
            )
            //column ends
          ),
        )
        //container ends
      ),

      //bottom bar starts
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

// Bottom Navigation for Shopping cart button and size dropdown
class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: InkWell(
          onTap: () {
            // CALL ADD TO CART PAGE USING THE FUNCTION ABOVE
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              Confirmation()), (Route<dynamic> route) => false);
          },
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Center(
              child: Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  wordSpacing: 2.0,
                  letterSpacing: 0.9,
                ),
              ),
            )
          ),
        )
      ),
    );
  }
}