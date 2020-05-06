import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proj/pages/confirmation.dart';

// The purpose of this page is to create the checkout page

class Checkout extends StatelessWidget { 
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
          "Checkout",
          style: TextStyle(
            color: Colors.black,
          )
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),

              // ================== START DELIVERY INFORMATION ==================
              // Heading
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
              
              // Heading
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cart Summary: ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 1,),
                ),
              ),

              // ===== Start List view builder of items =====

              ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildCard(
                        prodName: 'Generic Coat',
                        prodPrice: '600',
                        prodSize: 'Small',
                        prodQuantity: '2',
                      ),
                    );
                  },
                )
                // ===== End List view builder of items =====
              // ================== END SUMMARY ==================
            ],
          ),
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class BuildCard extends StatelessWidget {

  String prodName;
  String prodPrice;
  String prodSize;
  String prodQuantity;

  BuildCard({this.prodName, this.prodPrice, this.prodQuantity, this.prodSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        // IMAGE
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment(-1,0),
            height: 130,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset('images/cute-cheap-clothes-under-50.jpeg'),
            ),
          ),
        ),

        // INFORMATION
        Stack(
          children: <Widget>[
            // NAME
            Container(
              height: 150,
              child: Align(
                alignment: Alignment(0,-0.9),
                child: Text('Generic Coat', style: TextStyle(fontSize: 17,)),
              ),
            ),

            // PRICE
            Container(
              height: 150,
              child: Align(
                alignment: Alignment(0,-0.6),
                child: Text('PKR 600', style: TextStyle(fontSize: 17,)),
              ),
            ),

            // SIZE
            Container(
              height: 150,
              child: Align(
                alignment: Alignment(0,-0.1),
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5),
                      side: BorderSide(color: Colors.black)
                  ),
                  color: Colors.white,
                  child: Text('Size'),
                  onPressed: (){},
                ),
              ),
            ),

            // QUANTITY
            Container(
              height: 150,
              child: Align(
                alignment: Alignment(0,1),
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5),
                    side: BorderSide(color: Colors.black)
                  ),
                  color: Colors.white,
                  child: Text('Quantity'),
                  onPressed: (){},
                ),
              ),
            ),
          ],
        ),
      ],
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