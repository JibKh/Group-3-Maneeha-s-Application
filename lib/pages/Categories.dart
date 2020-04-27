import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Category(
            imageLocation: 'images/pic1.jpg',
            imageCaption: 'Shirts',
          ),
          Category(
            imageLocation: 'images/pic2.jpg',
            imageCaption: 'Pants',
          ),
          Category(
            imageLocation: 'images/pic3.jpg',
            imageCaption: 'Skirts',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  Category({this.imageLocation, this.imageCaption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Container(
              width: 400,
              child: Container(
                child: Image.asset(
                  imageLocation,
                  width: 200.0,
                  height: 130.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 50,
              child: Container(
                height: 35,
                width: 400,
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            Positioned(
              top: 55,
              left: 10,
              child: Align(
                alignment: Alignment(-0.8, 0),
                child: Text(
                  imageCaption,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
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

/* child: Container(
      width: 200.0,
      child: ListTile(
        title: Image.asset(image_location,
        width: 200.0 ,height: 130.0,fit: BoxFit.fill,),
        subtitle: Container(
          alignment: Alignment.centerLeft,
          child: Text(image_caption,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold ),),

        ),
      ),
    ),
    ),*/
